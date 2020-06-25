-- List the plan number, event number, work date, and activity of event plans meeting the following two conditions:
-- (1) the work date is in December 2018 and (2) the event is held in the “Basketball arena”. 
-- Your query must not use the facility number (“F101”) of the basketball arena in the WHERE clause. 
-- Instead, you should use a condition on the FacName column for the value of “Basketball arena”.

SELECT public."EventPlan".planno, public."EventPlan".eventno, public."EventPlan".workdate, public."EventPlan".activity,
	public."EventPlanLine".locno, public."Location".facno, public."Facility".facname
FROM public."EventPlan" INNER JOIN public."EventPlanLine" ON
	public."EventPlan".planno = public."EventPlanLine".planno INNER JOIN public."Location" ON
	public."EventPlanLine".locno = public."Location".locno INNER JOIN public."Facility" ON 
	public."Location".facno = public."Facility".facno
WHERE public."Facility".facname = 'Basketball arena' AND to_char(public."EventPlan".workdate,'mm/yyyy') = '12/2018'