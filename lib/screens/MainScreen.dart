import 'package:flutter/material.dart';

import 'PopupForm.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,backgroundColor: const Color(0xFF3A415D),
        title: const Text('Skin Guru',style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 20),),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/images/giphy.gif'),
            const SizedBox(height: 40),
            const Text('How are you today?',style: TextStyle(fontSize: 24,),),
            const SizedBox(height: 20),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5, // Set width to 50% of screen width
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3A415D), // Set the background color to black
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const PopupForm();
                    },
                  );
                },
                child: const Text('Take a Test',style: TextStyle(color: Colors.white, fontSize: 16,fontWeight: FontWeight.bold),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
