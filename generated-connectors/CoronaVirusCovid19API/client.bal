import  ballerina/http;

public type ClientConfig record {
    http:CredentialsConfig authConfig;
    http:ClientSecureSocket secureSocketConfig?;
};

type CountryArr Country[];

type CountryDayOneArr CountryDayOne[];

@display {label: "covid-19", iconPath: "/path/to/icon"}
public client class Client {
    http:Client clientEp;
    public isolated function init(ClientConfig clientConfig, string serviceUrl = "https://api.covid19api.com") returns error? {
        http:ClientSecureSocket? secureSocketConfig = clientConfig?.secureSocketConfig;
        http:Client httpEp = check new (serviceUrl, { auth: clientConfig.authConfig, secureSocket: secureSocketConfig });
        self.clientEp = httpEp;
    }
    @display {label: "Get Covid-19 info worldwide"}
    remote isolated function getSummary() returns Summary|error {
        string  path = string `/summary`;
        Summary response = check self.clientEp-> get(path, targetType = Summary);
        return response;
    }
    @display {label: "Get list of countries"}
    remote isolated function getCountries() returns CountryArr|error {
        string  path = string `/countries`;
        CountryArr response = check self.clientEp-> get(path, targetType = CountryArr);
        return response;
    }
    @display {label: "Get Covid data by country name"}
    remote isolated function getConfirmedStatusByCountry(@display {label: "Country slug"} string countrySlug) returns CountryDayOneArr|error {
        string  path = string `/dayone/country/${countrySlug}/status/confirmed`;
        CountryDayOneArr response = check self.clientEp-> get(path, targetType = CountryDayOneArr);
        return response;
    }
}
