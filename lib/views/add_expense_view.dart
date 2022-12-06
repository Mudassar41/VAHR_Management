// ignore_for_file: prefer_const_constructors

import 'package:expense_trackr/components/updation_title.dart';
import 'package:expense_trackr/models/bottom_sheet_items.dart';
import 'package:expense_trackr/models/expense.dart';

import 'package:expense_trackr/providers/expense_provider.dart';
import 'package:expense_trackr/service/remote_db_service.dart';
import 'package:expense_trackr/shared/bottom_sheets/app_bottom_sheets.dart';
import 'package:expense_trackr/shared/date_time_extensions.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../components/buttons.dart';
import '../components/text_field.dart';
import '../components/text_form_field.dart';
import '../shared/app_colors.dart';
import '../shared/app_fonts.dart';
import '../shared/app_toasts.dart';
import '../shared/pick_date.dart';

class AddExpenseView extends StatefulWidget {
  final Expense data;
  final String expenseId;
  final String isUpdating;

  const AddExpenseView({
    super.key,
    required this.isUpdating,
    required this.data,
    required this.expenseId,
  });

  @override
  State<AddExpenseView> createState() => _AddExpenseViewState();
}

class _AddExpenseViewState extends State<AddExpenseView> {
  final expenseTitleController = TextEditingController();
  final expenseAmountController = TextEditingController(text: '');
  final expenseAmountTypeController = TextEditingController();
  final expenseDateController = TextEditingController();
  final expenseTypeController = TextEditingController();
  final commentsController = TextEditingController(text: '');
  final expenseFormKey = GlobalKey<FormState>();
  final dbService = RemoteDBService();
  DateTime? pickedDate;

  List<BottomSheetItems> paymentTypesList = [
    BottomSheetItems('Cash', FontAwesomeIcons.moneyBill1Wave),
    BottomSheetItems('Bank Transfer', FontAwesomeIcons.moneyBillTransfer),
    BottomSheetItems('Debit/Credit', FontAwesomeIcons.creditCard)
  ];

  List<BottomSheetItems> expenseTypeList = [
    BottomSheetItems('Groceries', FontAwesomeIcons.cartShopping),
    BottomSheetItems('Rent', FontAwesomeIcons.house),
    BottomSheetItems('Maintainance', FontAwesomeIcons.screwdriverWrench),
    BottomSheetItems('Food', FontAwesomeIcons.bowlFood),
    BottomSheetItems('Utilities', FontAwesomeIcons.braille),
    BottomSheetItems('Entertainment', FontAwesomeIcons.cameraRetro),
    BottomSheetItems('Other', FontAwesomeIcons.objectGroup)
  ];

  String selectedPaymentType = '';

  String selectedExpenseType = '';

