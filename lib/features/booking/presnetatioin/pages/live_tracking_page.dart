import 'dart:async';

import 'package:flutter/material.dart';

class LiveLocationPage extends StatefulWidget {
  const LiveLocationPage({super.key});

  @override
  State<LiveLocationPage> createState() => _LiveLocationPageState();
}

class _LiveLocationPageState extends State<LiveLocationPage> {
  int _currentStep = 0; // Current step in the list of stops
  late Timer _timer;

  // List of stops with names and coordinates
  final List<Map<String, dynamic>> stops = [
    {"id": 45, "name": "Alappuzha", 'latitude': 9.3946, 'longitude': 76.3388},
    {"id": 61, "name": "Aluva", 'latitude': 10.0878, 'longitude': 76.3509},
    {"id": 33, "name": "Attingal", 'latitude': 8.7242, 'longitude': 76.7991},
    {
      "id": 44,
      "name": "Changanassery",
      'latitude': 9.4350,
      'longitude': 76.5569
    },
    {"id": 40, "name": "Chengannur", 'latitude': 9.2320, 'longitude': 76.5775},
    {"id": 46, "name": "Cherthala", 'latitude': 9.5914, 'longitude': 76.3365},
    {"id": 56, "name": "Ernakulam", 'latitude': 9.9815, 'longitude': 76.3014},
    {"id": 77, "name": "Kannur", 'latitude': 11.8745, 'longitude': 75.3704},
    {"id": 84, "name": "Kasaragod", 'latitude': 12.4984, 'longitude': 75.0000},
    {"id": 41, "name": "Kayamkulam", 'latitude': 9.2001, 'longitude': 76.5300},
    {"id": 34, "name": "Kollam", 'latitude': 8.8932, 'longitude': 76.6144},
    {
      "id": 35,
      "name": "Kottarakkara",
      'latitude': 9.1310,
      'longitude': 76.7812
    },
    {"id": 47, "name": "Kottayam", 'latitude': 9.5917, 'longitude': 76.5220},
  ];

  @override
  void initState() {
    super.initState();

    // Simulate moving through the stops every 2 seconds
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      setState(() {
        if (_currentStep < stops.length - 1) {
          _currentStep++;
        } else {
          _currentStep =
              0; // Reset to the first stop after reaching the last one
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer when the page is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get the current stop based on _currentStep
    final currentStop = stops[_currentStep];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Live Location with Bus Tracker"),
        actions: [
          // Add a bus icon on the AppBar
          IconButton(
            icon: const Icon(Icons.directions_bus),
            onPressed: () {
              // Logic for when the bus icon is clicked (can be customized)
              print("Bus icon clicked");
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Stepper UI (taking full screen)
          Expanded(
            child: Stepper(
              currentStep: _currentStep,
              onStepTapped: (int step) {
                setState(() {
                  _currentStep = step;
                });
              },
              controlsBuilder: (BuildContext context, ControlsDetails details) {
                // Custom control buttons, if needed
                return const SizedBox
                    .shrink(); // Empty widget instead of buttons
              },
              steps: stops
                  .map(
                    (stop) => Step(
                      title: Row(
                        children: [
                          Text(stop['name']), if(_currentStep == stops.indexOf(stop))const Icon(Icons.directions_bus)
                        ],
                      ),
                    content: const Text(''),
                      isActive: _currentStep == stops.indexOf(stop),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class MapPainter extends CustomPainter {
  final double latitude;
  final double longitude;

  MapPainter(this.latitude, this.longitude);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.blue;
    Paint markerPaint = Paint()..color = Colors.red;

    // Draw a simple representation of the map (just a grid of lines)
    double width = size.width;
    double height = size.height;

    // Draw a simple grid background for the map
    paint.color = Colors.grey.withOpacity(0.2);
    canvas.drawRect(Rect.fromLTWH(0, 0, width, height), paint);

    // Simple example of moving marker
    double markerX = (longitude + 122.4194) *
        100; // Calculate X based on longitude (adjust scale)
    double markerY = (latitude - 37.7749) *
        100; // Calculate Y based on latitude (adjust scale)

    // Draw the "moving marker" (simulating location change)
    canvas.drawCircle(Offset(markerX, markerY), 10, markerPaint);

    // You can replace the simple grid with an actual image, if you'd like to represent a map background.
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; // Always repaint to animate the marker
  }
}
