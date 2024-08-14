import 'data.dart';
import 'distance.dart';

class RouteCalculator {
  List<String> findShortestRoute(String start, String end, List<String> stops) {
    // Implement a basic TSP algorithm or use a heuristic approach
    // For simplicity, this just combines the start, stops, and end
    return [start, ...stops, end];
  }

  List<String> findLongestRoute(String start, String end, List<String> stops) {
    // For simplicity, just reverse the route to find a "longer" path
    return [start, ...stops.reversed, end];
  }

  int getDistance(String from, String to) {
    try {
      return distances
          .firstWhere((d) => d.from == from && d.to == to)
          .distance;
    } catch (e) {
      return -1; // Distance not found
    }
  }
}
