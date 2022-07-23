--create temporary tables and join the tables to find the percentage of customer satisfaction based ON travel_type
WITH
satifaction_level AS
(
SELECT 
Type_of_Travel,
Satisfaction,
COUNT (Type_of_Travel) AS count_of_type_of_travel
FROM `my-maven-projects.Airline_data.Passenger_satisfaction` 
GROUP BY Type_of_Travel, Satisfaction
),
 Total_satisfaction AS -- this 2nd temp table is needed to get the total of each travel type
(
SELECT Type_of_Travel,
COUNT (Type_of_Travel) AS total_count_of_travel_type,
FROM `my-maven-projects.Airline_data.Passenger_satisfaction`
GROUP BY Type_of_Travel
) 
SELECT satifaction_level.Type_of_Travel,
satifaction_level.count_of_type_of_travel AS total_satisfied_cusomers,

Total_satisfaction.total_count_of_travel_type, -- i used the temp table to then find the percentages
ROUND((satifaction_level.count_of_type_of_travel/Total_satisfaction.total_count_of_travel_type)*100, 2) AS percentage
FROM Total_satisfaction
FULL OUTER JOIN satifaction_level ON satifaction_level.Type_of_Travel =  Total_satisfaction.Type_of_Travel
WHERE satisfaction = 'Satisfied'