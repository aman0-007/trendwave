import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

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
        MaterialPageRoute(builder: (context) => NextPage()),
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
              width: 100, // Set your desired width
              height: 100, // Set your desired height
              child: Image.asset(
                'assets/app/logogif.gif',
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20), // Add space between GIF and text
            AnimatedTextKit(
              animatedTexts: [
                FadeAnimatedText(
                  'TrendWave',
                  duration: const Duration(seconds: 2),
                  textStyle: const TextStyle(
                    fontSize: 20.0, // Set the desired font size
                    fontWeight: FontWeight.w700, // Bold
                    color: Color(0xFF2D2D2D), // Set the desired color
                    fontFamily: 'CodecPro', // Use CodecPro font
                  ),
                ),
              ],
              isRepeatingAnimation: false,
            ),
          ],
        ),
      ),
    );
  }
}

class NextPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Next Page'),
      ),
      body: const Center(
        child: Text('Welcome to TrendWave!'),
      ),
    );
  }
}
