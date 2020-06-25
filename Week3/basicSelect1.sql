-- List the name, department, phone number, and email address of employees with a phone number beginning with “3-”.

SELECT empname, department, phone, email
FROM public."Employee" 
WHERE phone LIKE '3-%'
	