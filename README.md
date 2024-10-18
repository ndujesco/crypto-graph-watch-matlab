# Crypto Price Viewer App

This MATLAB app allows users to view cryptocurrency prices from a specified URI. Users can input a URI to fetch data, visualize it, and export the resulting plots.

## Features

- Fetch cryptocurrency prices from a provided URI
- Visualize the price data over time
- Apply moving average smoothing on the data
- Export plots as images or PDFs

## User Feedback Cases

The app provides feedback based on user actions. Below are the possible feedback messages:

1. **URL Not Provided**
   - When the user does not enter a URL, the app will display:
   - **Message**: "URL not provided!"
   - **Color**: Red
   - {{picture here}}

2. **Invalid URL**
   - If the user enters an invalid URL, the app will show:
   - **Message**: "Invalid URL!"
   - **Color**: Red
   - {{picture here}}

3. **No Prices Data Found**
   - If the fetched data does not contain any price information, the app will indicate:
   - **Message**: "No prices data found!"
   - **Color**: Red
   - {{picture here}}

4. **Fetched Successfully**
   - When the data is successfully fetched and plotted, the app will display:
   - **Message**: "Fetched Successfully!"
   - **Color**: Dark Green
   - {{picture here}}

## How to Use

1. Enter the desired URI in the input field.
2. Click the "Load" button to fetch data.
3. Use the slider to apply moving average smoothing to the data.
4. Click the "Export" button to save the plot.

## License

This project is licensed under the MIT License.
