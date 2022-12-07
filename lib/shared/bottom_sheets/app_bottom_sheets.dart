// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_trackr/models/bottom_sheet_items.dart';
import 'package:expense_trackr/service/remote_db_service.dart';
import 'package:expense_trackr/shared/app_colors.dart';
import 'package:expense_trackr/shared/app_fonts.dart';
import 'package:expense_trackr/shared/app_toasts.dart';
import 'package:expense_trackr/shared/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../components/buttons.dart';
import '../../components/text_field.dart';
import '../../components/text_form_field.dart';
import '../../models/department.dart';

class AppBottomSheets {
  static showChoicesSheet(
      {required double sheetHieght,
      required String sheetTitle,
      required BuildContext context,
      required List<BottomSheetItems> list,
      required final Function(dynamic value) tapToChangeVal,
      ScrollPhysics? scrollPhysics,
      IconData? icon}) {
    return showModalBottomSheet(
        isDismissible: true,
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
                  Expanded(
                    child: ListView.builder(
                      physics: scrollPhysics ?? ScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: ((context, index) {
                        return Column(
                          children: [
                            ListTile(
                              leading: Icon(
                                icon ?? list[index].icon,
                                color: AppColors.primaryColor,
                              ),
                              title: Text(
                                list[index].itemTitle.capitalizeFirstLetter,
                                style: TextStyle(
                                  fontFamily: AppFonts.poppinsRegular,
                                ),
                              ),
                              onTap: () {
                                tapToChangeVal(list[index].itemTitle);

                                Navigator.pop(context);
                              },
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Divider(),
                            )
                          ],
                        );
                      }),
                      itemCount: list.length,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  static showEmployeeListSheet(
      {required double sheetHieght,
      required String sheetTitle,
      required BuildContext context,
      required final Function(dynamic value, dynamic id) tapToChangeVal,
      required RemoteDBService dbService,
      IconData? icon}) {
    return showModalBottomSheet(
        isScrollControlled: true,
        isDismissible: true,
        context: context,
        builder: (context) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                //crossAxisAlignment: CrossAxisAlignment.start,
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
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: SizedBox(
                      height: 50,
                      child: TextField(
                        decoration: InputDecoration(

                            ///  hintText: 'Search Employee',
                            labelText: 'Search Employee',
                            prefixIcon: Icon(
                              FontAwesomeIcons.magnifyingGlass,
                              size: 15,
                            )),
                      ),
                    ),
                  ),
                  StreamBuilder<QuerySnapshot>(
                    stream: dbService.employeesStream,
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return const Text('Something went wrong');
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: const Text("Loading"));
                      }
                      return snapshot.data!.docs.isEmpty
                          ? const Center(
                              child: Text(
                                'No Employee Found',
                                style: TextStyle(
                                    fontFamily: AppFonts.poppinsRegular,
                                    fontSize: 18),
                              ),
                            )
                          : Scrollbar(
                              child: SizedBox(
                                height: 250,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: const ScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      leading: Icon(
                                        icon ?? FontAwesomeIcons.arrowRight,
                                        color: AppColors.primaryColor,
                                      ),
                                      title: Text(
                                        '${snapshot.data!.docs[index]['firstName']} ${snapshot.data!.docs[index]['lastName']}'
                                            .capitalizeFirstLetterOFSentence,
                                        style: TextStyle(
                                            fontFamily: AppFonts.poppinsRegular,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black45),
                                      ),
                                      onTap: () {
                                        tapToChangeVal(
                                            snapshot
                                                .data!.docs[index]['firstName']
                                                .toString()
                                                .capitalizeFirstLetter,
                                            snapshot.data!.docs[index].id);

                                        Navigator.pop(context);
                                      },
                                    );
                                  },
                                  itemCount: snapshot.data!.docs.length,
                                ),
                              ),
                            );
                    },
                  ),
                ],
              ),
            ),
          );
        }).whenComplete(() => print('sheet closed'));
  }

  static showFieldSheet(
      {required double sheetHieght,
      required String sheetTitle,
      required String buttonTitle,
      required BuildContext context,
      String? hintText,
      required TextEditingController controller,
      required GlobalKey<FormState> formKey,
      required RemoteDBService dbService,
      String? id,
      DateTime? createdAt}) {
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
                  SizedBox(
                      height: 150,
                      child: SingleChildScrollView(
                        child: Column(children: [
                          Form(
                            key: formKey,
                            child: InputFormField(
                              label: 'Name',
                              //hintText: hintText,
                              prefixIcon: Icons.description,
                              textInputAction: TextInputAction.next,
                              textInputType: TextInputType.text,
                              controller: controller,
                              errorMessage: 'Department required',
                              isSpecialField: false,
                              horizentalPadding: 8,
                              verticalalPadding: 8,
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
                                      if (!formKey.currentState!.validate()) {
                                        return;
                                      } else {
                                        Navigator.of(context).pop();
                                        formKey.currentState?.save();
                                        final departmentData = Department(
                                            departmantCode: '',
                                            departmentId: id.toString(),
                                            departmentName: controller.text,
                                            createdAt:
                                                createdAt ?? DateTime.now());

                                        String res = id == null
                                            ? await dbService
                                                .addDepartment(departmentData)
                                            : await dbService.updateDepartment(
                                                departmentData);

                                        if (res == 'ok') {
                                          controller.clear();
                                        } else {
                                          AppToasts.showToast(message: res);
                                        }
                                      }
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
                        ]),
                      ))
                ],
              ),
            ),
          );
        });
  }

  static showDepartmentsListSheet(
      {required double sheetHieght,
      required String sheetTitle,
      required BuildContext context,
      required final Function(dynamic value, dynamic id) tapToChangeVal,
      required RemoteDBService dbService,
      IconData? icon}) {
    return showModalBottomSheet(
        isDismissible: true,
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
                  StreamBuilder<QuerySnapshot>(
                    stream: dbService.departmentsStream,
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return const Text('Something went wrong');
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: const Text("Loading"));
                      }
                      return snapshot.data!.docs.isEmpty
                          ? const Center(
                              child: Text(
                                'No Department Found',
                                style: TextStyle(
                                    fontFamily: AppFonts.poppinsRegular,
                                    fontSize: 18),
                              ),
                            )
                          : Expanded(
                              child: Scrollbar(
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: const ScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ListTile(
                                          leading: Icon(
                                            icon ?? FontAwesomeIcons.arrowRight,
                                            color: AppColors.primaryColor,
                                          ),
                                          title: Text(
                                            snapshot.data!
                                                .docs[index]['departmentName']
                                                .toString()
                                                .capitalizeFirstLetter,
                                            style: TextStyle(
                                              fontFamily:
                                                  AppFonts.poppinsRegular,
                                            ),
                                          ),
                                          onTap: () {
                                            tapToChangeVal(
                                                snapshot
                                                    .data!
                                                    .docs[index]
                                                        ['departmentName']
                                                    .toString()
                                                    .capitalizeFirstLetter,
                                                snapshot.data!.docs[index].id);

                                            Navigator.pop(context);
                                          },
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20.0),
                                          child: Divider(),
                                        )
                                      ],
                                    );
                                  },
                                  itemCount: snapshot.data!.docs.length,
                                ),
                              ),
                            );
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
