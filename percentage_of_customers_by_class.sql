--calculate the percentage of people according class type;
SELECT  
 Class,
 COUNT (Class) AS count_of_class,
 (
   SELECT COUNT (ID) FROM `my-maven-projects.Airline_data.Passenger_satisfaction`
 ) AS total_customers,
ROUND((COUNT (Class)/(SELECT COUNT (ID) FROM `my-maven-projects.Airline_data.Passenger_satisfaction`)) *100,0) AS percentage
FROM `my-maven-projects.Airline_data.Passenger_satisfaction`
GROUP BY Class