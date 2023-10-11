import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  ResultScreenState createState() => ResultScreenState();
}

class ResultScreenState extends State<ResultScreen> {
  File? _videoFile;
  List<Map<String, dynamic>>? _results;
  Dio dio = Dio();
  Future<void> _processVideo() async {
    if (_videoFile == null) {
      return;
    }

    var request = http.MultipartRequest(
        'POST', Uri.parse('http://localhost:5000/process_video'));
    request.files
        .add(await http.MultipartFile.fromPath('video', _videoFile!.path));
    var response = await request.send();

    if (response.statusCode == 200) {
      var bytes = await response.stream.toBytes();
      var results = jsonDecode(utf8.decode(bytes));
      setState(() {
        _results = results;
      });
    } else {
      print('Error processing video: ${response.statusCode}');
    }
  }

  Future<void> _pickVideo() async {
    var videoFile = await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (videoFile != null) {
      setState(() {
        _videoFile = videoFile as File?;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Processing App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_videoFile != null) Text(_videoFile!.path),
            ElevatedButton(
              onPressed: _pickVideo,
              child: Text('Pick Video'),
            ),
            ElevatedButton(
              onPressed: _processVideo,
              child: Text('Process Video'),
            ),
            if (_results != null)
              ListView.builder(
                itemCount: _results!.length,
                itemBuilder: (context, index) {
                  var result = _results![index];
                  return ListTile(
                    title: Text('Distance: ${result['distance']}'),
                    subtitle: Text('Velocity: ${result['velocity']}'),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
