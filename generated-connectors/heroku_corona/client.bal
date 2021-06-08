import  ballerina/http;
import  ballerina/url;
import  ballerina/lang.'string;

public client class Client {
    http:Client clientEp;
    public isolated function init(http:ClientConfiguration clientConfig =  {}, string serviceUrl = "http://corona-virus-stats.herokuapp.com/api/v1") returns error? {
        http:Client httpEp = check new (serviceUrl, clientConfig);
        self.clientEp = httpEp;
    }
    remote isolated function searchByCountryName(string? countryName = (), int? pageNo = (), int? pageLimit = ()) returns SearchResult|error {
        string  path = string `/cases/countries-search`;
        map<anydata> queryParam = {countryName: countryName, pageNo: pageNo, pageLimit: pageLimit};
        path = path + getPathForQueryParam(queryParam);
        SearchResult response = check self.clientEp-> get(path, targetType = SearchResult);
        return response;
    }
    remote isolated function getGlobalStatus() returns GlobalStatus|error {
        string  path = string `/cases/general-stats`;
        GlobalStatus response = check self.clientEp-> get(path, targetType = GlobalStatus);
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
