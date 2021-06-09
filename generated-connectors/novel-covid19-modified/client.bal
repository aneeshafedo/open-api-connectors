import  ballerina/http;
import  ballerina/url;
import  ballerina/lang.'string;

public client class Client {
    http:Client clientEp;
    public isolated function init(http:ClientConfiguration clientConfig =  {}, string serviceUrl = "https://corona.lmao.ninja") returns error? {
        http:Client httpEp = check new (serviceUrl, clientConfig);
        self.clientEp = httpEp;
    }
    remote isolated function getGlobalStatus(string? yesterday = (), string? twoDaysAgo = (), string? allowNull = ()) returns covidAll|error {
        string  path = string `/v3/covid-19/all`;
        map<anydata> queryParam = {yesterday: yesterday, twoDaysAgo: twoDaysAgo, allowNull: allowNull};
        path = path + getPathForQueryParam(queryParam);
        covidAll response = check self.clientEp-> get(path, targetType = covidAll);
        return response;
    }
    remote isolated function getUSAStatusByState(string states, string? yesterday = (), string? allowNull = ()) returns covidState|error {
        string  path = string `/v3/covid-19/states/${states}`;
        map<anydata> queryParam = {yesterday: yesterday, allowNull: allowNull};
        path = path + getPathForQueryParam(queryParam);
        covidState response = check self.clientEp-> get(path, targetType = covidState);
        return response;
    }
    remote isolated function getStatusByContinent(string continent, string? yesterday = (), string? twoDaysAgo = (), string? strict = (), string? allowNull = ()) returns covidContinent|error {
        string  path = string `/v3/covid-19/continents/${continent}`;
        map<anydata> queryParam = {yesterday: yesterday, twoDaysAgo: twoDaysAgo, strict: strict, allowNull: allowNull};
        path = path + getPathForQueryParam(queryParam);
        covidContinent response = check self.clientEp-> get(path, targetType = covidContinent);
        return response;
    }
    remote isolated function getStatusByCountry(string country, string? yesterday = (), string? twoDaysAgo = (), string? strict = (), string? allowNull = ()) returns covidCountry|error {
        string  path = string `/v3/covid-19/countries/${country}`;
        map<anydata> queryParam = {yesterday: yesterday, twoDaysAgo: twoDaysAgo, strict: strict, allowNull: allowNull};
        path = path + getPathForQueryParam(queryParam);
        covidCountry response = check self.clientEp-> get(path, targetType = covidCountry);
        return response;
    }
    remote isolated function getGlobalStatusInTimeSeries(string? lastdays = ()) returns covidHistoricalAll|error {
        string  path = string `/v3/covid-19/historical/all`;
        map<anydata> queryParam = {lastdays: lastdays};
        path = path + getPathForQueryParam(queryParam);
        covidHistoricalAll response = check self.clientEp-> get(path, targetType = covidHistoricalAll);
        return response;
    }
    remote isolated function getTimeSeriesbycountry(string country, string? lastdays = ()) returns covidHistoricalCountry|error {
        string  path = string `/v3/covid-19/historical/${country}`;
        map<anydata> queryParam = {lastdays: lastdays};
        path = path + getPathForQueryParam(queryParam);
        covidHistoricalCountry response = check self.clientEp-> get(path, targetType = covidHistoricalCountry);
        return response;
    }
    remote isolated function getTimeSeriesByProvince(string country, string province, string? lastdays = ()) returns covidHistoricalProvince|error {
        string  path = string `/v3/covid-19/historical/${country}/${province}`;
        map<anydata> queryParam = {lastdays: lastdays};
        path = path + getPathForQueryParam(queryParam);
        covidHistoricalProvince response = check self.clientEp-> get(path, targetType = covidHistoricalProvince);
        return response;
    }
    remote isolated function getVaccineTrialData() returns vaccines|error {
        string  path = string `/v3/covid-19/vaccine`;
        vaccines response = check self.clientEp-> get(path, targetType = vaccines);
        return response;
    }
    remote isolated function getTotalGlobalVaccineDosesAdministered(string? lastdays = (), string? fullData = ()) returns vaccineCoverage|error {
        string  path = string `/v3/covid-19/vaccine/coverage`;
        map<anydata> queryParam = {lastdays: lastdays, fullData: fullData};
        path = path + getPathForQueryParam(queryParam);
        vaccineCoverage response = check self.clientEp-> get(path, targetType = vaccineCoverage);
        return response;
    }
    remote isolated function getVaccineCoverageByCountry(string country, string? lastdays = (), string? fullData = ()) returns vaccineCountryCoverage|error {
        string  path = string `/v3/covid-19/vaccine/coverage/countries/${country}`;
        map<anydata> queryParam = {lastdays: lastdays, fullData: fullData};
        path = path + getPathForQueryParam(queryParam);
        vaccineCountryCoverage response = check self.clientEp-> get(path, targetType = vaccineCountryCoverage);
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
