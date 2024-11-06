import 'package:flutter/material.dart';
import 'package:trendwave/authentication/email_number_validateotp.dart';
import 'package:trendwave/authentication/forgotpassword.dart';
import 'package:trendwave/authentication/forgotpasswordotp.dart';
import 'package:trendwave/authentication/register.dart';
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
      home: const ValidateUserOtpScreen(),
    );
  }
}
