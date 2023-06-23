# Aidbox FHIR - DBT Sample project

[Docs](https://github.com/Aidbox/dbt-sample-project) | [PowerBI demo](https://app.powerbi.com/view?r=eyJrIjoiOTQ5Y2ZiMWQtYzQyNy00MzY5LWJhMjItNTJhNDM3NmY4MzhjIiwidCI6ImU5YmExNDc0LTA1MzAtNDBjZi1hZTdiLWI5NjBkOWU0M2YyYyIsImMiOjl9) | [Aidbox/dbt_fhir package](https://github.com/Aidbox/dbt_fhir) | [Aidbox](http://www.health-samurai.io/aidbox) 
***
based on Aidbox dbt package

TODO: build doc

## Quick start
- Run aidbox ...
- Load synthea data ...
- Sample project ...
- Connect to aidbox database

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