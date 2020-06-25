-- List all columns of the resource table with a rate between $10 and $20. Sort the result by rate.

SELECT rate
FROM public."ResourceTbl"
WHERE rate::numeric BETWEEN 10 and 20
ORDER BY rate


	