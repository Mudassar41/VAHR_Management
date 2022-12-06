import 'package:expense_trackr/shared/string_extensions.dart';
import 'package:expense_trackr/shared/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomIconButton extends StatelessWidget {
  final String title;
  final Color textColor;
  final Color buttonBg;
  final Function() pressButton;
  final double? horizentalPadding;
  final double? verticalalPadding;
  const CustomIconButton(
      {super.key,
      required this.title,
      required this.pressButton,
      required this.textColor,
      required this.buttonBg,
      this.horizentalPadding,
      this.verticalalPadding});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: horizentalPadding ?? 20.0,
          vertical: verticalalPadding ?? 5.0),
      child: SizedBox(
        height: 48,
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: buttonBg),
          onPressed: pressButton,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                FontAwesomeIcons.google,
                color: Colors.white,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                title.capitalizeFirstLetterOFSentence,
                style: TextStyle(fontWeight: FontWeight.bold, color: textColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
