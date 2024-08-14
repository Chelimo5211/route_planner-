import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'dart:math';

class TripProvider with ChangeNotifier {
  String _start = '';
  String _end = '';
  List<String> _stops = [];

  String get start => _start;
  String get end => _end;
  List<String> get stops => _stops;

  void setTrip(String start, String end, List<String> stops) {
    _start = start;
    _end = end;
    _stops = stops;
    notifyListeners();
  }

  void saveTrip() async {
    var box = Hive.box('trips');

    Map<String, dynamic> tripData = {
      'start': _start,
      'end': _end,
      'stops': _stops,
    };

    await box.put('currentTrip', tripData);
  }

  void loadTrip() async {
    var box = Hive.box('trips');
    Map<String, dynamic>? tripData = box.get('currentTrip');

    if (tripData != null) {
      _start = tripData['start'];
      _end = tripData['end'];
      _stops = List<String>.from(tripData['stops']);
      notifyListeners();
    }
  }

  // Method to calculate all possible routes and return the shortest one
  String calculateShortestRoute() {
    List<String> locations = [_start, ..._stops, _end];
    double shortestDistance = double.infinity;
    String shortestRoute = '';

    // Generate all possible routes
    List<List<String>> allRoutes = _generatePermutations(_stops);

    for (var route in allRoutes) {
      double distance = _calculateRouteDistance([_start, ...route, _end]);
      if (distance < shortestDistance) {
        shortestDistance = distance;
        shortestRoute = [_start, ...route, _end].join(' -> ');
      }
    }

    return shortestRoute;
  }

  // Method to calculate all possible routes and return the longest one
  String calculateLongestRoute() {
    List<String> locations = [_start, ..._stops, _end];
    double longestDistance = 0;
    String longestRoute = '';

    // Generate all possible routes
    List<List<String>> allRoutes = _generatePermutations(_stops);

    for (var route in allRoutes) {
      double distance = _calculateRouteDistance([_start, ...route, _end]);
      if (distance > longestDistance) {
        longestDistance = distance;
        longestRoute = [_start, ...route, _end].join(' -> ');
      }
    }

    return longestRoute;
  }

  // Helper method to generate permutations
  List<List<String>> _generatePermutations(List<String> list) {
    if (list.length == 1) {
      return [list];
    }

    List<List<String>> permutations = [];
    for (int i = 0; i < list.length; i++) {
      String current = list[i];
      List<String> remaining = List.from(list)..removeAt(i);
      for (var permutation in _generatePermutations(remaining)) {
        permutations.add([current, ...permutation]);
      }
    }
    return permutations;
  }

  // Helper method to calculate the distance of a given route
  double _calculateRouteDistance(List<String> route) {
    double totalDistance = 0.0;

    // Simulate distances between locations (you would replace this with real data)
    Map<String, Map<String, double>> distances = {
      'Nairobi': {'Nakuru': 160, 'Mombasa': 485, 'Kericho': 260},
      'Nakuru': {'Nairobi': 160, 'Mombasa': 640, 'Kericho': 125},
      'Kericho': {'Nairobi': 260, 'Nakuru': 125, 'Mombasa': 760},
      'Mombasa': {'Nairobi': 485, 'Nakuru': 640, 'Kericho': 760},
      // Add other distances as needed...
    };

    for (int i = 0; i < route.length - 1; i++) {
      String from = route[i];
      String to = route[i + 1];
      totalDistance += distances[from]?[to] ?? double.infinity;
    }

    return totalDistance;
  }
}
