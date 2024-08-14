import 'location.dart';
import 'distance.dart';

// List of locations
final List<Location> locations = [
  Location("Nakuru", -0.303099, 36.080025),
  Location("Baringo", 0.454108, 35.636498),
  Location("Kericho", -0.363833, 35.318354),
  Location("Nairobi", -1.286389, 36.817223),
  Location("Mombasa", -4.043477, 39.668206),
  Location("Londiani", -0.3775, 35.3008),
  Location("Chepseon", -0.1957, 35.3164),
  Location("Molo", -0.2586, 35.5084),
  Location("Buruk", -0.135, 35.379),
  Location("Chepsir", -0.0856, 35.3779),
  Location("Kisumu", -0.091702, 34.768421),
  Location("Mohoroni", -0.0124, 35.2926),
  Location("Kipsitet", -0.2275, 35.2783)
];

// List of distances
final List<Distance> distances = [
  Distance("Nakuru", "Molo", 30),
  Distance("Nakuru", "Londiani", 100),
  Distance("Nakuru", "Chepseon", 150),
  Distance("Nakuru", "Buruk", 120),
  Distance("Nakuru", "Kericho", 180),
  Distance("Londiani", "Molo", 70),
  Distance("Londiani", "Chepseon", 60),
  Distance("Londiani", "Chepsir", 90),
  Distance("Londiani", "Kericho", 110),
  Distance("Londiani", "Kisumu", 200),
  Distance("Chepseon", "Molo", 90),
  Distance("Chepseon", "Chepsir", 60),
  Distance("Chepseon", "Kericho", 80),
  Distance("Chepseon", "Buruk", 100),
  Distance("Chepseon", "Kisumu", 190),
  Distance("Chepsir", "Kericho", 70),
  Distance("Chepsir", "Buruk", 60),
  Distance("Chepsir", "Kisumu", 150),
  Distance("Buruk", "Kericho", 90),
  Distance("Buruk", "Kisumu", 160),
  Distance("Kisumu", "Mohoroni", 30),
  Distance("Kisumu", "Kipsitet", 40),
  Distance("Mohoroni", "Kipsitet", 20),
];
