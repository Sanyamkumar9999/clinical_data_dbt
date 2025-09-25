{{ config(
    materialized = 'table'
) }}

select sponsor_class,
       count_if(upper(latest_overall_status) in ('TERMINATED', 'WITHDRAWN', 'SUSPENDED')) as early_stopped_trials,
       count_if(upper(latest_overall_status) in ('COMPLETED','TERMINATED', 'WITHDRAWN', 'SUSPENDED')) as total_closed_trials,
       div0(early_stopped_trials, total_closed_trials) as proportion_early_stopped 
from {{ref('normalized_phase2_3_interventional')}} 
group by sponsor_class