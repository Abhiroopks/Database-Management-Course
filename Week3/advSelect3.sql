-- List the plan number, line number, resource name, number of resources ( eventplanline.number ), location name, time start, 
-- and time end where the event is held at the basketball arena, the event plan has activity of activity of “Operation”, 
-- and the event plan has a work date in the period October 1 to December 31, 2018. Your query must not use the facility number 
-- (“F101”) of the basketball arena in the WHERE clause. Instead, you should use a condition on the FacName column for the value of 
-- “Basketball arena”.

SELECT "EventPlanLine".planno, "EventPlanLine".lineno, "ResourceTbl".resname, "EventPlanLine".numberfld, "Location".locname,
	"EventPlanLine".timestart,	"EventPlanLine".timeend
FROM "EventPlanLine" INNER JOIN "ResourceTbl" ON
	"EventPlanLine".resno = "ResourceTbl".resno INNER JOIN "Location" ON
	"EventPlanLine".locno = "Location".locno INNER JOIN "Facility" ON
	"Location".facno = "Facility".facno INNER JOIN "EventPlan" ON
	"EventPlanLine".planno = "EventPlan".planno
WHERE "Facility".facname = 'Basketball arena' AND "EventPlan".activity = 'Operation' AND "EventPlan".workdate BETWEEN 
	'2018-10-1' AND '2018-12-31'