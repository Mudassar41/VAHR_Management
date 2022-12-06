import 'package:flutter/material.dart';

class PickDate {
  static Future<DateTime?> pick(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Refer step 1
      firstDate: DateTime(1980),
      lastDate: DateTime(2050),
    );

    return pickedDate;
  }
}
