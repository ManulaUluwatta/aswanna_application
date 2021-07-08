import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constrants.dart';

ThemeData theme(TextTheme textTheme) {
  return ThemeData(
    primarySwatch: Colors.green,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: appBarTheme(),
    textTheme: fontTheme(textTheme),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    inputDecorationTheme: inputDecorationTheme(),
    iconTheme: IconThemeData(color: cPrimaryColor),
  );
}

InputDecorationTheme inputDecorationTheme() {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(28),
    borderSide: BorderSide(
      color: Color(0xFF09af00),
      width: 2,
    ),
    gapPadding: 10,
  );
  OutlineInputBorder errorBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(28),
    borderSide: BorderSide(
      color: Colors.red,
      width: 2,
    ),
    gapPadding: 10,
  );
  return InputDecorationTheme(
      labelStyle: TextStyle(color: Color(0xFF09af00), fontSize: 18),
      errorStyle: TextStyle(color: Colors.red, fontSize: 15),
      contentPadding: EdgeInsets.symmetric(horizontal: 42, vertical: 20),
      enabledBorder: outlineInputBorder,
      focusedBorder: outlineInputBorder,
      border: outlineInputBorder,
      errorBorder: errorBorder);

  // return InputDecorationTheme(
  //   labelStyle: TextStyle(color: Color(0xFF09af00), fontSize: 18),
  //   contentPadding: EdgeInsets.symmetric(horizontal: 42, vertical: 20),
  //   enabledBorder: OutlineInputBorder(
  //     borderRadius: BorderRadius.circular(28),
  //     borderSide: BorderSide(
  //       color: Color(0xFF09af00),
  //       width: 2,
  //     ),
  //     gapPadding: 10,
  //   ),
  //   focusedBorder: OutlineInputBorder(
  //     borderRadius: BorderRadius.circular(28),
  //     borderSide: BorderSide(
  //       color: Color(0xFF09af00),
  //       width: 2,
  //     ),
  //     gapPadding: 10,
  //   ),
  // );
}

TextTheme fontTheme(TextTheme textTheme) {
  return GoogleFonts.robotoTextTheme(textTheme).copyWith(
    bodyText1: TextStyle(
      color: Color(0xFF37474F),
    ),
    bodyText2: TextStyle(
      color: Color(0xFF455A64),
    ),
  );
}

AppBarTheme appBarTheme() {
  return AppBarTheme(
    color: Colors.white,
    centerTitle: true,
    elevation: 0,
    brightness: Brightness.light,
    iconTheme: IconThemeData(color: Color(0xFF37474F)),
    textTheme: TextTheme(
      headline6: TextStyle(
        color: Color(0xFF37474F),
        fontSize: 18.0,
      ),
    ),
  );
}
