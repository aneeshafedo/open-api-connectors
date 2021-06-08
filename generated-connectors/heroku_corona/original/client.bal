import  ballerina/http;
import  ballerina/url;
import  ballerina/lang.'string;

public type ApiKeysConfig record {
    map<string|string[]> apiKeys;
};

type GeneralStatsArr GeneralStats[];

public client class Client {
    http:Client clientEp;
    map<string|string[]> apiKeys;
    public isolated function init(ApiKeysConfig apiKeyConfig, http:ClientConfiguration clientConfig =  {}, string serviceUrl = "http://corona-virus-stats.herokuapp.com/api/v1") returns error? {
        http:Client httpEp = check new (serviceUrl, clientConfig);
        self.clientEp = httpEp;
        self.apiKeys = apiKeyConfig.apiKeys;
    }
    remote isolated function cases_search(string? search = (), int? page = (), int? 'limit = ()) returns record|error {
        string  path = string `/cases/countries-search`;
        map<anydata> queryParam = {search: search, page: page, 'limit: 'limit};
        path = path + getPathForQueryParam(queryParam);
        map<string|string[]> accHeaders = {Authorization: self.apiKeys.get("Authorization")};
        record response = check self.clientEp-> get(path, accHeaders, targetType = record);
        return response;
    }
    remote isolated function 'cases\_general\-stats\_list() returns GeneralStatsArr|error {
        string  path = string `/cases/general-stats`;
        GeneralStatsArr response = check self.clientEp-> get(path, targetType = GeneralStatsArr);
        return response;
    }
    remote isolated function docs_list() returns error? {
        string  path = string `/docs/`;
         _ = check self.clientEp-> get(path, targetType=http:Response);
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
