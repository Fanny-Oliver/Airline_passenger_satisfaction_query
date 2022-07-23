--calculate the percentage of people according to gender;
SELECT  
 Gender AS distinct_gender,
 COUNT (Gender) AS count_of_gender,
 (
   SELECT COUNT (ID) FROM `my-maven-projects.Airline_data.Passenger_satisfaction`
 ) AS total_customer,
 ROUND ((COUNT (Gender)/(SELECT COUNT (ID) FROM `my-maven-projects.Airline_data.Passenger_satisfaction`))*100,0) AS percentage
FROM `my-maven-projects.Airline_data.Passenger_satisfaction`
GROUP BY Gender