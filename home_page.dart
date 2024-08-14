import 'package:flutter/material.dart';
import 'tsp.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _startController = TextEditingController();
  final _endController = TextEditingController();
  final _stopControllers = List.generate(5, (_) => TextEditingController());
  final RouteCalculator _calculator = RouteCalculator();

  String _shortestRoute = '';
  String _longestRoute = '';

  void _planTrip() {
    final start = _startController.text;
    final end = _endController.text;
    final stops = _stopControllers.map((c) => c.text).toList();

    final shortestRoute = _calculator.findShortestRoute(start, end, stops);
    final longestRoute = _calculator.findLongestRoute(start, end, stops);

    setState(() {
      _shortestRoute = 'Shortest route: ${shortestRoute.join(' -> ')}';
      _longestRoute = 'Longest route: ${longestRoute.join(' -> ')}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Route Planner')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _startController, decoration: InputDecoration(labelText: 'Start Location')),
            TextField(controller: _endController, decoration: InputDecoration(labelText: 'End Location')),
            ..._stopControllers.map((controller) => TextField(controller: controller, decoration: InputDecoration(labelText: 'Stop Location'))),
            SizedBox(height: 16),
            ElevatedButton(onPressed: _planTrip, child: Text('Plan Trip')),
            SizedBox(height: 16),
            Text(_shortestRoute),
            Text(_longestRoute),
          ],
        ),
      ),
    );
  }
}
