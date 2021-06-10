import  ballerina/http;
import  ballerina/url;
import  ballerina/lang.'string;

public type ApiKeysConfig record {
    map<string|string[]> apiKeys;
};

@display {label: "Open Weather Client"}
public client class Client {
    http:Client clientEp;
    map<string|string[]> apiKeys;
    public isolated function init(ApiKeysConfig apiKeyConfig, http:ClientConfiguration clientConfig =  {}, string serviceUrl = "http://api.openweathermap.org/data/2.5/") returns error? {
        http:Client httpEp = check new (serviceUrl, clientConfig);
        self.clientEp = httpEp;
        self.apiKeys = apiKeyConfig.apiKeys;
    }
    @display {label: "Current Weather"}
    remote isolated function getCurretWeatherData(@display {label: "CityName or StateCode or CountryCode"} string? q = (), @display {label: "City Id"} string? id = (), @display {label: "Latitude"} string? lat = (), @display {label: "Longitude"} string? lon = (), @display {label: "Zip Code"} string? zip = (), @display {label: "Units"} string? units = (), @display {label: "Language"} string? lang = (), @display {label: "Mode"} string? mode = ()) returns CurrentWeatherData|error {
        string  path = string `/weather`;
        map<anydata> queryParam = {q: q, id: id, lat: lat, lon: lon, zip: zip, units: units, lang: lang, mode: mode, appid: self.apiKeys["appid"]};
        path = path + getPathForQueryParam(queryParam);
        CurrentWeatherData response = check self.clientEp-> get(path, targetType = CurrentWeatherData);
        return response;
    }
    @display {label: "Weather Forecast"}
    remote isolated function getWeatherForecast(@display {label: "Latitude"} string lat, @display {label: "Longtitude"} string lon, @display {label: "Exclude"} string? exclude = (), @display {label: "Units"} string? units = (), @display {label: "Language"} string? lang = ()) returns WeatherForecast|error {
        string  path = string `/onecall`;
        map<anydata> queryParam = {lat: lat, lon: lon, exclude: exclude, units: units, lang: lang, appid: self.apiKeys["appid"]};
        path = path + getPathForQueryParam(queryParam);
        WeatherForecast response = check self.clientEp-> get(path, targetType = WeatherForecast);
        return response;
    }
}

isolated function  getPathForQueryParam(map<anydata>   queryParam)  returns  string {
    string[] param = [];
    param[param.length()] = "?";
    foreach  var [key, value] in  queryParam.entries() {
        if  value  is  () {
            _ = queryParam.remove(key);
        } else {
            if  string:startsWith( key, "'") {
                 param[param.length()] = string:substring(key, 1, key.length());
            } else {
                param[param.length()] = key;
            }
            param[param.length()] = "=";
            if  value  is  string {
                string updateV =  checkpanic url:encode(value, "UTF-8");
                param[param.length()] = updateV;
            } else {
                param[param.length()] = value.toString();
            }
            param[param.length()] = "&";
        }
    }
    _ = param.remove(param.length()-1);
    if  param.length() ==  1 {
        _ = param.remove(0);
    }
    string restOfPath = string:'join("", ...param);
    return restOfPath;
}
