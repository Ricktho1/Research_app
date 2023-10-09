import 'package:flutter/material.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({Key? key}) : super(key: key);

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Result Screen'),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: const Text('Record Video'),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Upload Video'),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Process Video'),
          ),
        ],
      ),
    );
  }
}