  @override
  void initState() {
    if (widget.isUpdating == 'true') {
      assignValues();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: SafeArea(
        child: Form(
          key: expenseFormKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                  child: Text(
                    widget.isUpdating == 'true'
                        ? 'Update Expense'
                        : 'Add Expense',
                    style: TextStyle(
                        fontFamily: AppFonts.poppinsBold, fontSize: 18),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                widget.isUpdating == 'true'
                    ? UpdationTitle(text: 'Entry Date')
                    : SizedBox.shrink(),
                InkWell(
                  onTap: (() async {
                    pickedDate = await PickDate.pick(context);
                    if (pickedDate != null) {
                      expenseDateController.text =
                          pickedDate!.showDate("dd-MMM-yyyy");
                    }
                  }),
                  child: IgnorePointer(
                    child: InputFormField(
                      label: 'Date',
                      textFieldColor: expenseDateController.text == 'Date'
                          ? Colors.grey
                          : Colors.black54,
                      prefixIcon: FontAwesomeIcons.calendarDay,
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.number,
                      controller: expenseDateController,
                      errorMessage: 'Pick Date',
                      isSpecialField: false,
                      //readyOnlyVal: true,
                    ),
                  ),
                ),
                widget.isUpdating == 'true'
                    ? UpdationTitle(text: 'Expense Type')
                    : SizedBox.shrink(),
                InkWell(
                  onTap: (() {
                    AppBottomSheets.showChoicesSheet(
                      sheetHieght: .5,
                      sheetTitle: 'select expense type',
                      context: context,
                      list: expenseTypeList,
                      tapToChangeVal: (value) {
                        selectedExpenseType = value;
                        expenseTypeController.text = value;
                      },
                    );
                  }),
                  child: IgnorePointer(
                    child: InputFormField(
                      label: 'Select Expense Type',
                      prefixIcon: FontAwesomeIcons.rectangleList,
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.number,
                      controller: expenseTypeController,
                      errorMessage: 'select type',
                      isSpecialField: true,
                      suffixIcon1: Icons.arrow_drop_down,
                    ),
                  ),
                ),
                widget.isUpdating == 'true'
                    ? UpdationTitle(text: 'Description')
                    : SizedBox.shrink(),
                InputFormField(
                  label: 'Description',
                  prefixIcon: FontAwesomeIcons.info,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.text,
                  controller: expenseTitleController,
                  errorMessage: 'description required',
                  isSpecialField: false,
                ),
                widget.isUpdating == 'true'
                    ? UpdationTitle(text: 'Amount')
                    : SizedBox.shrink(),
                InputFormField(
                  label: 'Amount',
                  prefixIcon: FontAwesomeIcons.moneyBill1Wave,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.number,
                  controller: expenseAmountController,
                  errorMessage: 'amount required',
                  isSpecialField: false,
                ),
                widget.isUpdating == 'true'
                    ? UpdationTitle(text: 'Payment Mode')
                    : SizedBox.shrink(),
                InkWell(
                  onTap: (() {
                    AppBottomSheets.showChoicesSheet(
                        sheetHieght: .4,
                        sheetTitle: 'select paymnet mode',
                        context: context,
                        list: paymentTypesList,
                        tapToChangeVal: (value) {
                          selectedPaymentType = value;
                          expenseAmountTypeController.text = value;
                        },
                        scrollPhysics: NeverScrollableScrollPhysics());
                  }),
                  child: IgnorePointer(
                    child: InputFormField(
                      label: 'Payment Mode',
                      prefixIcon: FontAwesomeIcons.creditCard,
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.number,
                      controller: expenseAmountTypeController,
                      errorMessage: 'select payment type',
                      isSpecialField: true,
                      suffixIcon1: Icons.arrow_drop_down,
                    ),
                  ),
                ),
                widget.isUpdating == 'true'
                    ? UpdationTitle(text: 'Comments')
                    : SizedBox.shrink(),
                InputField(
                  label: 'Comments',
                  prefixIcon: FontAwesomeIcons.commentDots,
                  textInputAction: TextInputAction.done,
                  textInputType: TextInputType.text,
                  controller: commentsController,
                  isSuffixIconRequired: false,
                  sufficIcon: Icons.arrow_drop_down,
                ),
                Consumer<ExpenseProvider>(
                  builder: (context, provider, child) {
                    return provider.isUploadingExpense
                        ? Center(child: CircularProgressIndicator())
                        : CustomButton(
                            title:
                                widget.isUpdating == 'true' ? "update" : 'save',
                            textColor: AppColors.whiteColor,
                            buttonBg: AppColors.secondaryColor,
                            pressButton: () {
                              validateForm(provider, widget.isUpdating,
                                  widget.expenseId, widget.data);
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

  validateForm(ExpenseProvider provider, String isUpdating, String expenseId,
      Expense newData) async {
    if (!expenseFormKey.currentState!.validate()) {
      return;
    } else {
      Expense expense = Expense(
          expenseId: isUpdating == 'true' ? widget.expenseId : '',
          description: expenseTitleController.text,
          amount: double.parse(expenseAmountController.text),
          date: pickedDate!,
          createdAt: isUpdating == 'true' ? newData.createdAt : DateTime.now(),
          comments: commentsController.text,
          expenseType: selectedExpenseType,
          paymentTyoe: selectedPaymentType);

      provider.setUploadingValue(true);

      expenseFormKey.currentState?.save();
      String response = isUpdating == 'true'
          ? await dbService.updateExpense(expense, expenseId)
          : await dbService.addExpense(expense);
      if (response == 'ok') {
        provider.setUploadingValue(false);
        provider.refreshData();
        AppToasts.showToast(
            message:
                isUpdating == 'true' ? 'Expense Updated' : 'Expense Added');
        context.pop();
      } else {
        provider.setUploadingValue(false);

        AppToasts.showToast(message: response);
      }
    }
  }

  @override
  void dispose() {
    disposeValues();
    super.dispose();
  }

  disposeValues() {
    expenseTitleController.dispose();
    expenseAmountController.dispose();
    expenseAmountTypeController.dispose();
    expenseDateController.dispose();
    expenseTypeController.dispose();
    commentsController.dispose();
  }

  assignValues() {
    expenseTitleController.text = widget.data.description;
    expenseAmountController.text = widget.data.amount.toInt().toString();
    expenseAmountTypeController.text = widget.data.paymentTyoe;
    selectedPaymentType = widget.data.paymentTyoe;
    expenseDateController.text = widget.data.date.showDate('dd-MMM-yyyy');
    pickedDate = widget.data.date;
    expenseTypeController.text = widget.data.expenseType;
    selectedExpenseType = widget.data.expenseType;
    commentsController.text = widget.data.comments;
  }
}
