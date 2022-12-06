// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:expense_trackr/models/employee.dart';

import 'package:expense_trackr/providers/employee_provider.dart';
import 'package:expense_trackr/service/remote_db_service.dart';
import 'package:expense_trackr/shared/bottom_sheets/app_bottom_sheets.dart';
import 'package:expense_trackr/shared/app_toasts.dart';
import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../components/buttons.dart';
import '../components/text_form_field.dart';
import '../components/updation_title.dart';
import '../models/bottom_sheet_items.dart';
import '../shared/app_colors.dart';
import '../shared/app_fonts.dart';
import 'package:expense_trackr/shared/date_time_extensions.dart';
import '../shared/pick_date.dart';

class AddEmployeeView extends StatefulWidget {
  final String isUpdating;
  final String employeeId;
  final String departmantName;
  final Employee data;
  const AddEmployeeView(
      {super.key,
      required this.isUpdating,
      required this.employeeId,
      required this.data,
      required this.departmantName});

  @override
  State<AddEmployeeView> createState() => _AddEmployeeViewState();
}

class _AddEmployeeViewState extends State<AddEmployeeView> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final addressController = TextEditingController();
  final dobController = TextEditingController(text: '');
  final cnicController = TextEditingController();
  final designationController = TextEditingController();
  final departmentController = TextEditingController();
  final contactController = TextEditingController();
  final emergencyPersonController = TextEditingController();
  final emergencyPersonContsctController = TextEditingController();
  final emergencyPersonRelationController = TextEditingController();
  final employeeCodeController = TextEditingController();
  final employeeCurrentSalaryController = TextEditingController();
  final employeeContractEndDateController = TextEditingController(text: '');

  final employeeContractStartDateController = TextEditingController(text: '');
  final employeeDesignationController = TextEditingController();
  final employeeStatusController = TextEditingController();
  final employeeCityController = TextEditingController();

  final employeeCreatedAt = DateTime.now();
  List<BottomSheetItems> relationList = [
    BottomSheetItems('Brother', FontAwesomeIcons.arrowRight),
    BottomSheetItems('Cousin', FontAwesomeIcons.arrowRight),
    BottomSheetItems('Uncle', FontAwesomeIcons.arrowRight),
    BottomSheetItems('Father', FontAwesomeIcons.arrowRight),
    BottomSheetItems('Relative', FontAwesomeIcons.arrowRight),
    BottomSheetItems('Other', FontAwesomeIcons.arrowRight),
  ];
  List<BottomSheetItems> employeeStatusList = [
    BottomSheetItems('Active', FontAwesomeIcons.userLarge),
    BottomSheetItems('In Active', FontAwesomeIcons.userLargeSlash),
  ];
  String selectedStatus = '';
  String selectedRelation = '';
  String selectedDepartmentId = '';
  DateTime? pickedDate;
  DateTime? joiningDate;
  DateTime? contractEndDate;
  final dbService = RemoteDBService();
  final employeeFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    if (widget.isUpdating == 'true') {
      setValues(widget.departmantName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Form(
          key: employeeFormKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 5.0),
                  child: Text(
                    widget.isUpdating == 'true'
                        ? 'Update Employee'
                        : 'Add Employee',
                    style: TextStyle(
                        fontFamily: AppFonts.poppinsBold, fontSize: 18),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                widget.isUpdating == 'true'
                    ? UpdationTitle(text: 'Employee Code')
                    : SizedBox.shrink(),
                InputFormField(
                  label: 'Employee Code',
                  prefixIcon: FontAwesomeIcons.key,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.number,
                  controller: employeeCodeController,
                  errorMessage: 'employee code required',
                  isSpecialField: false,
                ),
                widget.isUpdating == 'true'
                    ? UpdationTitle(text: 'First Name')
                    : SizedBox.shrink(),
                InputFormField(
                  label: 'First Name',
                  prefixIcon: FontAwesomeIcons.userTie,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.text,
                  controller: firstNameController,
                  errorMessage: 'First Name required',
                  isSpecialField: false,
                ),
                widget.isUpdating == 'true'
                    ? UpdationTitle(text: 'Last Name')
                    : SizedBox.shrink(),
                InputFormField(
                  label: 'Last Name',
                  prefixIcon: FontAwesomeIcons.userTie,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.text,
                  controller: lastNameController,
                  errorMessage: 'last name required',
                  isSpecialField: false,
                ),

                widget.isUpdating == 'true'
                    ? UpdationTitle(text: 'DOB')
                    : SizedBox.shrink(),
                InkWell(
                  onTap: (() async {
                    pickedDate = await PickDate.pick(context);
                    if (pickedDate != null) {
                      dobController.text = pickedDate!.showDate('dd-MMM-yyyy');
                    }
                  }),
                  child: IgnorePointer(
                    child: InputFormField(
                      label: 'DOB',
                      textFieldColor: dobController.text == ''
                          ? Colors.grey
                          : Colors.black54,
                      prefixIcon: FontAwesomeIcons.calendar,
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.number,
                      controller: dobController,
                      errorMessage: 'pick Date',
                      isSpecialField: false,
                    ),
                  ),
                ),

                widget.isUpdating == 'true'
                    ? UpdationTitle(text: 'City')
                    : SizedBox.shrink(),
                InputFormField(
                  label: 'City',
                  prefixIcon: FontAwesomeIcons.city,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.text,
                  controller: employeeCityController,
                  errorMessage: 'city required',
                  isSpecialField: false,
                ),

                widget.isUpdating == 'true'
                    ? UpdationTitle(text: 'Address')
                    : SizedBox.shrink(),

                InputFormField(
                  label: 'Address',
                  prefixIcon: FontAwesomeIcons.locationPin,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.text,
                  controller: addressController,
                  errorMessage: 'address name required',
                  isSpecialField: false,
                ),
                widget.isUpdating == 'true'
                    ? UpdationTitle(text: 'Contact No')
                    : SizedBox.shrink(),

                InputFormField(
                  label: 'Contact No',
                  prefixIcon: FontAwesomeIcons.addressCard,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.number,
                  controller: contactController,
                  errorMessage: 'Contact No required',
                  isSpecialField: false,
                ),
                widget.isUpdating == 'true'
                    ? UpdationTitle(text: 'CNIC')
                    : SizedBox.shrink(),

                InputFormField(
                  label: 'CNIC',
                  prefixIcon: FontAwesomeIcons.idCard,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.number,
                  controller: cnicController,
                  errorMessage: 'CNIC required',
                  isSpecialField: false,
                ),

                widget.isUpdating == 'true'
                    ? UpdationTitle(text: 'Contract Start Date')
                    : SizedBox.shrink(),

                InkWell(
                  onTap: (() async {
                    joiningDate = await PickDate.pick(context);
                    if (joiningDate != null) {
                      employeeContractStartDateController.text =
                          joiningDate!.showDate('dd-MMM-yyyy');
                    }
                  }),
                  child: IgnorePointer(
                    child: InputFormField(
                      label: 'Joining Date',
                      textFieldColor: dobController.text == ''
                          ? Colors.grey
                          : Colors.black54,
                      prefixIcon: FontAwesomeIcons.calendar,
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.number,
                      controller: employeeContractStartDateController,
                      errorMessage: 'pick Date',
                      isSpecialField: false,
                    ),
                  ),
                ),
                widget.isUpdating == 'true'
                    ? UpdationTitle(text: 'Contract End Date')
                    : SizedBox.shrink(),

                InkWell(
                  onTap: (() async {
                    contractEndDate = await PickDate.pick(context);
                    if (contractEndDate != null) {
                      employeeContractEndDateController.text =
                          contractEndDate!.showDate('dd-MMM-yyyy');
                    }
                  }),
                  child: IgnorePointer(
                    child: InputFormField(
                      label: 'Contract End Date',
                      textFieldColor: dobController.text == ''
                          ? Colors.grey
                          : Colors.black54,
                      prefixIcon: FontAwesomeIcons.calendar,
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.number,
                      controller: employeeContractEndDateController,
                      errorMessage: 'pick Date',
                      isSpecialField: false,
                    ),
                  ),
                ),
                widget.isUpdating == 'true'
                    ? UpdationTitle(text: 'Salary')
                    : SizedBox.shrink(),

                InputFormField(
                  label: 'Current Salary',
                  prefixIcon: FontAwesomeIcons.moneyBill1Wave,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.number,
                  controller: employeeCurrentSalaryController,
                  errorMessage: 'salary required',
                  isSpecialField: false,
                ),
                // final selectedDepartment =
                //     provider.watch(selectedDepartmentForEmployee);
                // selectedDepartmentId = selectedDepartment;

                widget.isUpdating == 'true'
                    ? UpdationTitle(text: 'Department')
                    : SizedBox.shrink(),

                InkWell(
                  onTap: (() {
                    AppBottomSheets.showDepartmentsListSheet(
                        sheetHieght: .5,
                        sheetTitle: 'select department',
                        context: context,
                        tapToChangeVal: (value, id) {
                          selectedDepartmentId = id;
                          departmentController.text = value;
                        },
                        dbService: dbService,
                        icon: FontAwesomeIcons.houseLaptop);
                  }),
                  child: IgnorePointer(
                    child: InputFormField(
                      label: 'Select Department',
                      prefixIcon: FontAwesomeIcons.houseLaptop,
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.number,
                      controller: departmentController,
                      errorMessage: 'Select Department',
                      isSpecialField: true,
                      suffixIcon1: Icons.arrow_drop_down,
                    ),
                  ),
                ),
                widget.isUpdating == 'true'
                    ? UpdationTitle(text: 'Emergency Person Name')
                    : SizedBox.shrink(),

                InputFormField(
                  label: 'Emergency Person Name',
                  prefixIcon: FontAwesomeIcons.userShield,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.text,
                  controller: emergencyPersonController,
                  errorMessage: 'Emergency Person required',
                  isSpecialField: false,
                ),

                widget.isUpdating == 'true'
                    ? UpdationTitle(text: 'Contact No')
                    : SizedBox.shrink(),

                InputFormField(
                  label: 'Emergency Contact No',
                  prefixIcon: FontAwesomeIcons.phone,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.number,
                  controller: emergencyPersonContsctController,
                  errorMessage: 'Contact No required',
                  isSpecialField: false,
                ),
                widget.isUpdating == 'true'
                    ? UpdationTitle(text: 'Relation')
                    : SizedBox.shrink(),

                InkWell(
                  onTap: (() {
                    AppBottomSheets.showChoicesSheet(
                        sheetHieght: .5,
                        sheetTitle: 'select relation',
                        context: context,
                        list: relationList,
                        tapToChangeVal: (value) {
                          selectedRelation = value;
                          emergencyPersonRelationController.text = value;
                        },
                        icon: FontAwesomeIcons.userGroup);
                  }),
                  child: IgnorePointer(
                    child: InputFormField(
                      label: 'Select Relation',
                      prefixIcon: FontAwesomeIcons.userGroup,
                      textInputAction: TextInputAction.done,
                      textInputType: TextInputType.text,
                      controller: emergencyPersonRelationController,
                      errorMessage: 'select relation',
                      isSpecialField: true,
                      suffixIcon1: Icons.arrow_drop_down,
                    ),
                  ),
                ),
                widget.isUpdating == 'true'
                    ? UpdationTitle(text: 'Status')
                    : SizedBox.shrink(),

                InkWell(
                  onTap: (() {
                    AppBottomSheets.showChoicesSheet(
                      sheetHieght: .3,
                      sheetTitle: 'select employee status',
                      context: context,
                      list: employeeStatusList,
                      tapToChangeVal: (value) {
                        employeeStatusController.text = value;
                      },
                      //  icon: FontAwesomeIcons.userLargeSlash
                    );
                  }),
                  child: IgnorePointer(
                    child: InputFormField(
                      label: 'Select Employee Status',
                      prefixIcon: FontAwesomeIcons.chartArea,
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.number,
                      controller: employeeStatusController,
                      errorMessage: 'Select status',
                      isSpecialField: true,
                      suffixIcon1: Icons.arrow_drop_down,
                    ),
                  ),
                ),
                Consumer<EmployeeProvider>(
                  builder: (context, provider, child) {
                    return provider.isUploadingEmployee
                        ? SpinKitRotatingCircle(
                            color: AppColors.secondaryColor,
                            size: 50.0,
                          )
                        : CustomButton(
                            title: 'save',
                            textColor: AppColors.whiteColor,
                            buttonBg: AppColors.secondaryColor,
                            pressButton: () {
                              validateForm(
                                  provider, widget.data, widget.isUpdating);
                            },
                          );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  validateForm(EmployeeProvider employeeProvider, Employee newData,
      String isUpdating) async {
    if (!employeeFormKey.currentState!.validate()) {
      return;
    } else {
      final employeeData = Employee(
          employeeId: isUpdating == 'true' ? newData.employeeId : "",
          employeeCode: employeeCodeController.text,
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          address: addressController.text,
          city: employeeCityController.text,
          dob: pickedDate!,
          cnicNo: cnicController.text,
          departmentId: selectedDepartmentId,
          contactNo: contactController.text,
          emergencyPerson: emergencyPersonController.text,
          emergencyPersonContact: emergencyPersonContsctController.text,
          emergencyPersonRelation: selectedRelation,
          employeeCreatedAt: isUpdating == 'true'
              ? newData.employeeCreatedAt
              : employeeCreatedAt,
          employeeContractStartDate: joiningDate!,
          employeeContractEndDate: contractEndDate!,
          employeeSalary: employeeCurrentSalaryController.text,
          employeeStatus: employeeStatusController.text);

      employeeProvider.setUploadingValue(true);
      employeeFormKey.currentState?.save();

      String response = isUpdating == 'true'
          ? await dbService.updateployees(employeeData, widget.employeeId)
          : await dbService.addemployees(employeeData);
      if (response == 'ok') {
        employeeProvider.setUploadingValue(false);

        employeeProvider.refreshData();
        AppToasts.showToast(
            message:
                isUpdating == 'true' ? "Employee Updated" : 'Employee Added');
      } else {
        employeeProvider.setUploadingValue(false);
        AppToasts.showToast(message: response);
      }
      context.pop();
    }
  }

  @override
  void dispose() {
    disposeValues();
    super.dispose();
  }

  disposeValues() {
    firstNameController.dispose();
    lastNameController.dispose();
    addressController.dispose();
    dobController.dispose();
    cnicController.dispose();
    designationController.dispose();
    departmentController.dispose();
    contactController.dispose();
    emergencyPersonController.dispose();
    emergencyPersonContsctController.dispose();
    emergencyPersonRelationController.dispose();
    employeeCodeController.dispose();
    employeeCurrentSalaryController.dispose();
    employeeContractEndDateController.dispose();
    employeeContractStartDateController.dispose();

    employeeDesignationController.dispose();
    employeeStatusController.dispose();
    employeeCityController.dispose();
  }

  void setValues(String departmantName) {
    firstNameController.text = widget.data.firstName;
    lastNameController.text = widget.data.lastName;
    addressController.text = widget.data.address;
    dobController.text = widget.data.dob.showDate('dd-MMM-yyyy');
    pickedDate = widget.data.dob;
    cnicController.text = widget.data.cnicNo;
    // designationController.text = widget.data.em;
    departmentController.text = departmantName;
    selectedDepartmentId = widget.data.departmentId;
    contactController.text = widget.data.contactNo;
    emergencyPersonController.text = widget.data.emergencyPerson;
    emergencyPersonContsctController.text = widget.data.emergencyPersonContact;
    emergencyPersonRelationController.text =
        widget.data.emergencyPersonRelation;
    selectedRelation = widget.data.emergencyPersonRelation;
    // employeeCodeController.text = widget.data.;
    employeeCurrentSalaryController.text = widget.data.employeeSalary;
    employeeContractStartDateController.text =
        widget.data.employeeContractStartDate.showDate('dd-MMM-yyyy');
    joiningDate = widget.data.employeeContractStartDate;
    employeeContractEndDateController.text =
        widget.data.employeeContractEndDate.showDate('dd-MMM-yyyy');
    contractEndDate = widget.data.employeeContractEndDate;
    // employeeDesignationController.text = widget.data.firstName;
    employeeStatusController.text = widget.data.employeeStatus;
    selectedStatus = widget.data.employeeStatus;
    employeeCityController.text = widget.data.city;
    employeeCodeController.text = widget.data.employeeCode;
  }
}
