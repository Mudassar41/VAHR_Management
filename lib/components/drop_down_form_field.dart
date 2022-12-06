import 'package:flutter/material.dart';

class DropDownField<T> extends StatelessWidget {
  final List<T> list;
  final IconData icon;
  final String label;
  final String errorText;
  //final TextEditingController editingController;
  final Function(dynamic value) onChangeval;
  const DropDownField({
    super.key,
    required this.list,
    required this.onChangeval,
    required this.icon,
    required this.label,
    required this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
      child: DropdownButtonFormField(
        decoration: InputDecoration(labelText: label, prefixIcon: Icon(icon)),
        items: list.map((category) {
          return DropdownMenuItem(

              //      alignment: AlignmentDirectional.center,
              value: category,
              child: Text(category.toString()));
        }).toList(),
        onChanged: onChangeval,
        validator: ((value) {
          if (value.toString().isEmpty) {
            return errorText;
          }
          return null;
        }),
      ),
    );
  }
}
