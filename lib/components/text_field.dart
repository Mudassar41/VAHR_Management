import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String label;
  final IconData prefixIcon;
  final TextInputAction textInputAction;
  final TextInputType textInputType;
  final TextEditingController controller;
  final IconData sufficIcon;
  final double? horizentalPadding;
  final double? verticalalPadding;
  final Color? textFieldColor;
  final bool isSuffixIconRequired;

  const InputField({
    super.key,
    required this.label,
    required this.prefixIcon,
    required this.textInputAction,
    required this.textInputType,
    required this.controller,
    this.horizentalPadding,
    this.verticalalPadding,
    this.textFieldColor,
    required this.sufficIcon,
    required this.isSuffixIconRequired,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: horizentalPadding ?? 20.0,
          vertical: verticalalPadding ?? 5.0),
      child: TextField(
        style: TextStyle(color: textFieldColor ?? Colors.black54),
        controller: controller,
        textInputAction: textInputAction,
        keyboardType: textInputType,
        decoration: InputDecoration(
          labelText: label,
          suffixIcon: Icon(sufficIcon,
              color: isSuffixIconRequired ? Colors.grey : Colors.white),
          prefixIcon: Icon(
            prefixIcon,
            size: 20,
          ),
        ),
      ),
    );
  }
}
