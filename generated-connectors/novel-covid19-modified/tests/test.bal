import ballerina/test;
import ballerina/log;

Client baseClient = check new Client();

@test:Config{}
function testGetGlobalStatus() returns error?{
    covidAll result = check baseClient->getGlobalStatus();
    log:printInfo("Global Deaths : " + result.toString());
}
@test:Config{}
function testgetUSAStatusByState() returns error?{
    covidState result = check baseClient->getUSAStatusByState("New York");
    log:printInfo("Results : " + result.toString());
}
@test:Config{}
function testGetStatusByContinent() returns error?{
    covidContinent result = check baseClient->getStatusByContinent("Asia");
    log:printInfo("Results : " + result.toString());
}
@test:Config{}
function testgetStatusByCountry() returns error?{
    covidCountry result = check baseClient->getStatusByCountry("LK");
    log:printInfo("Results : " + result.toString());
}
@test:Config{}
function testgetGlobalStatusInTimeSeries() returns error?{
    covidHistoricalAll result = check baseClient->getGlobalStatusInTimeSeries();
    log:printInfo("Results : " + result.toString());
}
@test:Config{}
function testgetTimeSeriesbycountry() returns error?{
    covidHistoricalAll result = check baseClient->getTimeSeriesbycountry("Sri Lanka", "30");
    log:printInfo("Results : " + result.toString());
}
@test:Config{}
function testgetTimeSeriesByProvince() returns error?{
    covidHistoricalProvince result = check baseClient->getTimeSeriesByProvince("China", "hainan");
    log:printInfo("Results : " + result.toString());
}
@test:Config{}
function testgetVaccineTrialData() returns error?{
    vaccines result = check baseClient->getVaccineTrialData();
    log:printInfo("Results : " + result.toString());
}
@test:Config{}
function testgetTotalGlobalVaccineDosesAdministered() returns error?{
    vaccineCoverage result = check baseClient->getTotalGlobalVaccineDosesAdministered();
    log:printInfo("Results : " + result.toString());
}
@test:Config{}
function testgetVaccineCoverageByCountry() returns error?{
    vaccineCountryCoverage result = check baseClient->getVaccineCoverageByCountry("Sri Lanka");
    log:printInfo("Results : " + result.toString());
}

