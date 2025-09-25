{{ config(
    materialized = 'table',
    tags = ['clinical_trials', 'phase2_3', 'interventional']
) }}

with source AS (
select 
    raw_json:protocolSection.identificationModule.nctId as nct_id,
    raw_json:protocolSection.statusModule.overallStatus as latest_overall_status,
    raw_json:protocolSection.statusModule.startDateStruct.date as start_date,
    raw_json:protocolSection.statusModule.primaryCompletionDateStruct.date as primary_completion_date,
    raw_json:protocolSection.sponsorCollaboratorsModule.leadSponsor.name as sponsor_name,
    raw_json:protocolSection.sponsorCollaboratorsModule.leadSponsor.class as sponsor_class,
    raw_json:protocolSection.designModule.studyType as studytype,
    raw_json:protocolSection.designModule.phases[0] as phases, 
    raw_json:protocolSection.statusModule.studyFirstSubmitDate as submit_date 
from 
    clinical_db.raw.raw_ctgov__studies
where 
    raw_json:protocolSection.statusModule.studyFirstSubmitDate >= '2015-01-01'
    and raw_json:protocolSection.designModule.studyType = 'INTERVENTIONAL'
    and raw_json:protocolSection.designModule.phases[0] in ('PHASE2', 'PHASE3')
)
    
select * from source
 
 

