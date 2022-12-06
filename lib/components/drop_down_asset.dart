import 'package:expense_trackr/models/employee.dart';
import 'package:expense_trackr/providers/assets_provider.dart';
import 'package:expense_trackr/shared/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/bottom_sheet_items.dart';
import '../shared/app_colors.dart';

class DropDownUserList extends StatelessWidget {
  final double? horizentalPadding;
  final double? verticalalPadding;
  final Function(dynamic value) tapToChangeVal;
  final List<Employee> employeeList;
  final AssetsProvider provider;
  const DropDownUserList({
    super.key,
    this.horizentalPadding,
    this.verticalalPadding,
    required this.tapToChangeVal,
    required this.provider,
    required this.employeeList,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: horizentalPadding ?? 20.0,
          vertical: verticalalPadding ?? 5.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            border: Border.all(color: AppColors.primaryColor)),
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              isExpanded: true,
              elevation: 16,
              hint: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Consumer<AssetsProvider>(
                    builder: (context, value, child) {
                      return Text(provider.assigini == ''
                          ? "Select assigned Employee"
                              .capitalizeFirstLetterOFSentence
                          : provider.assigini);
                    },
                  )),
              items: employeeList.map(
                (value) {
                  return DropdownMenuItem<String>(
                    onTap: () {
                      provider.setUserId(value.employeeId);
                    },
                    value: '${value.firstName} ${value.lastName}',
                    child: Text('${value.firstName} ${value.lastName}'),
                  );
                },
              ).toList(),
              onChanged: tapToChangeVal,
            ),
          ),
        ),
      ),
    );
  }
}
