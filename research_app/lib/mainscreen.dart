import 'package:flutter/material.dart';
import 'calibrationscreen.dart';
import 'resultscreen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calibration and Results'),
        backgroundColor: const Color.fromARGB(255, 153, 63, 186),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: 100.0,
              width: double.infinity,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.grey),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(300.0),
                    ),
                  ),
                ),
                onPressed: () {
                  // Navigate to the Calibration screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CalibrationScreen()),
                  );
                },
                child: const Text('Calibration'),
              ),
            ),
            SizedBox(
              height: 100.0,
              width: double.infinity,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.grey),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(200.0),
                    ),
                  ),
                ),
                onPressed: () {
                  // Navigate to the Results screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ResultScreen()),
                  );
                },
                child: const Text('Results'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
