import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// const Color warna1 = Color.fromRGBO(17, 35, 90, 1.0);
const Color warna1 = Color.fromRGBO(48, 84, 193, 1);
const Color warna2 = Color.fromARGB(255, 143, 239, 147);
const Color warna3 = Color.fromARGB(255, 78, 232, 206);
const Color warna4 = Color.fromARGB(255, 78, 201, 232);
const Color warna5 = Color.fromARGB(255, 91, 156, 146);
const Color warna6 = Color.fromARGB(255, 198, 236, 184);
const Color warna7 = Color.fromARGB(255, 122, 188, 162);
const Color warna8 = Color.fromARGB(255, 169, 221, 212);
const Color warna9 = Color.fromARGB(255, 8, 245, 233);

const primaryColor = warna1;
const Color darkGrey = Color(0xFF121212);
Color darkHeader = Color(0xFF424242);

class Themes {
  static final light = ThemeData(
    primaryColor: primaryColor,
    brightness: Brightness.light,
  );

  static final dark = ThemeData(
    primaryColor: darkGrey,
    brightness: Brightness.dark,
  );
}

TextStyle get subHeadingStyle {
  return GoogleFonts.lato(
      textStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold));
}

TextStyle get subHeadingStyle1 {
  return GoogleFonts.lato(textStyle: const TextStyle(fontSize: 24));
}

TextStyle get headingStyle {
  return GoogleFonts.lato(
      textStyle: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold));
}

TextStyle get titleStyle {
  return GoogleFonts.lato(
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400));
}

TextStyle get subTitleStyle {
  return GoogleFonts.lato(
      textStyle: const TextStyle(
          fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black));
}
