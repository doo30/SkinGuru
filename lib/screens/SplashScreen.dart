import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/images/splash_image.jpeg'),
            const SizedBox(height: 20),
            SizedBox(width: MediaQuery.of(context).size.width * 0.5,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3A415D), // Set the background color to black
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/main');
                },
                child: const Text('Discover Now',style: TextStyle(color: Colors.white, fontSize: 16,fontWeight: FontWeight.bold),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
