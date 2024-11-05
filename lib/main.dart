import 'package:flutter/material.dart';
import 'package:trendwave/splashscreen/splash.dart';
import 'package:trendwave/theme/themes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TrendWave',
      theme: TrendWaveTheme.lightTheme,
      darkTheme: TrendWaveTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: SplashScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(""),
      ),
      body: Center(
      ),
    );
  }
}
