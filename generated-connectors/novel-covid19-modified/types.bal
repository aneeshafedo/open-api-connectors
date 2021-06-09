public type CovidAll record {
    float updated?;
    float cases?;
    float todayCases?;
    float deaths?;
    float recovered?;
    float todayRecovered?;
    float active?;
    float critical?;
    float casesPerOneMillion?;
    float deathsPerOneMillion?;
    float tests?;
    float testsPerOneMillion?;
    float population?;
    float oneCasePerPeople?;
    float oneDeathPerPeople?;
    float oneTestPerPeople?;
    float activePerOneMillion?;
    float recoveredPerOneMillion?;
    float criticalPerOneMillion?;
    float affectedCountries?;
};

public type CovidState record {
    string state?;
    float updated?;
    float cases?;
    float todayCases?;
    float deaths?;
    float todayDeaths?;
    float active?;
    float casesPerOneMillion?;
    float deathsPerOneMillion?;
    float tests?;
    float testsPerOneMillion?;
    float population?;
};

public type CovidContinent record {
    float updated?;
    float cases?;
    float todayCases?;
    float deaths?;
    float todayDeaths?;
    float recovered?;
    float todayRecovered?;
    float active?;
    float critical?;
    float casesPerOneMillion?;
    float deathsPerOneMillion?;
    float tests?;
    float testsPerOneMillion?;
    float population?;
    string continent?;
    float activePerOneMillion?;
    float recoveredPerOneMillion?;
    float criticalPerOneMillion?;
    record  { float lat?; float long?;}  continentInfo?;
    string[] countries?;
};

public type CovidCountry record {
    float updated?;
    string country?;
    record  { float _id?; string iso2?; string iso3?; float lat?; float long?; string flag?;}  countryInfo?;
    float cases?;
    float todayCases?;
    float deaths?;
    float todayDeaths?;
    float recovered?;
    float todayRecovered?;
    float active?;
    float critical?;
    float casesPerOneMillion?;
    float deathsPerOneMillion?;
    float tests?;
    float testsPerOneMillion?;
    float population?;
    string continent?;
    float oneCasePerPeople?;
    float oneDeathPerPeople?;
    float oneTestPerPeople?;
    float activePerOneMillion?;
    float recoveredPerOneMillion?;
    float criticalPerOneMillion?;
};

public type CovidHistoricalAll record {
    record  { float date?;}  cases?;
    record  { float date?;}  deaths?;
    record  { float date?;}  recovered?;
};

public type CovidHistoricalCountry record {
    string country?;
    string[] province?;
    record  { record  { float date?;}  cases?; record  { float date?;}  deaths?; record  { float date?;}  recovered?;}  timeline?;
};

public type CovidHistoricalProvince record {
    string country?;
    string province?;
    record  { record  { float date?;}  cases?; record  { float date?;}  deaths?; record  { float date?;}  recovered?;}  timeline?;
};

public type Vaccines record {
    string 'source?;
    string totalCandidates?;
    Phases[] phases?;
    Vaccine[] data?;
};

public type Vaccine record {
    string candidate?;
    string mechanism?;
    string[] sponsors?;
    string details?;
    string trialPhase?;
    string[] institutions?;
};

public type Phases record {
    string phase?;
    string candidates?;
};

public type  VaccineCoverage SimpleVaccineTimeline|FullVaccineTimeline;

public type VaccineCountryCoverage record {
    string country?;
    anydata timeline?;
};

public type SimpleVaccineTimeline record {
    float date?;
};

public type FullVaccineTimeline record {
    record  { float total?; float daily?; float totalPerHundred?; float dailyPerMillion?; string date?;} [] fullvaccinetimelinelist;
};
