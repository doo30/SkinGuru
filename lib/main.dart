
import 'package:flutter/material.dart';

import 'screens/MainScreen.dart';
// import 'screens/ResultScreen.dart';
import 'screens/SplashScreen.dart';

void main() {
  runApp(SafeArea(
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'JosefinSans',
        appBarTheme: const AppBarTheme(
          // Set the color of the back button to white
          iconTheme: IconThemeData(color: Colors.white),
        ),
      ),
      home: const SplashScreen(),
      // Define routes for navigation
      routes: {
        '/main': (context) => const MainScreen(),
        // '/result': (context) => ResultScreen(),
      },
    ),
  ));
}
