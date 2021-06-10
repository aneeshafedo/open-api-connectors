import ballerina/test;
import ballerina/log;

Client baseClient = check new Client();

@test:Config{}
function testGetGlobalStatus() returns error?{
    CovidAll result = check baseClient->getGlobalStatus();
    log:printInfo("Global Deaths : " + result.toString());
}
@test:Config{}
function testgetUSAStatusByState() returns error?{
    CovidState result = check baseClient->getUSAStatusByState("New York");
    log:printInfo("Results : " + result.toString());
}
@test:Config{}
function testGetStatusByContinent() returns error?{
    CovidContinent result = check baseClient->getStatusByContinent("Asia");
    log:printInfo("Results : " + result.toString());
}
@test:Config{}
function testgetStatusByCountry() returns error?{
    CovidCountry result = check baseClient->getStatusByCountry("LK");
    log:printInfo("Results : " + result.toString());
}
@test:Config{}
function testgetGlobalStatusInTimeSeries() returns error?{
    CovidHistoricalAll result = check baseClient->getGlobalStatusInTimeSeries();
    log:printInfo("Results : " + result.toString());
}
@test:Config{}
function testgetTimeSeriesBycountry() returns error?{
    CovidHistoricalAll result = check baseClient->getTimeSeriesBycountry("Sri Lanka", "30");
    log:printInfo("Results : " + result.toString());
}
@test:Config{}
function testgetTimeSeriesByProvince() returns error?{
    CovidHistoricalProvince result = check baseClient->getTimeSeriesByProvince("China", "hainan");
    log:printInfo("Results : " + result.toString());
}
@test:Config{}
function testgetVaccineTrialData() returns error?{
    Vaccines result = check baseClient->getVaccineTrialData();
    log:printInfo("Results : " + result.toString());
}
@test:Config{}
function testgetTotalGlobalVaccineDosesAdministered() returns error?{
    VaccineCoverage result = check baseClient->getTotalGlobalVaccineDosesAdministered();
    log:printInfo("Results : " + result.toString());
}
@test:Config{}
function testgetVaccineCoverageByCountry() returns error?{
    VaccineCountryCoverage result = check baseClient->getVaccineCoverageByCountry("Sri Lanka");
    log:printInfo("Results : " + result.toString());
}

