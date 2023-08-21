import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'color_theme.dart';

final textSmall = TextStyle(
    fontSize: Get.textTheme.titleSmall?.fontSize?.toDouble(),
    decoration: TextDecoration.none,
    fontWeight: FontWeight.w400,
    fontFamily: GoogleFonts.roboto().fontFamily,
    color: textColor);
final textMedium = TextStyle(
    fontSize: Get.textTheme.titleMedium?.fontSize?.toDouble(),
    decoration: TextDecoration.none,
    fontWeight: FontWeight.w400,
    fontFamily: GoogleFonts.roboto().fontFamily,
    color: textColor);
final textLarge = TextStyle(
    fontSize: Get.textTheme.titleLarge?.fontSize?.toDouble(),
    decoration: TextDecoration.none,
    fontWeight: FontWeight.w400,
    fontFamily: GoogleFonts.roboto().fontFamily,
    color: textColor);
final textXLarge = TextStyle(
    fontSize: Get.textTheme.headlineSmall?.fontSize?.toDouble(),
    decoration: TextDecoration.none,
    fontWeight: FontWeight.w400,
    fontFamily: GoogleFonts.roboto().fontFamily,
    color: textColor);

final textTitleSmall = TextStyle(
    fontSize: Get.textTheme.titleSmall?.fontSize?.toDouble(),
    fontWeight: FontWeight.bold,
    decoration: TextDecoration.none,
    fontFamily: GoogleFonts.roboto().fontFamily,
    color: textColor);
final textTitleMedium = TextStyle(
    fontSize: Get.textTheme.titleMedium?.fontSize?.toDouble(),
    fontWeight: FontWeight.bold,
    decoration: TextDecoration.none,
    fontFamily: GoogleFonts.roboto().fontFamily,
    color: textColor);
final textTitleLarge = TextStyle(
    fontSize: Get.textTheme.titleLarge?.fontSize?.toDouble(),
    fontWeight: FontWeight.bold,
    decoration: TextDecoration.none,
    fontFamily: GoogleFonts.roboto().fontFamily,
    color: textColor);
final textTitleXLarge = TextStyle(
    fontSize: Get.textTheme.headlineLarge?.fontSize?.toDouble(),
    fontWeight: FontWeight.bold,
    decoration: TextDecoration.none,
    fontFamily: GoogleFonts.roboto().fontFamily,
    color: textColor);
final textTitleXXLarge = TextStyle(
    fontSize: (Get.textTheme.headlineLarge?.fontSize?.toDouble() ?? 0.0 * 1.5),
    fontWeight: FontWeight.bold,
    decoration: TextDecoration.none,
    fontFamily: GoogleFonts.roboto().fontFamily,
    color: textColor);