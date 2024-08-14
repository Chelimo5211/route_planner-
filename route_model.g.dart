import 'package:hive/hive.dart';
import 'package:route_planner/route_model.g.dart'; // Ensure this is generated

// Define the Route class
@HiveType(typeId: 0)
class RouteData extends HiveObject {
  @HiveField(0)
  final String start;
  
  @HiveField(1)
  final String end;

  @HiveField(2)
  final int distance;

  @HiveField(3)
  final List<String> stops;

  RouteData({
    required this.start,
    required this.end,
    required this.distance,
    required this.stops,
  });
}

// Define the Location class
@HiveType(typeId: 1)
class Location extends HiveObject {
  @HiveField(0)
  final String name;
  
  @HiveField(1)
  final double latitude;

  @HiveField(2)
  final double longitude;

  Location({
    required this.name,
    required this.latitude,
    required this.longitude,
  });
}

// Define the Distance class
@HiveType(typeId: 2)
class Distance extends HiveObject {
  @HiveField(0)
  final String from;
  
  @HiveField(1)
  final String to;

  @HiveField(2)
  final int distance;

  Distance({
    required this.from,
    required this.to,
    required this.distance,
  });
}
