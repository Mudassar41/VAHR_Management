// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_trackr/models/department.dart';

import 'package:expense_trackr/providers/department_provider.dart';
import 'package:expense_trackr/service/remote_db_service.dart';
import 'package:expense_trackr/shared/app_colors.dart';
import 'package:expense_trackr/shared/app_fonts.dart';
import 'package:flutter/material.dart';

import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:expense_trackr/shared/string_extensions.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../components/buttons.dart';
import '../components/text_field.dart';
import '../shared/app_dialoges.dart';
import '../shared/search_filter_container.dart';

class DepartmentsView extends StatefulWidget {
  DepartmentsView({super.key});

  @override
  State<DepartmentsView> createState() => _DepartmentsViewState();
}

class _DepartmentsViewState extends State<DepartmentsView> {
  final addDepartmentController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  RemoteDBService remoteDBService = RemoteDBService();
  final key = GlobalKey<AnimatedListState>();
  final departmentNameFilterController = TextEditingController();

  String isUpdating = 'false';
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DepartmentProvider>(context, listen: false)
          .getDepartmentList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'Departments',
          style: TextStyle(fontFamily: AppFonts.poppinsBold),
        ),
      ),
      body: SafeArea(
        child: Consumer<DepartmentProvider>(
          builder: (context, provider, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SearchFilterContainer(
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
                                            label: 'Department name',
                                            prefixIcon: Icons.description,
                                            textInputAction:
                                                TextInputAction.done,
                                            textInputType: TextInputType.text,
                                            controller:
                                                departmentNameFilterController,
                                            sufficIcon: Icons.abc,
                                            isSuffixIconRequired: false),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(children: <Widget>[
                                            Expanded(
                                              child: CustomButton(
                                                  horizentalPadding: 1,
                                                  verticalalPadding: 1,
                                                  title: 'apply',
                                                  pressButton: () {
                                                    if (departmentNameFilterController
                                                        .text.isEmpty) {
                                                      Navigator.of(context)
                                                          .pop();
                                                    } else {
                                                      provider
                                                          .setFilterValue(true);

                                                      provider.getFilteredList(
                                                          departmentNameFilterController
                                                              .text);
                                                      Navigator.of(context)
                                                          .pop();
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
                        : FontAwesomeIcons.searchengin),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Consumer<DepartmentProvider>(
                      builder: (context, provider, child) {
                        if (provider.isfetcheingData) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: Colors.blue,
                            ),
                          );
                        } else {
                          return ListView.builder(
                            itemCount: provider.isFiltering
                                ? provider.filteredDepartmentList.length
                                : provider.departmentList.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              Department department = provider.isFiltering
                                  ? provider.filteredDepartmentList[index]
                                  : provider.departmentList[index];
                               print(department);
                              return Slidable(
                                key: const ValueKey(0),
                                endActionPane: ActionPane(
                                  dragDismissible: false,
                                  motion: const ScrollMotion(),
                                  dismissible:
                                      DismissiblePane(onDismissed: () {}),
                                  children: [
                                    SlidableAction(
                                      onPressed: (context) {
                                        isUpdating = 'true';
                                        context.pushNamed(
                                          'addDepartment',
                                          params: {
                                            "isUpdating": isUpdating,
                                            'departmentId':
                                                department.departmentId,
                                          },
                                          extra: department,
                                        );
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
                                          title: 'Deleting Departing',
                                          subTitle:
                                              'Are you sure to delete department?',
                                          onConfirm: () {
                                            remoteDBService.deleteDepartment(
                                                department.departmentId);
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
                                    context.pushNamed(
                                      'addDepartment',
                                      params: {
                                        "isUpdating": isUpdating,
                                        'departmentId': department.departmentId,
                                      },
                                      extra: department,
                                    );
                                  },
                                  child: Card(
                                    child: ListTile(
                                      title: Text(
                                        department.departmentName.toString()
                                            .capitalizeFirstLetterOFSentence,
                                        style: const TextStyle(
                                            fontFamily:
                                                AppFonts.poppinsRegular),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      },
                    )),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        onPressed: () {
          isUpdating = 'false';
          context.pushNamed(
            'addDepartment',
            params: {
              "isUpdating": isUpdating,
              'departmentId': 'dummyId',
            },
            extra: Department.empty(),
          );

          // AppBottomSheets.showFieldSheet(
          //     buttonTitle: 'add',
          //     dbService: remoteDBService,
          //     formKey: formKey,
          //     sheetHieght: .3,
          //     sheetTitle: 'add department',
          //     context: context,
          //     controller: addDepartmentController);
        },
        child: const Icon(
          FontAwesomeIcons.plus,
          color: Colors.white,
        ),
      ),
    );
  }

  clearFilter(DepartmentProvider provider) {
    provider.setFilterValue(false);
    provider.setFilteredList([]);
    departmentNameFilterController.clear();
  }

  // clearFilter(WidgetRef ref) {
  //   ref.read(isFilteringDepartment.notifier).update((state) => false);
  //   controller.clear();
  //   ref.read(filteredDepartment.notifier).update((state) => '');
  // }
}
