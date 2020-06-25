-- List the event number, event date, status, and estimated cost of events where there is an event plan managed 
-- by Mary Manager and the event is held in the basketball arena in the period October 1 to December 31, 2018. 
-- Your query must not use the facility number (“F101”) of the basketball arena or the employee number (“E101”) 
-- of “Mary Manager” in the WHERE clause. Thus, the WHERE clause should not have conditions involving the facility 
-- number or employee number compared to constant values.

SELECT public."EventRequest".eventno, public."EventRequest".dateheld, public."EventRequest".status, public."EventRequest".estcost,
	public."Employee".empname, public."Facility".facname
FROM public."EventRequest" INNER JOIN public."EventPlan" ON
	public."EventRequest".eventno = public."EventPlan".eventno INNER JOIN public."Employee" ON
	public."EventPlan".empno = public."Employee".empno INNER JOIN public."Facility" ON
	public."EventRequest".facno = public."Facility".facno
WHERE public."Employee".empname = 'Mary Manager' AND (public."EventRequest".dateheld BETWEEN '2018-10-1' AND '2018-12-31') AND
	public."Facility".facname = 'Basketball arena'