// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_trackr/models/employee.dart';

import 'package:expense_trackr/providers/auth_provider.dart';
import 'package:expense_trackr/providers/employee_provider.dart';
import 'package:expense_trackr/service/remote_db_service.dart';
import 'package:expense_trackr/shared/app_colors.dart';
import 'package:expense_trackr/shared/app_fonts.dart';
import 'package:expense_trackr/shared/bottom_sheets/filter_sheets.dart';
import 'package:expense_trackr/shared/search_filter_container.dart';
import 'package:expense_trackr/shared/string_extensions.dart';
import 'package:flutter/material.dart';

import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../components/buttons.dart';
import '../components/drop_down_item.dart';
import '../components/text_field.dart';
import '../models/bottom_sheet_items.dart';
import '../shared/app_dialoges.dart';

class EmployeeView extends StatefulWidget {
  const EmployeeView({super.key});

  @override
  State<EmployeeView> createState() => _EmployeeViewState();
}

class _EmployeeViewState extends State<EmployeeView> {
  final dbService = RemoteDBService();
  Stream emplpoyeeStream =
      FirebaseFirestore.instance.collection('Employees').snapshots();
  String isUpdating = 'false';

  final employeeListController = StreamController<List<Employee>>.broadcast();
  final employeeSearchListController =
      StreamController<List<Employee>>.broadcast();
  List<BottomSheetItems> employeeStatusList = [
    BottomSheetItems('Active', FontAwesomeIcons.userLarge),
    BottomSheetItems('In Active', FontAwesomeIcons.userLargeSlash),
  ];
//<--------------------------- filter contollers initialization ------------------------------->//
  final nameFilterTextController = TextEditingController(text: '');

//<-------------------------------------------------------------------------------------------->//
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<EmployeeProvider>(context, listen: false).getEmployeeData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.secondaryColor,
          onPressed: () {
            isUpdating = 'false';
            context.pushNamed(
              'addEmployee',
              params: {
                "isUpdating": isUpdating,
                'employeeId': 'dummyId',
                'departmentName': 'No departmentName'
              },
              extra: Employee.empty(),
            );
          },
          child: const Icon(
            FontAwesomeIcons.plus,
            color: AppColors.whiteColor,
          ),
        ),
        appBar: AppBar(
          centerTitle: false,
          title: Text(
            'Employees',
            style: TextStyle(fontFamily: AppFonts.poppinsBold),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer<EmployeeProvider>(
              builder: (context, provider, child) {
                return SearchFilterContainer(
                    onTap: () {
                      provider.isFiltering
                          ? clearFilter(provider)
                          : showModalBottomSheet(
                              isDismissible: true,
                              isScrollControlled: true,
                              context: context,
                              builder: (context) {
                                return Padding(
                                  padding: MediaQuery.of(context).viewInsets,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10,
                                        right: 10,
                                        bottom: 40,
                                        top: 10),
                                    child: Wrap(
                                      children: [
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            'apply filters'
                                                .capitalizeFirstLetterOFSentence,
                                            style: TextStyle(
                                              fontFamily: AppFonts.poppinsBold,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                        InputField(
                                            horizentalPadding: 8.0,
                                            verticalalPadding: 8.0,
                                            label: 'Name',
                                            prefixIcon: Icons.description,
                                            textInputAction:
                                                TextInputAction.done,
                                            textInputType: TextInputType.text,
                                            controller:
                                                nameFilterTextController,
                                            sufficIcon: Icons.abc,
                                            isSuffixIconRequired: false),
                                        DropDownList(
                                          provider: provider,
                                          statusList: employeeStatusList,
                                          tapToChangeVal: (value) {
                                            provider.setFilteredStatus(value);
                                          },
                                          horizentalPadding: 8.0,
                                          verticalalPadding: 8.0,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(children: <Widget>[
                                            Expanded(
                                              child: CustomButton(
                                                  horizentalPadding: 1,
                                                  verticalalPadding: 1,
                                                  title: 'Apply',
                                                  pressButton: () async {
                                                    if (nameFilterTextController
                                                            .text.isEmpty &&
                                                        provider
                                                            .selectedStatusFilter
                                                            .isEmpty) {
                                                      Navigator.of(context)
                                                          .pop();
                                                    } else {
                                                      Navigator.of(context)
                                                          .pop();
                                                      provider
                                                          .setFilterValue(true);
                                                      provider.getFilteredData(
                                                          nameFilterTextController
                                                              .text,
                                                          provider
                                                              .selectedStatusFilter);
                                                    }
                                                  },
                                                  textColor: Colors.white,
                                                  buttonBg:
                                                      AppColors.primaryColor),
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
                                                  buttonBg:
                                                      AppColors.secondaryColor),
                                            ),
                                          ]),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              });
                    },
                    searchBarTitle: provider.isFiltering
                        ? "clear filters"
                        : 'search by filters',
                    searchBarIcon: provider.isFiltering
                        ? FontAwesomeIcons.xmark
                        : FontAwesomeIcons.searchengin);
              },
            ),
            Expanded(
              flex: 9,
              child: Consumer<EmployeeProvider>(
                builder: (context, provider, child) {
                  if (provider.isLoading) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Colors.blue,
                      ),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                        itemCount: provider.isFiltering
                            ? provider.filteredEmployeeList.length
                            : provider.employeeList.length,
                        itemBuilder: (context, index) {
                          Employee employee = provider.isFiltering
                              ? provider.filteredEmployeeList[index]
                              : provider.employeeList[index];

                          String departmentId = employee.departmentId;
                          String departmentName = '';
                          return Slidable(
                            key: ValueKey(index),
                            endActionPane: ActionPane(
                              dragDismissible: false,
                              motion: const ScrollMotion(),
                              dismissible: DismissiblePane(onDismissed: () {}),
                              children: [
                                SlidableAction(
                                  onPressed: (context) {
                                    isUpdating = 'true';
                                    String employeeId = employee.employeeId;

                                    if (departmentName == '') {
                                      departmentName = 'No departmentName';
                                    }

                                    context.pushNamed('addEmployee',
                                        params: {
                                          'isUpdating': isUpdating,
                                          'employeeId': employeeId,
                                          'departmentName': departmentName
                                        },
                                        extra: employee);
                                  },
                                  backgroundColor: AppColors.primaryColor,
                                  foregroundColor: Colors.white,
                                  icon: Icons.edit,
                                  label: 'Edit',
                                ),
                                SlidableAction(
                                  onPressed: (context) {
                                    AppDialogues.showdeletionDialogue(
                                      context: context,
                                      title: 'Deleting Employee',
                                      subTitle:
                                          'Are you sure to delete employee?',
                                      onConfirm: () {
                                        dbService.deleteEmployee(
                                            employee.employeeId);
                                        provider.refreshData();
                                      },
                                    );
                                  },
                                  backgroundColor: AppColors.secondaryColor,
                                  foregroundColor: Colors.white,
                                  icon: Icons.delete,
                                  label: 'Delete',
                                ),
                              ],
                            ),
                            child: InkWell(
                              onTap: () {
                                isUpdating = 'true';
                                String employeeId = employee.employeeId;
                                context.pushNamed('addEmployee',
                                    params: {
                                      'isUpdating': isUpdating,
                                      'employeeId': employeeId,
                                      'departmentName': departmentName
                                    },
                                    extra: employee);
                              },
                              child: Card(
                                elevation: 5.0,
                                child: ListTile(
                                  title: Text(
                                    "${employee.firstName} ${employee.lastName}"
                                        .capitalizeFirstLetterOFSentence,
                                    style: const TextStyle(
                                        fontFamily: AppFonts.poppinsRegular,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 2),
                                    child: Row(
                                      children: [
                                        departmentId.isNotEmpty
                                            ? FutureBuilder<DocumentSnapshot>(
                                                future: dbService.departmentsRef
                                                    .doc(departmentId)
                                                    .get(),
                                                builder: (BuildContext context,
                                                    AsyncSnapshot<
                                                            DocumentSnapshot>
                                                        snapshot) {
                                                  if (snapshot.hasError) {
                                                    return Text("");
                                                  }

                                                  if (snapshot.hasData &&
                                                      !snapshot.data!.exists) {
                                                    return Text("");
                                                  }

                                                  if (snapshot
                                                          .connectionState ==
                                                      ConnectionState.done) {
                                                    Map<String, dynamic> data =
                                                        snapshot.data!.data()
                                                            as Map<String,
                                                                dynamic>;

                                                    departmentName = data[
                                                            'departmentName']
                                                        .toString()
                                                        .capitalizeFirstLetterOFSentence;

                                                    return Text(
                                                      "${data['departmentName']}"
                                                          .capitalizeFirstLetterOFSentence,
                                                      style: TextStyle(
                                                          fontFamily: AppFonts
                                                              .poppinsRegular,
                                                          color: AppColors
                                                              .primaryColor),
                                                    );
                                                  }

                                                  return Text("");
                                                },
                                              )
                                            : SizedBox.shrink(),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        shrinkWrap: true,
                      ),
                    );
                  }
                },
              ),
            )
          ],
        ));
  }

  clearFilter(EmployeeProvider provider) {
    provider.setFilterValue(false);
    provider.setFilteredStatus('');
    nameFilterTextController.clear();
  }

  @override
  void dispose() {
    employeeListController.close();
    super.dispose();
  }
}
