import 'package:expense_trackr/shared/app_fonts.dart';
import 'package:flutter/material.dart';

class UpdationTitle extends StatelessWidget {
  final String text;
  const UpdationTitle({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
      child: Text(
        text,
        style: TextStyle(
            fontFamily: AppFonts.poppinsRegular,
            fontWeight: FontWeight.bold,
            color: Colors.black54),
      ),
    );
  }
}
