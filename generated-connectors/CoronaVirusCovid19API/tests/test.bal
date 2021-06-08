import ballerina/log;
import ballerina/test;


ClientConfig testConf = {
    authConfig :{
        username: "<username>",
        password: "<password>"
    }
};

string country = "sri-lanka";

Client myclient = check new (testConf);

@test:Config{}
function testCurrentCovidData(){
    Summary|error result = myclient->getSummary();
    if result is Summary{
        Global? global = result?.Global;
        log:printInfo("Summary " + global.toString());

    }else{
        log:printError(result.message());
        test:assertFail(result.toString());
    }
}

@test:Config{}
function testCountryList(){
    Country[]|error result = myclient->getCountries();
    if result is Country[]{
        log:printInfo("Number of Countries " + result.length().toString());

    }else{
        log:printError(result.message());
        test:assertFail(result.toString());
    }
}

@test:Config{}
function testgetStatusByCountry(){
    CountryDayOne[]|error result = myclient->getConfirmedStatusByCountry(country);
    if result is CountryDayOne[]{
        int length = result.length();
        log:printInfo("Status of Sri Lanka Today : " + result[length-1].toString());

    }else{
        log:printError(result.message());
        test:assertFail(result.toString());
    }
}