import ballerina/log;
import ballerina/test;

ApiKeysConfig config = {
    apiKeys : {
        appid : "<appid>"
    }
};

string cityName = "Colombo";
string cityId = "2172797";
string lat = "6.93194";
string lon = "79.847778";
string country = "LK";
string language = "en";
string zipCode = "94040";

Client myclient = check new Client(config);

@test:Config{}
function testGetWeatherByCountryName() returns error?{
    CurrentWeatherData result = check myclient->getCurretWeatherData(cityName);
    log:printInfo("Colombo Current Weather data : " + result.toString());
}
@test:Config{}
function testGetWeatherByLatLon() returns error?{
    CurrentWeatherData result = check myclient->getCurretWeatherData(lat = lat, lon = lon);
    log:printInfo("Current Weather data by city id  : " + result.toString());
}
@test:Config{}
function testGetWeatherByCityId() returns error?{
    CurrentWeatherData result = check myclient->getCurretWeatherData(id=cityId);
    log:printInfo("Current Weather data by Lat & Lon : " + result.toString());
}
@test:Config{}
function testGetWeatherByZip() returns error?{
    CurrentWeatherData result = check myclient->getCurretWeatherData(zip = zipCode);
    log:printInfo("Current Weather data by Lat & Lon : " + result.toString());
}
@test:Config{}
function testGetWeatherForecast() returns error?{
    CurrentWeatherData result = check myclient->getWeatherForecast(lat = lat, lon = lon, exclude = "minutely, hourly", units = "standard", lang = "en");
    log:printInfo("Colombo forecast by Lat & Lon : " + result.toString());
}