import 'package:flutter/material.dart';

class PlanTripPage extends StatefulWidget {
  @override
  _PlanTripPageState createState() => _PlanTripPageState();
}

class _PlanTripPageState extends State<PlanTripPage> {
  final TextEditingController _startController = TextEditingController();
  final TextEditingController _endController = TextEditingController();
  final List<TextEditingController> _stopsControllers = List.generate(5, (_) => TextEditingController());

  void _planTrip() {
    final start = _startController.text.trim();
    final end = _endController.text.trim();
    final stops = _stopsControllers.map((controller) => controller.text.trim()).toList();

    if (start.isEmpty || end.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Start and End locations cannot be empty')),
      );
      return;
    }

    Navigator.pushNamed(
      context,
      '/routeResults',
      arguments: {
        'start': start,
        'end': end,
        'stops': stops.where((stop) => stop.isNotEmpty).toList(), // Filter out empty stops
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Plan Your Trip'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _startController,
              decoration: InputDecoration(labelText: 'Start Location'),
            ),
            TextField(
              controller: _endController,
              decoration: InputDecoration(labelText: 'End Location'),
            ),
            ..._stopsControllers.map((controller) => TextField(
              controller: controller,
              decoration: InputDecoration(labelText: 'Stop Location'),
            )),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _planTrip,
              child: Text('Plan Trip'),
            ),
          ],
        ),
      ),
    );
  }
}
