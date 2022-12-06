import 'package:expense_trackr/shared/string_extensions.dart';
import 'package:expense_trackr/shared/app_colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final Color textColor;
  final Color buttonBg;
  final Function() pressButton;
  final double? horizentalPadding;
  final double? verticalalPadding;
  const CustomButton(
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
          child: AnimatedSwitcher(
            duration: const Duration(seconds: 1),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return ScaleTransition(
                scale: animation,
                child: child,
              );
            },
            child: Text(
              title.capitalizeFirstLetterOFSentence,
              key: ValueKey<String>(title.toString().capitalizeFirstLetter),
              style: TextStyle(fontWeight: FontWeight.bold, color: textColor),
            ),
          ),
        ),
      ),
    );
  }
}
