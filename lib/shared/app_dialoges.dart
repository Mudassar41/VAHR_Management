// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_trackr/service/remote_db_service.dart';
import 'package:expense_trackr/shared/app_colors.dart';
import 'package:expense_trackr/shared/string_extensions.dart';
import 'package:flutter/material.dart';
import 'app_fonts.dart';

class AppDialogues {
  static showListOfDepartments(
      BuildContext context,
      RemoteDBService remoteDBService,
      TextEditingController textEditingController,
      String selectedDepartmentId) {
    return showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
              content: SizedBox(
                height: 300,
                width: 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Select Department',
                      style: TextStyle(fontFamily: AppFonts.poppinsBold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    StreamBuilder<QuerySnapshot>(
                      stream: remoteDBService.departmentsStream,
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return const Text('Something went wrong');
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Text("Loading");
                        }
                        return snapshot.data!.docs.isEmpty
                            ? const Center(
                                child: Text(
                                  'No Departments',
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
                                      String updatedText = snapshot
                                          .data!.docs[index]['departmentName']
                                          .toString();
                                      return InkWell(
                                        onTap: (() {
                                          selectedDepartmentId =
                                              snapshot.data!.docs[index].id;
                                          textEditingController.text =
                                              updatedText.capitalizeFirstLetter;
                                          Navigator.of(context).pop();
                                        }),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              snapshot.data!
                                                  .docs[index]['departmentName']
                                                  .toString()
                                                  .capitalizeFirstLetter,
                                              textAlign: TextAlign.left,
                                              style: const TextStyle(
                                                color: Colors.black54,
                                                fontFamily:
                                                    AppFonts.poppinsRegular,
                                              ),
                                            ),
                                            Divider(
                                              color: Colors.grey,
                                            )
                                          ],
                                        ),
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
              ));
        });
  }

  static showListOfEmployees(
      BuildContext context,
      RemoteDBService remoteDBService,
      TextEditingController textEditingController,
      String selectedUserId) {
    return showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
              content: SizedBox(
                height: 300,
                width: 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Select employee',
                      style: TextStyle(fontFamily: AppFonts.poppinsBold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    StreamBuilder<QuerySnapshot>(
                      stream: remoteDBService.employeesStream,
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return const Text('Something went wrong');
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Text("Loading");
                        }
                        return snapshot.data!.docs.isEmpty
                            ? const Center(
                                child: Text(
                                  'No Departments',
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
                                      String updatedText = snapshot
                                          .data!.docs[index]['firstName']
                                          .toString();
                                      return InkWell(
                                        onTap: (() {
                                          selectedUserId =
                                              snapshot.data!.docs[index].id;
                                          textEditingController.text =
                                              updatedText.capitalizeFirstLetter;
                                          Navigator.of(context).pop();
                                        }),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              snapshot.data!
                                                  .docs[index]['firstName']
                                                  .toString()
                                                  .capitalizeFirstLetter,
                                              textAlign: TextAlign.left,
                                              style: const TextStyle(
                                                color: Colors.black54,
                                                fontFamily:
                                                    AppFonts.poppinsRegular,
                                              ),
                                            ),
                                            Divider(
                                              color: Colors.grey,
                                            )
                                          ],
                                        ),
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
              ));
        });
  }

  static Future<void> showdeletionDialogue({
    required BuildContext context,
    required title,
    required subTitle,
    required    Function() onConfirm
  }) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title.toString().capitalizeFirstLetterOFSentence),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(subTitle),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                'Yes',
                style: TextStyle(
                    fontFamily: AppFonts.poppinsBold,
                    color: AppColors.secondaryColor),
              ),
              onPressed: () {
                onConfirm();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
