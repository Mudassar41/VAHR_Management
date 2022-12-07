// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:expense_trackr/components/buttons.dart';
import 'package:expense_trackr/models/department.dart';
import 'package:expense_trackr/providers/department_provider.dart';
import 'package:expense_trackr/shared/app_colors.dart';
import 'package:expense_trackr/shared/app_toasts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../components/text_form_field.dart';
import '../components/updation_title.dart';
import '../service/remote_db_service.dart';
import '../shared/app_fonts.dart';

class AddDepartmentView extends StatefulWidget {
  final String isUpdating;
  final String departmentId;
  final Department data;

  const AddDepartmentView(
      {super.key,
      required this.isUpdating,
      required this.departmentId,
      required this.data});

  @override
  State<AddDepartmentView> createState() => _AddDepartmentViewState();
}

class _AddDepartmentViewState extends State<AddDepartmentView> {
  final departmentNameTextController = TextEditingController();
  final departmentNumTextController = TextEditingController();
  final dbService = RemoteDBService();
  final departmentFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.isUpdating == 'true') {
      setValues();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: Form(
          key: departmentFormKey,
          child: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                child: Text(
                  widget.isUpdating == 'true'
                      ? 'Update Department'
                      : 'Add Department',
                  style:
                      TextStyle(fontFamily: AppFonts.poppinsBold, fontSize: 18),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              widget.isUpdating == 'true'
                  ? UpdationTitle(text: 'Department Code')
                  : SizedBox.shrink(),
              InputFormField(
                label: 'Department Code',
                prefixIcon: FontAwesomeIcons.key,
                textInputAction: TextInputAction.next,
                textInputType: TextInputType.text,
                controller: departmentNumTextController,
                errorMessage: 'department code required',
                isSpecialField: false,
              ),
              widget.isUpdating == 'true'
                  ? UpdationTitle(text: 'Department Name')
                  : SizedBox.shrink(),
              InputFormField(
                label: 'Department Name',
                prefixIcon: FontAwesomeIcons.houseLaptop,
                textInputAction: TextInputAction.next,
                textInputType: TextInputType.text,
                controller: departmentNameTextController,
                errorMessage: 'First Name required',
                isSpecialField: false,
              ),
              Consumer<DepartmentProvider>(
                builder: (context, provider, child) {
                  return provider.isUploadingDepartment
                      ? Center(child: CircularProgressIndicator())
                      : CustomButton(
                          title: widget.isUpdating == 'true'
                              ? "update department"
                              : 'add department',
                          pressButton: () async {
                            if (!departmentFormKey.currentState!.validate()) {
                              return;
                            } else {
                              provider.setUploadingValue(true);
                              Department department = Department(
                                  departmentName:
                                      departmentNameTextController.text.trim(),
                                  departmantCode:
                                      departmentNumTextController.text,
                                  departmentId: widget.isUpdating == 'true'
                                      ? widget.departmentId
                                      : '',
                                  createdAt: widget.isUpdating == 'true'
                                      ? widget.data.createdAt
                                      : DateTime.now());

                              String res = widget.isUpdating == 'true'
                                  ? await dbService.updateDepartment(department)
                                  : await dbService.addDepartment(department);
                              if (res == 'ok') {
                                provider.refreshData();
                                provider.setUploadingValue(false);
                                Navigator.of(context).pop();

                                AppToasts.showToast(
                                    message: widget.isUpdating == 'true'
                                        ? "`department updated"
                                        : 'Department added');
                              } else {
                                AppToasts.showToast(message: res);
                                provider.setUploadingValue(false);
                              }
                            }
                          },
                          textColor: Colors.white,
                          buttonBg: AppColors.secondaryColor);
                },
              )
            ],
          ))),
    );
  }

  void setValues() {
    departmentNameTextController.text = widget.data.departmentName;
    departmentNumTextController.text = widget.data.departmantCode;
  }
}
