// ignore_for_file: unnecessary_const

import 'dart:math';

import 'package:flutter/material.dart';

class LightTheme {

  Color mainColor = const Color(0xFF4C8C2B);
  Color primaryColor = const Color(0xFF5A60FF);
  Color secondaryColor = const Color(0xFFF08900);
  Color backgroundColor = const Color(0xFFF8F8F8);
  Color errorColor = const Color(0xFFEC6B6C);
  Color shadowColor = Colors.black.withAlpha(70);

  ThemeData theme() {
    return ThemeData(
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: generateMaterialColor(mainColor),
        accentColor: primaryColor,
        backgroundColor: backgroundColor,
        errorColor: errorColor
      )
      .copyWith(
        
      ),
      
      // Define the default font family.
      fontFamily: 'Berthold Akzidenz Grotesk',

      // Define the default `TextTheme`. Use this to specify the default
      // text styling for headlines, titles, bodies of text, and more.
      textTheme: const TextTheme(
        headline1: TextStyle(fontSize: 96.0, fontWeight: FontWeight.normal),
        headline2: TextStyle(fontSize: 60.0, fontWeight: FontWeight.normal),
        headline3: TextStyle(fontSize: 48.0, fontWeight: FontWeight.normal),
        headline4: TextStyle(fontSize: 34.0, fontWeight: FontWeight.normal),
        headline5: TextStyle(fontSize: 24.0, fontWeight: FontWeight.normal),
        headline6: TextStyle(fontSize: 20.0, fontStyle: FontStyle.normal),
        bodyText1: TextStyle(fontSize: 16.0, fontFamily: 'D Din'),
        bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'D Din'),
        subtitle1: TextStyle(fontSize: 14.0, fontFamily: 'D Din'),
        subtitle2: TextStyle(fontSize: 10.0, fontFamily: 'D Din' ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        isDense: true,
        enabledBorder: _buildBorder(const Color(0xFFDCDEDF), 1),
        focusedBorder: _buildBorder(primaryColor, 2.5),
        floatingLabelStyle: _buildTextStyle(primaryColor)
      )
    );
  }

  OutlineInputBorder _buildBorder(Color color, double width){
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: color,
        width: width
      )
    );
  }

  TextStyle _buildTextStyle(Color color) {
    return TextStyle(
      color: color,
      fontWeight: FontWeight.bold,
      fontSize: 16
    );
  }



  MaterialColor generateMaterialColor(Color color) {
    return MaterialColor(
      color.value, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
      {
        50: tintColor(color, 0.9),    // 10%
        100: tintColor(color, 0.8),   // 20%
        200: tintColor(color, 0.6),   // 30%
        300: tintColor(color, 0.4),   // 40%
        400: tintColor(color, 0.2),   // 50%
        500: color,                   // 60%
        600: shadeColor(color, 0.1),  // 70%
        700: shadeColor(color, 0.2),  // 80%
        800: shadeColor(color, 0.3),  // 90%
        900: shadeColor(color, 0.4),  // 100%
      }
    );
  }

  int tintValue(int value, double factor) =>
    max(0, min((value + ((255 - value) * factor)).round(), 255));

  Color tintColor(Color color, double factor) => Color.fromRGBO(
    tintValue(color.red, factor),
    tintValue(color.green, factor),
    tintValue(color.blue, factor),
    1);

  int shadeValue(int value, double factor) =>
    max(0, min(value - (value * factor).round(), 255));

  Color shadeColor(Color color, double factor) => Color.fromRGBO(
    shadeValue(color.red, factor),
    shadeValue(color.green, factor),
    shadeValue(color.blue, factor),
    1);
}
