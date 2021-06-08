public type SearchResult record {
    SearchResponse data;
    string status;
};

public type SearchResponse record {
    PaginationMetadata paginationMeta;
    string last_update;
    CountryStats[] rows;
};

public type PaginationMetadata record {
    int currentPage?;
    int currentPageSize?;
    int totalPages?;
    int totalRecords?;
};

public type CountryStats record {
    string active_cases?;
    string cases_per_mill_pop?;
    string country;
    string flag?;
    string new_cases?;
    string new_deaths?;
    string serious_critical?;
    string total_cases?;
    string total_deaths?;
    string total_recovered?;
};

public type GlobalStatus record {
    GeneralStats data;
    string status;
};

public type GeneralStats record {
    string cases_with_outcome;
    string created_at?;
    string critical_condition_active_cases;
    string currently_infected;
    string death_cases;
    string death_closed_cases;
    boolean deleted?;
    string id?;
    string last_update;
    string mild_condition_active_cases;
    string recovered_closed_cases;
    string recovery_cases;
    string total_cases;
    string updated_at?;
};
