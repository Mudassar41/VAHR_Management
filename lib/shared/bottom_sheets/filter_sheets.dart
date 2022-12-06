// ignore_for_file: prefer_const_constructors

import 'package:expense_trackr/components/drop_down_item.dart';
import 'package:expense_trackr/components/text_field.dart';
import 'package:expense_trackr/components/text_form_field.dart';
import 'package:expense_trackr/models/bottom_sheet_items.dart';

import 'package:expense_trackr/shared/date_time_extensions.dart';
import 'package:expense_trackr/shared/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../components/buttons.dart';
import '../app_colors.dart';
import '../app_fonts.dart';
import '../pick_date.dart';

class FilterBottomSheet {
  static DateTime? pickedDate;

  static showExpenseFilterSheet(
      {required double sheetHieght,
      required String sheetTitle,
      required String buttonTitle,
      required BuildContext context,
      required TextEditingController amountCntroller,
      required TextEditingController dateController,
     }) {
    return showModalBottomSheet(
        isDismissible: true,
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * sheetHieght,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      sheetTitle.capitalizeFirstLetterOFSentence,
                      style: TextStyle(
                        fontFamily: AppFonts.poppinsBold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  // Consumer(
                  //   builder: (context, ref, child) {
                  //     return
                      
                       Column(children: [
                        InkWell(
                          onTap: (() async {
                            pickedDate = await PickDate.pick(context);
                            if (pickedDate != null) {
                              dateController.text =
                                  pickedDate!.showDate("dd-MMM-yyyy");
                            }
                          }),
                          child: IgnorePointer(
                            child: InputFormField(
                              label: 'Select Date',
                              textFieldColor: dateController.text == ''
                                  ? Colors.grey
                                  : Colors.black54,
                              prefixIcon: FontAwesomeIcons.calendarDay,
                              textInputAction: TextInputAction.next,
                              textInputType: TextInputType.number,
                              controller: dateController,
                              errorMessage: 'Pick Date',
                              isSpecialField: false,
                              horizentalPadding: 8,
                              verticalalPadding: 8,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(children: <Widget>[
                            Expanded(
                              child: CustomButton(
                                  horizentalPadding: 1,
                                  verticalalPadding: 1,
                                  title: buttonTitle,
                                  pressButton: () async {
                                    if (pickedDate != null) {
                                      // ref
                                      //     .read(dateFilter.notifier)
                                      //     .update((state) => pickedDate!);

                                      // ref
                                      //     .read(isFiltering.notifier)
                                      //     .update((state) => true);
                                    }
                                    Navigator.of(context).pop();
                                  },
                                  textColor: Colors.white,
                                  buttonBg: AppColors.primaryColor),
                            ),
                            Expanded(
                              child: CustomButton(
                                  horizentalPadding: 1,
                                  verticalalPadding: 1,
                                  title: 'Cancel',
                                  pressButton: () {
                                    Navigator.of(context).pop();
                                  },
                                  textColor: Colors.white,
                                  buttonBg: AppColors.secondaryColor),
                            ),
                          ]),
                        ),
                      ])
                 //   },
                  //)
                ],
              ),
            ),
          );
        });
  }

  static showFilterSheetWithNameField({
    required double sheetHieght,
    required String sheetTitle,
    required String buttonTitle,
    required Function() buttonPress,
    required BuildContext context,
    required TextEditingController controller1,
    required Null Function(dynamic value) getTappedValue,
    required List<BottomSheetItems> statusList,
  }) {
    return showModalBottomSheet(
        isDismissible: true,
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * sheetHieght,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      sheetTitle.capitalizeFirstLetterOFSentence,
                      style: TextStyle(
                        fontFamily: AppFonts.poppinsBold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Column(children: [
                    InputField(
                        horizentalPadding: 8.0,
                        verticalalPadding: 8.0,
                        label: 'Name',
                        prefixIcon: Icons.description,
                        textInputAction: TextInputAction.done,
                        textInputType: TextInputType.text,
                        controller: controller1,
                        sufficIcon: Icons.abc,
                        isSuffixIconRequired: false),
                    // DropDownList(
                    //   provider: re,
                    //   statusList: statusList,
                    //   tapToChangeVal: (value) {
                    //     getTappedValue(value);
                    //   },
                    //   horizentalPadding: 8.0,
                    //   verticalalPadding: 8.0, 
                    
                    // ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(children: <Widget>[
                        Expanded(
                          child: CustomButton(
                              horizentalPadding: 1,
                              verticalalPadding: 1,
                              title: buttonTitle,
                              pressButton: () {



                              //  if(controller1.text.isNotEmpty $$ )
                                //  if (controller1.text.isNotEmpty) {
                                buttonPress();
                                // }

                                Navigator.of(context).pop();
                              },
                              textColor: Colors.white,
                              buttonBg: AppColors.primaryColor),
                        ),
                        Expanded(
                          child: CustomButton(
                              horizentalPadding: 1,
                              verticalalPadding: 1,
                              title: 'Cancel',
                              pressButton: () {
                                Navigator.of(context).pop();
                              },
                              textColor: Colors.white,
                              buttonBg: AppColors.secondaryColor),
                        ),
                      ]),
                    ),
                  ])
                ],
              ),
            ),
          );
        });
  }
}
