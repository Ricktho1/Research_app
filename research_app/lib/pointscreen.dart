import 'package:flutter/material.dart';

class PointScreen extends StatelessWidget {
  final int pointNumber;

  const PointScreen({super.key, required this.pointNumber});

  @override
  Widget build(BuildContext context) {
    // Implement graph visualization for the selected point
    // Calculate and display the R2 score for the selected point
    return Scaffold(
      appBar: AppBar(title: Text('Point $pointNumber')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Graph for Point $pointNumber'),
            // Display the graph here
            const Text('R2 Score: 0.85'), // Replace with actual R2 score
          ],
        ),
      ),
    );
  }
}
