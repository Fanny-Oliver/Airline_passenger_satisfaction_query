--calculate the percentage of people according to age group; use case to divide the ages
--start by making a temp table where we can define the age groups
WITH age_group_table AS (
SELECT 
CASE
WHEN Age >7 and Age <=12 THEN "Child"
WHEN Age >=13 and Age <=17 THEN "Teenager"
WHEN Age >=18 and Age <=50 THEN "Adult"
ELSE "Senior citizen"
END AS age_group,
FROM `my-maven-projects.Airline_data.Passenger_satisfaction`
)

SELECT age_group, COUNT(age_group) AS count_of_each_age_group,
(
  SELECT COUNT (ID) FROM `my-maven-projects.Airline_data.Passenger_satisfaction`
) AS total_age,
ROUND((COUNT (age_group)/(SELECT COUNT (ID) FROM `my-maven-projects.Airline_data.Passenger_satisfaction`)) *100,0) AS percentage
FROM age_group_table
GROUP BY age_group