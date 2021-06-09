import  ballerina/http;
import  ballerina/url;
import  ballerina/lang.'string;

public client class Client {
    http:Client clientEp;
    public isolated function init(http:ClientConfiguration clientConfig =  {}, string serviceUrl = "https://corona.lmao.ninja") returns error? {
        http:Client httpEp = check new (serviceUrl, clientConfig);
        self.clientEp = httpEp;
    }
    remote isolated function getGlobalStatus(string? yesterday = (), string? twoDaysAgo = (), string? allowNull = ()) returns CovidAll|error {
        string  path = string `/v3/covid-19/all`;
        map<anydata> queryParam = {yesterday: yesterday, twoDaysAgo: twoDaysAgo, allowNull: allowNull};
        path = path + getPathForQueryParam(queryParam);
        CovidAll response = check self.clientEp-> get(path, targetType = CovidAll);
        return response;
    }
    remote isolated function getUSAStatusByState(string states, string? yesterday = (), string? allowNull = ()) returns CovidState|error {
        string  path = string `/v3/covid-19/states/${states}`;
        map<anydata> queryParam = {yesterday: yesterday, allowNull: allowNull};
        path = path + getPathForQueryParam(queryParam);
        CovidState response = check self.clientEp-> get(path, targetType = CovidState);
        return response;
    }
    remote isolated function getStatusByContinent(string continent, string? yesterday = (), string? twoDaysAgo = (), string? strict = (), string? allowNull = ()) returns CovidContinent|error {
        string  path = string `/v3/covid-19/continents/${continent}`;
        map<anydata> queryParam = {yesterday: yesterday, twoDaysAgo: twoDaysAgo, strict: strict, allowNull: allowNull};
        path = path + getPathForQueryParam(queryParam);
        CovidContinent response = check self.clientEp-> get(path, targetType = CovidContinent);
        return response;
    }
    remote isolated function getStatusByCountry(string country, string? yesterday = (), string? twoDaysAgo = (), string? strict = (), string? allowNull = ()) returns CovidCountry|error {
        string  path = string `/v3/covid-19/countries/${country}`;
        map<anydata> queryParam = {yesterday: yesterday, twoDaysAgo: twoDaysAgo, strict: strict, allowNull: allowNull};
        path = path + getPathForQueryParam(queryParam);
        CovidCountry response = check self.clientEp-> get(path, targetType = CovidCountry);
        return response;
    }
    remote isolated function getGlobalStatusInTimeSeries(string? lastdays = ()) returns CovidHistoricalAll|error {
        string  path = string `/v3/covid-19/historical/all`;
        map<anydata> queryParam = {lastdays: lastdays};
        path = path + getPathForQueryParam(queryParam);
        CovidHistoricalAll response = check self.clientEp-> get(path, targetType = CovidHistoricalAll);
        return response;
    }
    remote isolated function getTimeSeriesbycountry(string country, string? lastdays = ()) returns CovidHistoricalCountry|error {
        string  path = string `/v3/covid-19/historical/${country}`;
        map<anydata> queryParam = {lastdays: lastdays};
        path = path + getPathForQueryParam(queryParam);
        CovidHistoricalCountry response = check self.clientEp-> get(path, targetType = CovidHistoricalCountry);
        return response;
    }
    remote isolated function getTimeSeriesByProvince(string country, string province, string? lastdays = ()) returns CovidHistoricalProvince|error {
        string  path = string `/v3/covid-19/historical/${country}/${province}`;
        map<anydata> queryParam = {lastdays: lastdays};
        path = path + getPathForQueryParam(queryParam);
        CovidHistoricalProvince response = check self.clientEp-> get(path, targetType = CovidHistoricalProvince);
        return response;
    }
    remote isolated function getVaccineTrialData() returns Vaccines|error {
        string  path = string `/v3/covid-19/vaccine`;
        Vaccines response = check self.clientEp-> get(path, targetType = Vaccines);
        return response;
    }
    remote isolated function getTotalGlobalVaccineDosesAdministered(string? lastdays = (), string? fullData = ()) returns VaccineCoverage|error {
        string  path = string `/v3/covid-19/vaccine/coverage`;
        map<anydata> queryParam = {lastdays: lastdays, fullData: fullData};
        path = path + getPathForQueryParam(queryParam);
        VaccineCoverage response = check self.clientEp-> get(path, targetType = VaccineCoverage);
        return response;
    }
    remote isolated function getVaccineCoverageByCountry(string country, string? lastdays = (), string? fullData = ()) returns VaccineCountryCoverage|error {
        string  path = string `/v3/covid-19/vaccine/coverage/countries/${country}`;
        map<anydata> queryParam = {lastdays: lastdays, fullData: fullData};
        path = path + getPathForQueryParam(queryParam);
        VaccineCountryCoverage response = check self.clientEp-> get(path, targetType = VaccineCountryCoverage);
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
