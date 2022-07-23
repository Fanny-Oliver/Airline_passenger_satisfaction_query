--create temporary tables and join the tables to find the percentage of returning and first-time customers that are satisfied
WITH
satifaction_level AS
(
SELECT 
Customer_Type,
Satisfaction,
COUNT (Customer_Type) AS count_of_customer_type
FROM `my-maven-projects.Airline_data.Passenger_satisfaction` 
GROUP BY Customer_Type, Satisfaction
),
 Total_satisfaction AS -- this second temp table is needed to get the total of each customer according to their type
(
SELECT Customer_Type,
COUNT (Customer_Type) AS total_count_of_customers,
FROM `my-maven-projects.Airline_data.Passenger_satisfaction`
GROUP BY Customer_Type
) 
SELECT satifaction_level.Customer_Type,
satifaction_level.count_of_customer_type AS total_satisfied_customers,
Total_satisfaction.total_count_of_customers,
ROUND ((satifaction_level.count_of_customer_type/Total_satisfaction.total_count_of_customers)*100, 2) AS percentage
FROM Total_satisfaction
FULL OUTER JOIN satifaction_level ON satifaction_level.Customer_Type =  Total_satisfaction.Customer_Type
WHERE satisfaction = 'Satisfied'