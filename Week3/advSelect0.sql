-- For event requests, list the event number, event date ( eventrequest.dateheld ), 
-- and count of the event plans. Only include event requests in the result if the event request has more 
-- than one related event plan with a work date in December 2018.

SELECT public."EventRequest".eventno, public."EventRequest".dateheld,
	COUNT(public."EventRequest".eventno) AS count_plans,
	public."EventPlan".workdate
FROM public."EventPlan" INNER JOIN public."EventRequest" ON public."EventPlan".eventno = public."EventRequest".eventno
WHERE to_char(public."EventPlan".workdate, 'mm/yyyy') = '12/2018' 
GROUP BY public."EventRequest".eventno, public."EventPlan".workdate
HAVING COUNT(public."EventRequest".eventno) > 1