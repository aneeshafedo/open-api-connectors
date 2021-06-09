public type covidAll record {
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

public type covidState record {
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

public type covidContinent record {
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

public type covidCountry record {
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

public type covidHistoricalAll record {
    record  { float date?;}  cases?;
    record  { float date?;}  deaths?;
    record  { float date?;}  recovered?;
};

public type covidHistoricalCountry record {
    string country?;
    string[] province?;
    record  { record  { float date?;}  cases?; record  { float date?;}  deaths?; record  { float date?;}  recovered?;}  timeline?;
};

public type covidHistoricalProvince record {
    string country?;
    string province?;
    record  { record  { float date?;}  cases?; record  { float date?;}  deaths?; record  { float date?;}  recovered?;}  timeline?;
};

public type vaccines record {
    string 'source?;
    string totalCandidates?;
    phases[] phases?;
    vaccine[] data?;
};

public type vaccine record {
    string candidate?;
    string mechanism?;
    string[] sponsors?;
    string details?;
    string trialPhase?;
    string[] institutions?;
};

public type phases record {
    string phase?;
    string candidates?;
};

public type  vaccineCoverage simpleVaccineTimeline|fullVaccineTimeline;

public type vaccineCountryCoverage record {
    string country?;
    anydata timeline?;
};

public type simpleVaccineTimeline record {
    float date?;
};

public type fullVaccineTimeline record {
    record  { float total?; float daily?; float totalPerHundred?; float dailyPerMillion?; string date?;} [] fullvaccinetimelinelist;
};
