-- For each event plan, list the plan number, count of the event plan lines, and sum of the number of resources assigned. 
-- For example, plan number “P100” has 4 lines and 7 resources assigned. 
-- You only need to consider event plans that have at least one line.

SELECT planno,COUNT(planno)::integer AS count_plan_lines,SUM(numberfld)::integer AS sum_resources
FROM public."EventPlanLine"
GROUP BY planno
HAVING COUNT(planno) > 0
