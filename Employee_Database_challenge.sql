-- Creates table of employees eligible for retirement
SELECT e.emp_no, e.first_name, e.last_name, t.title, t.from_date, t.to_date
INTO retirement_titles
FROM employees as e
INNER JOIN titles as t
    on e.emp_no = t.emp_no
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no ASC;

-- Creates table of employees eligible for retirement without duplicates this time
SELECT 
    DISTINCT ON (e.emp_no) e.emp_no,
    e.first_name,
    e.last_name,
    t.title
INTO unique_titles
FROM employees as e
INNER JOIN titles as t
    on e.emp_no = t.emp_no
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
    AND (t.to_date = '9999,01,01')
ORDER BY e.emp_no ASC, t.to_date DESC;

-- Creates a table that counts the number of potentital retirees from each department
SELECT
    u.title,
    COUNT (u.emp_no)
INTO retiring_titles
FROM unique_titles as u
GROUP BY u.title
ORDER BY COUNT(u.emp_no) DESC;