import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class ResultScreen extends StatelessWidget {
  String label;
  File? filePath;
  double confidence = 0.0;

  ResultScreen(
      {super.key,
      required this.label,
      required this.confidence,
      required this.filePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFF3A415D),
        title: const Text(
          'Test Result',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 280,
              width: 280,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                image: const DecorationImage(
                  image: AssetImage('assets/images/upload.jpg'),
                ),
              ),
              child: filePath == null
                  ? const Text('')
                  : Image.file(
                      filePath!,
                      fit: BoxFit.fill,
                    ),
            ),
            const SizedBox(
              height: 30,
            ),
            Card(
              child: Column(
                children: [
                  // const SizedBox(
                  //   height: 8,
                  // ),
                  Container(color: const Color(0xFF3A415D),width: MediaQuery.of(context).size.width * 1,
                    child: const Text(textAlign: TextAlign.center,
                      'Detected Disease',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 8,),
                  Text(
                    label,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'The Accuracy is ${confidence.toStringAsFixed(0)}%',
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),
            // You can display relevant information based on the detected disease here
            // For example, you can display images or descriptions related to the disease
            // You can also include buttons or links for further information or actions
            SizedBox(
              width: MediaQuery.of(context).size.width *
                  0.5, // Set width to 50% of screen width
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3A415D),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Take Another Test',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3A415D),
                    ),
                    onPressed: () {
                      SystemNavigator.pop();
                    },
                    child: const Text(
                      'Close the App',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
