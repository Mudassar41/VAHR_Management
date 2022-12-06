import 'package:expense_trackr/shared/app_colors.dart';
import 'package:expense_trackr/shared/app_fonts.dart';
import 'package:flutter/material.dart';

InputDecorationTheme inputDecorationTheme = const InputDecorationTheme(
    labelStyle: TextStyle(color: Colors.grey, fontFamily: 'poppinsRegular'),
    floatingLabelBehavior: FloatingLabelBehavior.never,
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primaryColor),
        borderRadius: BorderRadius.all(Radius.circular(5.0))),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primaryColor),
        borderRadius: BorderRadius.all(Radius.circular(5.0))),
    border: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.primaryColor),
    ));

CardTheme cardTheme = const CardTheme(
  elevation: 5.0,
  shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(5))),
);
AppBarTheme appBarTheme = const AppBarTheme(
    elevation: 0.0,
    backgroundColor: Colors.white,
    iconTheme: IconThemeData(
      color: Colors.black54,
    ));

TextTheme textTheme = const TextTheme(
    headline1: TextStyle(fontFamily: AppFonts.poppinsRegular),
    headline2: TextStyle(fontFamily: AppFonts.poppinsRegular),
    bodyText2: TextStyle(fontFamily: AppFonts.poppinsRegular),
    subtitle1: TextStyle(fontFamily: AppFonts.poppinsRegular),
    button: TextStyle(fontFamily: 'poppinsRegular'));
BottomSheetThemeData bottomSheetThemeData = const BottomSheetThemeData(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
  top: Radius.circular(20),
)));
