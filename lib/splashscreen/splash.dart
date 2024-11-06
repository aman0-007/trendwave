import 'package:flutter/material.dart';
import 'package:trendwave/authentication/login.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();

    // Navigate to the next screen after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 150, // Set your desired width
              height: 150, // Set your desired height
              child: Image.asset(
                'assets/app/TrendWaveFinalSplash.gif',
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

