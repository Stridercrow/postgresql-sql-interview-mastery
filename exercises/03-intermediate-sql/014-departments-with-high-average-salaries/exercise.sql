-- Write your query here.
-- Do not look at solution.sql until you have attempted the exercise.

SELECT
    d.id AS department_id,
    d.name AS department_name,
    ROUND(AVG(e.salary), 2) AS average_salary,
    COUNT(e.id) AS employee_count
FROM departments d
JOIN employees e ON e.department_id = d.id
GROUP BY d.id, d.name
HAVING AVG(e.salary) > 100000
ORDER BY average_salary DESC;
