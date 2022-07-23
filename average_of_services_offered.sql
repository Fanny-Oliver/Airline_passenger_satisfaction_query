--to calculate the average of every service offered by the flight service:
SELECT AVG(Departure_and_Arrival_Time_Convenience) AS avg_departure_and_arival_time_convenience,
AVG(Ease_of_Online_Booking) AS avg_ease_of_online_booking,
AVG(Check_in_Service) AS avg_check_in_service,
AVG(Online_Boarding) AS avg_online_boarding,
AVG(Gate_Location) AS avg_gate_location,
AVG(On_board_Service) AS avg_onboard_service,
AVG(Seat_Comfort) AS avg_seat_handling,
AVG(Leg_Room_Service) AS avg_leg_room_service,
AVG(Cleanliness) AS avg_cleanliness,
AVG(Food_and_Drink) AS avg_food_and_drink,
AVG(In_flight_Service) AS avg_inflight_service,
AVG(In_flight_Wifi_Service) AS avg_inflight_wifi_service,
AVG(In_flight_Entertainment) AS avg_inflight_entertainment,
AVG(Baggage_Handling) AS avg_baggage_handling
FROM `my-maven-projects.Airline_data.Passenger_satisfaction`