import 'package:flutter/material.dart';

class TrendWaveTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF3A539B),
      secondary: Color(0xFFE74C3C),
    ),
    scaffoldBackgroundColor: const Color(0xFFFFFFFF),
    cardColor: const Color(0xFFF7F9FB),
    fontFamily: 'Poppins', // Default font for most text
    textTheme: const TextTheme(
      displayLarge: TextStyle( // headline1
        fontSize: 24,
        fontWeight: FontWeight.w700, // Bold
        color: Color(0xFF2D2D2D),
        fontFamily: 'CodecPro',
      ),
      displayMedium: TextStyle( // headline2
        fontSize: 20,
        fontWeight: FontWeight.w700, // Bold
        color: Color(0xFF2D2D2D),
        fontFamily: 'CodecPro',
      ),
      bodyMedium: TextStyle( // bodyText1
        fontSize: 16,
        fontWeight: FontWeight.w400, // Regular
        color: Color(0xFF7E8C8D),
        fontFamily: 'Poppins',
      ),
      bodySmall: TextStyle( // bodyText2
        fontSize: 14,
        fontWeight: FontWeight.w400, // Regular
        color: Color(0xFF2D2D2D),
        fontFamily: 'Poppins',
      ),
      labelLarge: TextStyle( // button
        fontSize: 14,
        fontWeight: FontWeight.w700, // Bold
        color: Colors.white,
        fontFamily: 'Poppins',
      ),
      labelSmall: TextStyle( // caption
        fontSize: 12,
        fontWeight: FontWeight.w400, // Regular
        color: Color(0xFFE74C3C),
        fontFamily: 'Poppins',
      ),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: Color(0xFF3A539B),
      textTheme: ButtonTextTheme.primary,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF8AB6D6),
      secondary: Color(0xFFFF6B6B),
    ),
    scaffoldBackgroundColor: const Color(0xFF1E1E1E),
    cardColor: const Color(0xFF292929),
    fontFamily: 'Poppins', // Default font for most text
    textTheme: const TextTheme(
      displayLarge: TextStyle( // headline1
        fontSize: 24,
        fontWeight: FontWeight.w700, // Bold
        color: Color(0xFFF5F5F5),
        fontFamily: 'CodecPro',
      ),
      displayMedium: TextStyle( // headline2
        fontSize: 20,
        fontWeight: FontWeight.w700, // Bold
        color: Color(0xFFF5F5F5),
        fontFamily: 'CodecPro',
      ),
      bodyMedium: TextStyle( // bodyText1
        fontSize: 16,
        fontWeight: FontWeight.w400, // Regular
        color: Color(0xFFA3A3A3),
        fontFamily: 'Poppins',
      ),
      bodySmall: TextStyle( // bodyText2
        fontSize: 14,
        fontWeight: FontWeight.w400, // Regular
        color: Color(0xFFF5F5F5),
        fontFamily: 'Poppins',
      ),
      labelLarge: TextStyle( // button
        fontSize: 14,
        fontWeight: FontWeight.w700, // Bold
        color: Colors.white,
        fontFamily: 'Poppins',
      ),
      labelSmall: TextStyle( // caption
        fontSize: 12,
        fontWeight: FontWeight.w400, // Regular
        color: Color(0xFFFF6B6B),
        fontFamily: 'Poppins',
      ),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: Color(0xFF8AB6D6),
      textTheme: ButtonTextTheme.primary,
    ),
  );
}
