import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyle {
  static Color bgColor = Color.fromRGBO(226, 226, 255, 1);
  static Color mainColor = Color(0xFF000633);
  static Color accentColor = Color(0xFF0065FF);
  static Color accentColor2 = Color.fromARGB(255, 39, 125, 254);
  static List<Color> cardsColor = [
    Colors.white,
    Colors.red.shade100,
    Colors.pink.shade100,
    Colors.orange.shade100,
    Colors.yellow.shade100,
    Colors.green.shade100,
    Colors.blue.shade100,
    Colors.blueGrey.shade100,
  ];

  static TextStyle mainTitle =
      GoogleFonts.roboto(fontSize: 30.0, fontWeight: FontWeight.bold);

  static TextStyle mainNoteTitle = GoogleFonts.roboto(
      fontSize: 18.0, fontWeight: FontWeight.bold, color: mainColor);

  static TextStyle mainTitle2 = GoogleFonts.roboto(
      fontSize: 25.0, fontWeight: FontWeight.bold, color: bgColor);

  static TextStyle mainContent =
      GoogleFonts.nunito(fontSize: 16.0, fontWeight: FontWeight.normal);

  static TextStyle mainContent2 = GoogleFonts.nunito(
      fontSize: 16.0, fontWeight: FontWeight.normal, color: bgColor);

  static TextStyle mainContentError = GoogleFonts.nunito(
      fontSize: 16.0, fontWeight: FontWeight.normal, color: Colors.red);

  static TextStyle mainContent3 = GoogleFonts.nunito(
      fontSize: 16.0, fontWeight: FontWeight.normal, color: Colors.grey);

  static TextStyle dateTitle =
      GoogleFonts.roboto(fontSize: 13.0, fontWeight: FontWeight.w500);

  static TextStyle inf = GoogleFonts.roboto(
      fontSize: 20.0, fontWeight: FontWeight.w500, color: bgColor);
}
