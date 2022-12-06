import 'package:flutter/material.dart';

class InputFormField extends StatelessWidget {
  final String label;
  final IconData prefixIcon;
  final TextInputAction textInputAction;
  final TextInputType textInputType;
  final TextEditingController controller;
  final String errorMessage;
  final bool isSpecialField;
  final bool? iconChangeValue;
  final Function()? pressToChangeSuffexIcon;
  final IconData? suffixIcon1;
  final IconData? suffixIcon2;
  final bool? obsecureTextVal;

  final String? hintText;
  final double? horizentalPadding;
  final double? verticalalPadding;
  final Color? textFieldColor;

  const InputFormField({
    super.key,
    required this.label,
    required this.prefixIcon,
    required this.textInputAction,
    required this.textInputType,
    required this.controller,
    required this.errorMessage,
    required this.isSpecialField,
    this.iconChangeValue,
    this.pressToChangeSuffexIcon,
    this.suffixIcon1,
    this.suffixIcon2,
    this.obsecureTextVal,
    this.hintText,
    this.horizentalPadding,
    this.verticalalPadding,
    this.textFieldColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: horizentalPadding ?? 20.0,
          vertical: verticalalPadding ?? 5.0),
      child: TextFormField(
        style: TextStyle(color: textFieldColor ?? Colors.black54),
        controller: controller,
        textInputAction: textInputAction,
        keyboardType: textInputType,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        obscureText: obsecureTextVal ?? false,
        decoration: InputDecoration(
          hintText: hintText ?? '',
          //hintStyle: TextStyle(color: Colors.grey),

          labelText: label,
          prefixIcon: Icon(
            prefixIcon,
            size: 20,
          ),
          suffixIcon: isSpecialField
              ? TextButton(
                  onPressed: pressToChangeSuffexIcon,
                  child: iconChangeValue ?? true
                      ? Icon(
                          suffixIcon1,
                          color: Colors.grey,
                        )
                      : Icon(
                          suffixIcon2,
                          color: Colors.grey,
                        ))
              : const SizedBox.shrink(),
        ),
        onSaved: ((newValue) {
          controller.text = newValue!.trim();
        }),
        validator: ((value) {
          if (value!.isEmpty) {
            return errorMessage;
          }
          return null;
        }),
      ),
    );
  }
}
