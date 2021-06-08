public type Global record {
    int NewConfirmed?;
    int TotalConfirmed?;
    int NewDeaths?;
    int TotalDeaths?;
    int NewRecovered?;
    int TotalRecovered?;
};

public type Country record {
    string Country?;
    string CountryCode?;
    string Slug?;
    string ISO2?;
    int NewConfirmed?;
    int TotalConfirmed?;
    int NewDeaths?;
    int TotalDeaths?;
    int NewRecovered?;
    int TotalRecovered?;
    string Date?;
};

public type CountryDayOne record {
    string Country?;
    string CountryCode?;
    string Lat?;
    string Lon?;
    int Cases?;
    string Status?;
    string Date?;
};

public type Summary record {
    Global Global?;
    Country[] Countries?;
};

public type Error record {
    string name?;
};
