import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class RouteResultsPage extends StatefulWidget {
  @override
  _RouteResultsPageState createState() => _RouteResultsPageState();
}

class _RouteResultsPageState extends State<RouteResultsPage> {
  late String _start;
  late String _end;
  late List<String> _stops;
  String _shortestRoute = '';
  String _longestRoute = '';
  double _shortestDistance = double.infinity;
  double _longestDistance = 0.0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    _start = args['start'];
    _end = args['end'];
    _stops = List<String>.from(args['stops']);

    _calculateRoutes();
  }

  void _calculateRoutes() {
    final distancesBox = Hive.box('distances').toMap() as Map<String, Map<String, int>>;
    final allLocations = [_start, ..._stops, _end];
    
    List<List<String>> permutations = _generatePermutations(allLocations);
    
    for (var perm in permutations) {
      double distance = _calculateTotalDistance(perm, distancesBox);
      if (distance < _shortestDistance) {
        _shortestDistance = distance;
        _shortestRoute = perm.join(' -> ');
      }
      if (distance > _longestDistance) {
        _longestDistance = distance;
        _longestRoute = perm.join(' -> ');
      }
    }

    _shortestRoute += ' ($_shortestDistance km)';
    _longestRoute += ' ($_longestDistance km)';

    _saveRoutes();
  }

  List<List<String>> _generatePermutations(List<String> items) {
    // Generate all permutations of the list of locations
    if (items.isEmpty) return [[]];
    var result = <List<String>>[];
    for (var i = 0; i < items.length; i++) {
      var item = items[i];
      var remaining = List<String>.from(items)..removeAt(i);
      for (var perm in _generatePermutations(remaining)) {
        result.add([item, ...perm]);
      }
    }
    return result;
  }

  double _calculateTotalDistance(List<String> route, Map<String, Map<String, int>> distances) {
    double totalDistance = 0.0;
    for (var i = 0; i < route.length - 1; i++) {
      totalDistance += distances[route[i]]?[route[i + 1]]?.toDouble() ?? double.infinity;
    }
    return totalDistance;
  }

  void _saveRoutes() {
    final Box tripsBox = Hive.box('trips');
    final newTrip = {
      'start': _start,
      'end': _end,
      'stops': _stops,
      'shortestRoute': _shortestRoute,
      'longestRoute': _longestRoute,
    };
    tripsBox.add(newTrip);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Route Results'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Shortest Route: $_shortestRoute'),
            SizedBox(height: 10),
            Text('Longest Route: $_longestRoute'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Return to the previous page
              },
              child: Text('Back to Home'),
            ),
          ],
        ),
      ),
    );
  }
}
