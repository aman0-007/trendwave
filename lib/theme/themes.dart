import 'package:flutter/material.dart';

class TrendWaveTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF333333), // Dark Grey for primary elements
      secondary: Color(0xFF777777), // Medium Grey for accents
    ),
    scaffoldBackgroundColor: const Color(0xFFFFFFFF), // White background
    cardColor: const Color(0xFFF2F2F2), // Light Grey for cards
    fontFamily: 'Poppins', // Default font for most text
    textTheme: const TextTheme(
      displayLarge: TextStyle( // headline1
        fontSize: 24,
        fontWeight: FontWeight.w700, // Bold
        color: Color(0xFF333333), // Dark Grey for headers
        fontFamily: 'CodecPro',
      ),
      displayMedium: TextStyle( // headline2
        fontSize: 20,
        fontWeight: FontWeight.w700, // Bold
        color: Color(0xFF333333), // Dark Grey for subheaders
        fontFamily: 'CodecPro',
      ),
      bodyMedium: TextStyle( // bodyText1
        fontSize: 16,
        fontWeight: FontWeight.w400, // Regular
        color: Color(0xFF666666), // Medium Grey for main text
        fontFamily: 'Poppins',
      ),
      bodySmall: TextStyle( // bodyText2
        fontSize: 14,
        fontWeight: FontWeight.w400, // Regular
        color: Color(0xFF333333), // Dark Grey for secondary text
        fontFamily: 'Poppins',
      ),
      labelLarge: TextStyle( // button
        fontSize: 14,
        fontWeight: FontWeight.w700, // Bold
        color: Colors.white, // White text on buttons
        fontFamily: 'Poppins',
      ),
      labelSmall: TextStyle( // caption
        fontSize: 12,
        fontWeight: FontWeight.w400, // Regular
        color: Color(0xFF777777), // Medium Grey for captions
        fontFamily: 'Poppins',
      ),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: Color(0xFF333333), // Dark Grey for buttons
      textTheme: ButtonTextTheme.primary,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFFCCCCCC), // Light Grey for primary elements
      secondary: Color(0xFF888888), // Medium Grey for accents
    ),
    scaffoldBackgroundColor: const Color(0xFF121212), // Dark Grey background
    cardColor: const Color(0xFF1E1E1E), // Slightly lighter dark grey for cards
    fontFamily: 'Poppins', // Default font for most text
    textTheme: const TextTheme(
      displayLarge: TextStyle( // headline1
        fontSize: 24,
        fontWeight: FontWeight.w700, // Bold
        color: Color(0xFFCCCCCC), // Light Grey for headers
        fontFamily: 'CodecPro',
      ),
      displayMedium: TextStyle( // headline2
        fontSize: 20,
        fontWeight: FontWeight.w700, // Bold
        color: Color(0xFFCCCCCC), // Light Grey for subheaders
        fontFamily: 'CodecPro',
      ),
      bodyMedium: TextStyle( // bodyText1
        fontSize: 16,
        fontWeight: FontWeight.w400, // Regular
        color: Color(0xFFAAAAAA), // Medium Light Grey for main text
        fontFamily: 'Poppins',
      ),
      bodySmall: TextStyle( // bodyText2
        fontSize: 14,
        fontWeight: FontWeight.w400, // Regular
        color: Color(0xFFCCCCCC), // Light Grey for secondary text
        fontFamily: 'Poppins',
      ),
      labelLarge: TextStyle( // button
        fontSize: 14,
        fontWeight: FontWeight.w700, // Bold
        color: Colors.white, // White text on buttons
        fontFamily: 'Poppins',
      ),
      labelSmall: TextStyle( // caption
        fontSize: 12,
        fontWeight: FontWeight.w400, // Regular
        color: Color(0xFF888888), // Medium Grey for captions
        fontFamily: 'Poppins',
      ),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: Color(0xFF888888), // Medium Grey for buttons
      textTheme: ButtonTextTheme.primary,
    ),
  );
}
