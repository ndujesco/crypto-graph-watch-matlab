# Crypto Price Viewer App

This MATLAB app allows users to view cryptocurrency prices from a specified URI. Users can input a URI to fetch data, visualize it, and export the resulting plots. 
This is the endpoint used: [https://api.coingecko.com/api/v3/coins/bitcoin/market_chart?vs_currency=usd&days=30](https://api.coingecko.com/api/v3/coins/bitcoin/market_chart?vs_currency=usd&days=30)

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
   - <img width="886" alt="not provided" src="https://github.com/user-attachments/assets/a5d6971d-e272-4cf2-88d9-95965332e10b">

2. **Invalid URL**
   - If the user enters an invalid URL, the app will show:
   - **Message**: "Invalid URL!"
   - **Color**: Red
   - <img width="879" alt="invalid" src="https://github.com/user-attachments/assets/d2453259-cc4a-4859-aaaa-4e85cabaf99a">



3. **No Prices Data Found**
   - If the fetched data does not contain any price information, the app will indicate:
   - **Message**: "No prices data found!"
   - **Color**: Red
   - <img width="803" alt="price data" src="https://github.com/user-attachments/assets/f0af46d9-ae2a-4be3-9878-94b500e3be19">


4. **Fetched Successfully**
   - When the data is successfully fetched and plotted, the app will display:
   - **Message**: "Fetched Successfully!"
   - **Color**: Dark Green
   - <img width="876" alt="without slider" src="https://github.com/user-attachments/assets/88ad430a-65b2-4cb2-b994-78039ab78700">
   - <img width="881" alt="success with slider" src="https://github.com/user-attachments/assets/462e7236-56e3-4e58-bed9-e0cfce3da15e">

5. **Plot Exported Successfully**
   - After a successful export of the plot, the app will notify the user:
   - **Message**: "Plot exported successfully!"
   - **Color**: Dark Green
   - <img width="874" alt="save as pdf" src="https://github.com/user-attachments/assets/d7a74c68-690d-483a-8f34-de7d0bfb9f8c">
   - <img width="803" alt="plot successfully esported" src="https://github.com/user-attachments/assets/6e7ccac8-55b6-463c-8314-2556beb0f408">



## How to Use

1. Enter the desired URI in the input field.
2. Click the "Load" button to fetch data.
3. Use the slider to apply moving average smoothing to the data.
4. Click the "Export" button to save the plot.

## License

This project is licensed under the MIT License.
