-- List the event requests with a status of “Approved” or “Denied” and an authorized date in July 2018.
-- Include the event number, authorization date, and status in the output.
-- (Hint: see the examples in Module 4 for date constants in Oracle and MySQL.)

SELECT *
FROM public."EventRequest"
WHERE status IN ('Approved','Denied') AND to_char(dateauth, 'mm/yyyy') = '07/2018'


	