# Aidbox FHIR - DBT Sample project

[Docs](https://aidbox.github.io/dbt-sample-project) | [PowerBI demo](https://app.powerbi.com/view?r=eyJrIjoiOTQ5Y2ZiMWQtYzQyNy00MzY5LWJhMjItNTJhNDM3NmY4MzhjIiwidCI6ImU5YmExNDc0LTA1MzAtNDBjZi1hZTdiLWI5NjBkOWU0M2YyYyIsImMiOjl9) | [Aidbox/dbt_fhir package](https://github.com/Aidbox/dbt_fhir) | [Aidbox](http://www.health-samurai.io/aidbox) 
***

This project demonstrates the work with Aidbox FHIR data with the [Aidbox/dbt_fhir](https://github.com/Aidbox/dbt_fhir) package. In this project, you can find examples how to create a flat representation of FHIR data and building analytical models.

## Quick start
- Run aidbox - Install and run Aidbox following [getting starter](https://docs.aidbox.app/getting-started) guide 
- Load synthetic data usign [Synthea](https://github.com/synthetichealth/synthea) and [Aidbox bulk api](https://docs.aidbox.app/api-1/bulk-api-1)
- Connect to the Aidbox database. Create dbt [connection profile](https://docs.getdbt.com/docs/core/connect-data-platform/connection-profiles) via `~/.dbt/profiles.yml`
  ```yml
  AidboxProject:
    target: dev
    outputs:
      dev:
        type: postgres
        host: "<aidbox_db_host>" 
        port: "<aidbox_db_port>"
        user: "<aidbox_db_user>"
        password: "<aidbox_db_password>" 
        dbname: "<aidbox_db_name>"
        schema: public
        threads: 5
        keepalives_idle: 3 # default 0, indicating the system default. See below
        connect_timeout: 100 # default 10 seconds
        retries: 5  # default 1 retry on error/timeout when opening connections
  ```

## Install

```bash
dbt deps
dbt seed
```



# Features
- Incremental
ts, id
- Parallel optimized
parallel workers
- Dimensional Kimbal model
fact_* and dim_ models
- OLAP Cube examples
marts 
- Cohort analyses
....

## Framework
3 layers
- RAW fhir data
 (here is dbt project with fhir helpers)
- Flat usable views (dimensional/star model)
- Aggregate your date (OLAP cube)

- Flat your data - star model
  - List facts and dimentions
- Create pre aggregated views (cubes)
- Use BI


## Analytics framework ...
- Flat dimentional model ...
- Build CUBE`s data marts ...
- Use cube data mart on BI ...


***
Powered by [Health Samurai](http://www.health-samurai.io) | [Aidbox](http://www.health-samurai.io/aidbox) | [Fhirbase](http://www.health-samurai.io/fhirbase)