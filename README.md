# Clinical Trials dbt Project

This dbt project extracts, transforms, and normalizes clinical trial data from raw JSON structures in Snowflake. It focuses on interventional studies in Phase 2 and Phase 3, with sponsor classification and trial metadata enrichment.

## ELT - clinical_dataload_pipeline.ipynb
ELT is perfomed using google colab notebook using below important libraries:
1. api is accessed using requests module
2. free trail snowflake connected using snowflake.connector module
3. Pandas & json modules used for data pull and load (with no logic or transformation).

## tools Used:
1. DBT - Used Free Trial version of DBT cloud
2. snowflake - Used Free Trial version
3. Python IDE - google Colab


## DBT Folder Layout

- `models/clinical_data_studies/normalized_phase2_3_interventional.sql`: Core dbt models for filtering:
- 1. FirstSubmitDate : greater than 2015-01-01
  2. studyType       : INTERVENTIONAL
  3. Phases          : Phase2 & Phase3
- `models/clinical_data_studies/sponsor_class_trials.sql`: for calculating sponsor class based on:
  1. Number of trials that ended early (Terminated, Withdrawn, or Suspended)
  2. Total number of closed trials (Completed + early-stop statuses)
  3. Proportion of early-stopped trials 
- `models/clinical_data_studies/schema.yml`: for NCT_ID constraints as primary key & not null.
- `models/clinical_data_studies/sources.yml`: Source declaration for `raw_ctgov__studies`

## Reproducibility

- models (sponsor_class_trials) use `ref()` for dependency tracking
- Materializations are set to `table` for stable outputs
- Filters are hardcoded for now; can be parameterized via macros or variables


