import 'package:flutter/material.dart';
import 'pointscreen.dart';

class CalibrationScreen extends StatelessWidget {
  const CalibrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calibration')),
      body: Center(
        child: Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (int pointNumber = 1; pointNumber <= 6; pointNumber++)
                  SizedBox(
                    height: 80.0,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.grey),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100.0),
                          ),
                        ),
                      ),
                      onPressed: () {
                        // Navigate to the Point screen for the selected point
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  PointScreen(pointNumber: pointNumber)),
                        );
                      },
                      child: Text('Point $pointNumber'),
                    ),
                  ),
                ElevatedButton(
                  onPressed: () {
                    // Implement optimization logic here
                    // Display the result with the highest R2 score
                  },
                  child: const Text('Optimize'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
