-- Create a table for titles of retring employees by joining the employees and titles tables
SELECT emp.emp_no,
	emp.first_name,
	emp.last_name,
	ti.title,
	ti.from_date,
	ti.to_date
INTO retirement_titles
From employees as emp
INNER JOIN titles as ti
ON emp.emp_no = ti.emp_no
WHERE (emp.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
INTO unique_titles
FROM retirement_titles
ORDER BY emp_no, to_date DESC;

-- Create a Retiring Titles table that contains the number of titles filled by employees who are retiring
SELECT COUNT(emp_no), title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY count DESC

-- Create a Mentorship Eligibility table for current employees who were born between January 1, 1965 and December 31, 1965.
SELECT DISTINCT ON(e.emp_no) e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	ti.title
INTO mentorship_eligibility
FROM employees AS e
INNER JOIN dept_emp AS de
ON (e.emp_no = de.emp_no)
INNER JOIN titles AS ti
ON (e.emp_no = ti.emp_no)
WHERE (de.to_date = '9999-01-01')
	AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no, de.to_date DESC;


--ADDITIONAL QUERIES SUPPLIMENTAL TO INITIAL CHALLENGE ANALYSIS
-- Redo second table for deliverable 1 to account for ONLY current employees
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
INTO current_unique_titles
FROM retirement_titles 
WHERE (to_date = '9999-01-01')
ORDER BY emp_no, to_date DESC;

-- Redo third table for deliverable 1 to account for ONLY current employees
SELECT COUNT(emp_no), title
INTO current_retiring_titles
FROM current_unique_titles
GROUP BY title
ORDER BY count DESC

--Expand parameters for mentorship program
SELECT DISTINCT ON(e.emp_no) e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	ti.title
INTO expanded_mentorship_eligibility
FROM employees AS e
INNER JOIN dept_emp AS de
ON (e.emp_no = de.emp_no)
INNER JOIN titles AS ti
ON (e.emp_no = ti.emp_no)
WHERE (de.to_date = '9999-01-01')
	AND (e.birth_date BETWEEN '1963-01-01' AND '1965-12-31')
ORDER BY e.emp_no, de.to_date DESC;

--number of current employees
SELECT COUNT(emp_no)
FROM dept_emp
WHERE (to_date = '9999-01-01')

-- Number of original list of retiring employees
SELECT COUNT (emp_no)
FROM unique_titles

-- Number of new list of current retiring employees
SELECT COUNT (emp_no)
FROM current_unique_titles

-- Number of mentorship eligibility
SELECT COUNT (emp_no) FROM mentorship_eligibility