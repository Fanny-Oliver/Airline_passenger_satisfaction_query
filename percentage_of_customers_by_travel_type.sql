--calculate the percentage of people according to travel type;
SELECT  
 Type_of_Travel,
 COUNT (Type_of_Travel) AS count_type_of_travel,
 (
   SELECT COUNT (ID) FROM `my-maven-projects.Airline_data.Passenger_satisfaction`
 ) AS total_customers,
 ROUND ((COUNT (Type_of_Travel)/(SELECT COUNT (ID) FROM `my-maven-projects.Airline_data.Passenger_satisfaction`))*100,0) AS percentage
FROM `my-maven-projects.Airline_data.Passenger_satisfaction`
GROUP BY Type_of_Travel