public type WeatherForecast record {
    float lat?;
    float lon?;
    string timezone?;
    float timezone_offset?;
    ForecastCurrent current?;
    Minutely[] minutely?;
    Hourly[] hourly?;
    Daily[] daily?;
    Alerts[] alerts?;
};

public type Alerts record {
    string sender_name?;
    string event?;
    string description?;
    float 'start?;
    float end?;
    string[] tags?;
};

public type Temp record {
    float day?;
    float min?;
    float max?;
    float night?;
    float eve?;
    float morn?;
};

public type FeelsLike record {
    float day?;
    float night?;
    float eve?;
    float morn?;
};

public type Daily record {
    float dt?;
    Temp temp?;
    FeelsLike feels_like?;
    float moonrise?;
    float moonset?;
    float moon_phase?;
    float pressure?;
    float humidity?;
    float dew_point?;
    float uvi?;
    float clouds?;
    float visibility?;
    float wind_deg?;
    float wind_gust?;
    float pop?;
    Weather[] weather?;
    float rain?;
};

public type Hourly record {
    float dt?;
    float temp?;
    float feels_like?;
    float pressure?;
    float humidity?;
    float dew_point?;
    float uvi?;
    float clouds?;
    float visibility?;
    float wind_deg?;
    float wind_gust?;
    float pop?;
    Weather[] weather?;
    Rain rain?;
};

public type Minutely record {
    float dt?;
    float precipitation?;
};

public type ForecastCurrent record {
    float dt?;
    float sunrise?;
    float sunset?;
    float temp?;
    float feels_like?;
    float pressure?;
    float humidity?;
    float dew_point?;
    float uvi?;
    float clouds?;
    float visibility?;
    float wind_speed?;
    float wind_deg?;
    Weather[] weather?;
    Rain rain?;
    Snow snow?;
};

public type CurrentWeatherData record {
    Coord coord?;
    Weather[] weather?;
    string base?;
    Main main?;
    int visibility?;
    Wind wind?;
    Clouds clouds?;
    Rain rain?;
    Snow snow?;
    int dt?;
    Sys sys?;
    int id?;
    string name?;
    int cod?;
};

public type Coord record {
    float lon?;
    float lat?;
};

public type Weather record {
    int id?;
    string main?;
    string description?;
    string icon?;
};

public type Main record {
    float temp?;
    int pressure?;
    int humidity?;
    float temp_min?;
    float temp_max?;
    float sea_level?;
    float grnd_level?;
};

public type Wind record {
    float speed?;
    int deg?;
};

public type Clouds record {
    int 'all?;
};

public type Rain record {
    int '\3h?;
};

public type Snow record {
    float '\3h?;
};

public type Sys record {
    int 'type?;
    int id?;
    float message?;
    string country?;
    int sunrise?;
    int sunset?;
};
