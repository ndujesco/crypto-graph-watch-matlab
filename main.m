classdef main < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                matlab.ui.Figure
        Label                   matlab.ui.control.Label
        EnterURIEditField       matlab.ui.control.EditField
        EnterURIEditFieldLabel  matlab.ui.control.Label
        ExportButton            matlab.ui.control.Button
        LoadButton              matlab.ui.control.Button
        Slider                  matlab.ui.control.RangeSlider
        SliderLabel             matlab.ui.control.Label
        EditField               matlab.ui.control.EditField
        UIAxes                  matlab.ui.control.UIAxes
    end

    
    properties (Access = private)
        Times       % Store time data
        Prices      % Store price data
    end
    

    % Callbacks that handle component events
    methods (Access = private)

        % Button pushed function: LoadButton
        function LoadButtonPushed(app, event)

            % Reset the label to ensure it starts clean
            app.Label.HorizontalAlignment = 'center';  % Center the text
            app.Label.Text = '';
            app.Label.FontColor = [0, 0, 0];  % Reset color to black
        
            % Get the URI from the input field
            url = app.EnterURIEditField.Value;
        
            % Check if the URI is provided
            if isempty(url)
                app.Label.Text = 'URL not provided!';
                app.Label.FontColor = 'red';  % Set label color to red
                return;  % Exit the function
            end
        
            % Try fetching data from the URI
            try
                data = webread(url);
        
                % Check if the data contains 'prices'
                if ~isfield(data, 'prices') || isempty(data.prices)
                    app.Label.Text = 'No prices data found!';
                    app.Label.FontColor = 'red';  % Set label color to red
                    return;  % Exit the function
                end
        
                % Extract timestamps (in UNIX time) and prices
                timestamps = data.prices(:,1) / 1000; % Convert to seconds
                prices = data.prices(:,2);
                
                % Convert UNIX time to MATLAB datetime
                times = datetime(timestamps, 'ConvertFrom', 'posixtime');
                
                % Store the data in app properties
                app.Prices = prices;
                app.Times = times;
        
                % Plot the data
                plot(app.UIAxes, times, prices);
                xlabel(app.UIAxes, 'Date');
                ylabel(app.UIAxes, 'Price (USD)');
                title(app.UIAxes, 'Bitcoin Prices over the Last 30 Days');
        
                % Success feedback
                app.Label.Text = 'Fetched Successfully!';
                app.Label.FontColor = [0, 100/255, 0];  % Dark green color

        
            catch
                % Handle error from webread or data processing
                app.Label.Text = 'Invalid URL';
                app.Label.FontColor = 'red';  % Set label color to red
            end
        end

        % Value changing function: Slider
        function SliderValueChanging(app, event)
           % Define a moving average function
            function smoothedData = movingAverage(data, windowSize)
                smoothedData = movmean(data, windowSize); % Use MATLAB's built-in movmean function
            end

            % Call the function with the current value from the event
            changingValue = event.Value;
            smoothedData = movingAverage(app.Prices, changingValue);
            
            % Plot the smoothed data
            plot(app.UIAxes, app.Times, app.Prices);
            hold(app.UIAxes, 'on');
            plot(app.UIAxes, app.Times, smoothedData);
            hold(app.UIAxes, 'off');
            
        end

        % Button pushed function: ExportButton
        function ExportButtonPushed(app, event)
             % Check if data is available
            if isempty(app.Prices) || isempty(app.Times)
                app.Label.Text = 'No data to export!';
                app.Label.FontColor = 'red';  % Set label color to red
                return;
            end
        
            % Prompt user for file name
            [file, path] = uiputfile({'*.png'; '*.jpg'; '*.pdf'; '*.fig'}, 'Save Plot');
            if isequal(file, 0) || isequal(path, 0)
                return;  % User cancelled
            end
        
            % Export the UIAxes to an image or PDF
            exportgraphics(app.UIAxes, fullfile(path, file));
            
            % Success feedback
            app.Label.Text = 'Plot exported successfully!';
            app.Label.FontColor = [0, 100/255, 0];  % Dark green color
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 640 480];
            app.UIFigure.Name = 'MATLAB App';

            % Create UIAxes
            app.UIAxes = uiaxes(app.UIFigure);
            title(app.UIAxes, 'Title')
            xlabel(app.UIAxes, 'X')
            ylabel(app.UIAxes, 'Y')
            zlabel(app.UIAxes, 'Z')
            app.UIAxes.Position = [72 199 498 225];

            % Create EditField
            app.EditField = uieditfield(app.UIFigure, 'text');
            app.EditField.Position = [643 187 10 29];

            % Create SliderLabel
            app.SliderLabel = uilabel(app.UIFigure);
            app.SliderLabel.HorizontalAlignment = 'right';
            app.SliderLabel.Position = [92 141 36 22];
            app.SliderLabel.Text = 'Slider';

            % Create Slider
            app.Slider = uislider(app.UIFigure, 'range');
            app.Slider.ValueChangingFcn = createCallbackFcn(app, @SliderValueChanging, true);
            app.Slider.Position = [150 150 429 3];

            % Create LoadButton
            app.LoadButton = uibutton(app.UIFigure, 'push');
            app.LoadButton.ButtonPushedFcn = createCallbackFcn(app, @LoadButtonPushed, true);
            app.LoadButton.Position = [150 51 100 23];
            app.LoadButton.Text = 'Load';

            % Create ExportButton
            app.ExportButton = uibutton(app.UIFigure, 'push');
            app.ExportButton.ButtonPushedFcn = createCallbackFcn(app, @ExportButtonPushed, true);
            app.ExportButton.Position = [470 51 100 23];
            app.ExportButton.Text = 'Export';

            % Create EnterURIEditFieldLabel
            app.EnterURIEditFieldLabel = uilabel(app.UIFigure);
            app.EnterURIEditFieldLabel.HorizontalAlignment = 'right';
            app.EnterURIEditFieldLabel.Position = [111 441 57 22];
            app.EnterURIEditFieldLabel.Text = 'Enter URI';

            % Create EnterURIEditField
            app.EnterURIEditField = uieditfield(app.UIFigure, 'text');
            app.EnterURIEditField.Position = [190 439 380 27];

            % Create Label
            app.Label = uilabel(app.UIFigure);
            app.Label.Position = [258 43 205 39];
            app.Label.Text = '';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = main

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end