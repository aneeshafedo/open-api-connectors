# Open Weather Map Ballerina Connector

Provide current weather data and weather forecasts though Open Weather Map API

## Compatibility

<table>
  <tr>
   <td>Ballerina Language Version
   </td>
   <td>Swan Lake Alpha5
   </td>
  </tr>
  <tr>
   <td>Java Development Kit (JDK) 
   </td>
   <td>11
   </td>
  </tr>
  <tr>
   <td>OpenWeatherMap API 
   </td>
   <td>2.5
   </td>
  </tr>
</table>


# Quickstart

## Authorization

To access the Open Weather API users need to have an API key given by openweathermap.org

To obtain an API Key please follow these steps
* Go to openweathermap.org and create an account
    - You can choose a subscription matching with your requirements
* Go to [My API Keys]("https://home.openweathermap.org/api_keys") and generate a new API Key

Then provide the obtained API Key in client configuration.

### Client configuration

```ballerina
    import ballerinax/openweathermap;

    ApiKeysConfig config = {
        apiKeys : {
            appid : "<your appid>"
        }
    }

    openweathermap:Client myclient = check new openweathermap:Client(config);

};
```

## Module Overview

The Open Weather Map connector consume the data exposed in openweathermap.org. It is currently supporting the following operations.

### Get Curret Weather Data

Can be use to access urrent weather data for any location on Earth including over 200,000 cities.

For more details please check [here]("https://openweathermap.org/current")

```ballerina
    CurrentWeatherData result = check weatherclient->getCurretWeatherData("Colombo");
    log:printInfo("Colombo Current Weather data : " + result.toString());

```

### Get Weather Forecast

Can be use to access current weather, minute forecast for 1 hour, hourly forecast for 48 hours, daily forecast for 7 days and government weather alerts.

For more details please check [here]("https://openweathermap.org/api/one-call-api")

```ballerina
    CurrentWeatherData result = check weatherclient->getWeatherForecast(lat = "6.93194", lon = "79.847778");
    log:printInfo("Colombo Weather Forecast : " + result.toString());
```
    