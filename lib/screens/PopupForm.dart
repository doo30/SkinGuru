import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:developer' as devtools;
import 'ResultScreen.dart';

class PopupForm extends StatefulWidget {
  const PopupForm({super.key});

  @override
  _PopupFormState createState() => _PopupFormState();
}

class _PopupFormState extends State<PopupForm> {
  File? filePath;
  String label = '';
  double confidence = 0.0;

  Future<void> _tfliteInit() async {
    // ignore: unused_local_variable
    String? res = await Tflite.loadModel(
        model: "assets/model/model_unquant.tflite",
        labels: "assets/model/labels.txt",
        numThreads: 1, // defaults to 1
        isAsset:
            true, // defaults to true, set to false to load resources outside assets
        useGpuDelegate:
            false // defaults to false, set to true to use GPU delegate
        );
  }

  // ignore: non_constant_identifier_names
  PickImageCamera() async {
    final ImagePicker picker = ImagePicker();
// Pick an image.
    final XFile? image = await picker.pickImage(source: ImageSource.camera);

    if (image == null) return;
    var imageMap = File(image.path);
    setState(() {
      filePath = imageMap;
    });

    var recognitions = await Tflite.runModelOnImage(
        path: image.path, // required
        imageMean: 0.0, // defaults to 117.0
        imageStd: 255.0, // defaults to 1.0
        numResults: 2, // defaults to 5
        threshold: 0.2, // defaults to 0.1
        asynch: true // defaults to true
        );

    if (recognitions == null) {
      devtools.log("recognitions is null");
      return;
    }
    devtools.log(recognitions.toString());
    setState(() {
      confidence = (recognitions[0]['confidence'] * 100);
      label = (recognitions[0]['label'].toString());
    });
  }

  // ignore: non_constant_identifier_names
  PickImageGallery() async {
    final ImagePicker picker = ImagePicker();
// Pick an image.
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image == null) return;
    var imageMap = File(image.path);
    setState(() {
      filePath = imageMap;
    });

    var recognitions = await Tflite.runModelOnImage(
        path: image.path, // required
        imageMean: 0.0, // defaults to 117.0
        imageStd: 255.0, // defaults to 1.0
        numResults: 2, // defaults to 5
        threshold: 0.2, // defaults to 0.1
        asynch: true // defaults to true
        );

    if (recognitions == null) {
      devtools.log("recognitions is null");
      return;
    }
    devtools.log(recognitions.toString());
    setState(() {
      confidence = (recognitions[0]['confidence'] * 100);
      label = (recognitions[0]['label'].toString());
    });
  }

  @override
  void dispose() {
    super.dispose();
    Tflite.close();
  }

  @override
  void initState() {
    super.initState();
    _tfliteInit();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(textAlign: TextAlign.center, 'Choose Image Source',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
      content: Column(
        mainAxisSize: MainAxisSize.min,
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
            height: 25,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min, // To limit the column height
            crossAxisAlignment: CrossAxisAlignment.stretch, // Stretch children horizontally

            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3A415D), // Set the background color to black
                ),
                onPressed: () {
                  PickImageGallery();
                },
                child: const Text('Select from Gallery',style: TextStyle(color: Colors.white, fontSize: 16,fontWeight: FontWeight.bold),),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3A415D), // Set the background color to black
                ),
                onPressed: () {
                  PickImageCamera();
                },
                child: const Text('Take Picture',style: TextStyle(color: Colors.white, fontSize: 16,fontWeight: FontWeight.bold),),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3A415D), // Set the background color to black
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ResultScreen(
                          label: label,
                          confidence: confidence,
                          filePath: filePath,
                        )),
                  );
                },
                child: const Text('Show Results',style: TextStyle(color: Colors.white, fontSize: 16,fontWeight: FontWeight.bold),),
              ),
            ],
          )

        ],
      ),
    );
  }
}
