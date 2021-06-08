import ballerina/test;
import ballerina/log;

Client baseClient = check new Client ();

@test:Config{}
function testGetAll() returns error?{
    GlobalStatus|error result = baseClient->getGlobalStatus();
    if (result is GlobalStatus){
        GeneralStats generalStat = result.data;
        log:printInfo("Total Covid-19 Deaths Worldwide : " + generalStat.death_cases);
    } else {
        test:assertFail(result.message());
    }
}

@test:Config{}
function testSearch() returns error?{
    SearchResult|error result = baseClient->searchByCountryName(countryName = "Sri Lanka", pageNo = 1, pageLimit = 2);
    if (result is SearchResult){
        log:printInfo("Total Deaths in Sri Lanka : " + <string>result.data.rows[0]?.total_deaths);
    } else {
        test:assertFail(result.message());
    }
}
