// ignore_for_file: prefer_const_constructors

import 'package:expense_trackr/models/bottom_sheet_items.dart';
import 'package:expense_trackr/providers/employee_provider.dart';
import 'package:expense_trackr/shared/app_colors.dart';
import 'package:expense_trackr/shared/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DropDownList extends StatelessWidget {
  final double? horizentalPadding;
  final double? verticalalPadding;
  final Function(dynamic value) tapToChangeVal;
  final List<BottomSheetItems> statusList;
  final EmployeeProvider provider;
  const DropDownList({
    super.key,
    this.horizentalPadding,
    this.verticalalPadding,
    required this.tapToChangeVal,
    required this.statusList,
    required this.provider,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: horizentalPadding ?? 20.0,
          vertical: verticalalPadding ?? 5.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            border: Border.all(color: AppColors.primaryColor)),
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              isExpanded: true,
              elevation: 16,
              hint: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Consumer<EmployeeProvider>(
                    builder: (context, value, child) {
                      return Text(provider.selectedStatusFilter == ''
                          ? "select employee status"
                              .capitalizeFirstLetterOFSentence
                          : provider.selectedStatusFilter);
                    },
                  )),
              items: statusList.map(
                (value) {
                  return DropdownMenuItem<String>(
                    value: value.itemTitle,
                    child: Text(value.itemTitle),
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
