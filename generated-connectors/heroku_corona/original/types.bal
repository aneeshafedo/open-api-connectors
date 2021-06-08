public type CountryStats record {
    int active_cases?;
    float cases_per_mill_pop?;
    string country;
    string flag?;
    string last_update?;
    int new_cases?;
    int new_deaths?;
    int serious_critical?;
    int total_cases?;
    int total_deaths?;
    string total_recovered?;
};

public type GeneralStats record {
    int cases_with_outcome;
    string created_at?;
    int critical_condition_active_cases;
    int currently_infected;
    int death_cases;
    int death_closed_cases;
    boolean deleted?;
    string id?;
    string last_update;
    int mild_condition_active_cases;
    int recovered_closed_cases;
    int recovery_cases;
    int total_cases;
    string updated_at?;
};
