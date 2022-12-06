// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:expense_trackr/components/text_field.dart';
import 'package:expense_trackr/models/assets.dart';
import 'package:expense_trackr/models/bottom_sheet_items.dart';
import 'package:expense_trackr/providers/assets_provider.dart';
import 'package:expense_trackr/service/remote_db_service.dart';
import 'package:expense_trackr/shared/app_colors.dart';
import 'package:expense_trackr/shared/app_fonts.dart';
import 'package:expense_trackr/shared/date_time_extensions.dart';
import 'package:expense_trackr/shared/pick_date.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../components/buttons.dart';
import '../components/text_form_field.dart';
import '../components/updation_title.dart';
import '../shared/bottom_sheets/app_bottom_sheets.dart';
import '../shared/app_toasts.dart';

class AddAssetsView extends StatefulWidget {
  final String isUpdating;
  final String assetsId;
  final String emploeeName;
  final Assets data;

  const AddAssetsView(
      {super.key,
      required this.isUpdating,
      required this.data,
      required this.assetsId,
      required this.emploeeName});

  @override
  State<AddAssetsView> createState() => _AddAssetsViewState();
}

class _AddAssetsViewState extends State<AddAssetsView> {
  final assetFormKey = GlobalKey<FormState>();
  String itemType = '';
  String selectedStatus = '';
  String selectedUserId = '';
  final itemNameController = TextEditingController();
  final assetsTypeController = TextEditingController();
  final priceController = TextEditingController();
  final currentPriceController = TextEditingController();
  final quantityController = TextEditingController();
  final purchaseDateController = TextEditingController(text: '');
  final assignToController = TextEditingController();
  final assetStatusController = TextEditingController();
  final itemCodeController = TextEditingController();
  final commentsController = TextEditingController();

  final List<BottomSheetItems> assetscategoryList = [
    BottomSheetItems('fixed', FontAwesomeIcons.arrowRight),
    BottomSheetItems('consumable', FontAwesomeIcons.arrowRight)
  ];
  final List<BottomSheetItems> assetsStatusList = [
    BottomSheetItems('Active', FontAwesomeIcons.arrowRight),
    BottomSheetItems('Consumed', FontAwesomeIcons.arrowRight)
  ];
  final dbService = RemoteDBService();
  DateTime? pickedDate;

  @override
  void initState() {
    super.initState();

    if (widget.isUpdating == 'true') {
      assignValuesToControllers(widget.emploeeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: assetFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 5.0),
                  child: Text(
                    widget.isUpdating == 'true' ? "Update Asset" : 'Add Assets',
                    style: TextStyle(
                        fontFamily: AppFonts.poppinsBold, fontSize: 18),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                widget.isUpdating == 'true'
                    ? UpdationTitle(text: 'Item Code')
                    : SizedBox.shrink(),
                InputFormField(
                  label: 'Item Code',
                  prefixIcon: FontAwesomeIcons.key,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.number,
                  controller: itemCodeController,
                  errorMessage: 'item code required',
                  isSpecialField: false,
                ),
                widget.isUpdating == 'true'
                    ? UpdationTitle(text: 'Item Name')
                    : SizedBox.shrink(),
                InputFormField(
                  label: 'Item Name',
                  prefixIcon: FontAwesomeIcons.fileLines,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.text,
                  controller: itemNameController,
                  errorMessage: 'name required',
                  isSpecialField: false,
                ),
                widget.isUpdating == 'true'
                    ? UpdationTitle(text: 'Asset Type')
                    : SizedBox.shrink(),
                InkWell(
                  onTap: (() {
                    AppBottomSheets.showChoicesSheet(
                        sheetHieght: .3,
                        sheetTitle: 'select asset type',
                        context: context,
                        list: assetscategoryList,
                        tapToChangeVal: (value) {
                          assetsTypeController.text = value;
                          itemType = value;
                        },
                        scrollPhysics: NeverScrollableScrollPhysics(),
                        icon: FontAwesomeIcons.wpforms);
                  }),
                  child: IgnorePointer(
                    child: InputFormField(
                      label: 'Select Asset Type',
                      prefixIcon: FontAwesomeIcons.wpforms,
                      textInputAction: TextInputAction.done,
                      textInputType: TextInputType.number,
                      controller: assetsTypeController,
                      errorMessage: 'select asset type',
                      isSpecialField: true,
                      suffixIcon1: Icons.arrow_drop_down,
                    ),
                  ),
                ),
                widget.isUpdating == 'true'
                    ? UpdationTitle(text: 'Purchase Date')
                    : SizedBox.shrink(),
                InkWell(
                  onTap: (() async {
                    pickedDate = await PickDate.pick(context);
                    if (pickedDate != null) {
                      purchaseDateController.text =
                          pickedDate!.showDate('dd-MMM-yyyy');
                    }
                  }),
                  child: IgnorePointer(
                    child: InputFormField(
                      label: 'Purchase Date',
                      textFieldColor: purchaseDateController.text == ''
                          ? Colors.grey
                          : Colors.black54,
                      prefixIcon: FontAwesomeIcons.calendar,
                      textInputAction: TextInputAction.done,
                      textInputType: TextInputType.number,
                      controller: purchaseDateController,
                      errorMessage: 'pick Date',
                      isSpecialField: false,
                    ),
                  ),
                ),
                widget.isUpdating == 'true'
                    ? UpdationTitle(text: 'Purchase Price')
                    : SizedBox.shrink(),
                InputFormField(
                  label: 'Purchase Price',
                  prefixIcon: FontAwesomeIcons.moneyBill1Wave,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.number,
                  controller: priceController,
                  errorMessage: 'Price Required',
                  isSpecialField: false,
                ),
                widget.isUpdating == 'true'
                    ? UpdationTitle(text: 'Current Price')
                    : SizedBox.shrink(),
                InputFormField(
                  label: 'Current Price',
                  prefixIcon: FontAwesomeIcons.moneyBill1Wave,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.number,
                  controller: currentPriceController,
                  errorMessage: 'price required',
                  isSpecialField: false,
                ),
                widget.isUpdating == 'true'
                    ? UpdationTitle(text: 'Assigned To')
                    : SizedBox.shrink(),
                InkWell(
                  onTap: (() {
                    AppBottomSheets.showEmployeeListSheet(
                        sheetHieght: .5,
                        sheetTitle: 'select employee',
                        context: context,
                        tapToChangeVal: (value, id) {
                          selectedUserId = id;
                          assignToController.text = value;
                        },
                        dbService: dbService,
                        icon: FontAwesomeIcons.userTie);
                  }),
                  child: IgnorePointer(
                    child: InputField(
                      label: 'Assign To (optional)',
                      prefixIcon: FontAwesomeIcons.userTie,
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.number,
                      controller: assignToController,
                      isSuffixIconRequired: true,
                      sufficIcon: Icons.arrow_drop_down,
                    ),
                  ),
                ),
                widget.isUpdating == 'true'
                    ? UpdationTitle(text: 'Comments')
                    : SizedBox.shrink(),
                InputField(
                  label: 'Comments (optional)',
                  prefixIcon: FontAwesomeIcons.commentDots,
                  textInputAction: TextInputAction.done,
                  textInputType: TextInputType.text,
                  controller: commentsController,
                  isSuffixIconRequired: false,
                  sufficIcon: Icons.arrow_drop_down,
                ),
                Consumer<AssetsProvider>(
                  builder: (BuildContext context, provider, Widget? child) {
                    return provider.isUploadingAsset
                        ? const Center(child: CircularProgressIndicator())
                        : CustomButton(
                            title:
                                widget.isUpdating == 'true' ? "Update" : 'save',
                            textColor: AppColors.whiteColor,
                            buttonBg: AppColors.secondaryColor,
                            pressButton: () async {
                              if (!assetFormKey.currentState!.validate()) {
                                return;
                              } else {
                                provider.setUploadingValue(true);
                                assetFormKey.currentState?.save();

                                Assets assets = Assets(
                                    assetId: widget.isUpdating == 'true'
                                        ? widget.assetsId
                                        : '',
                                    itemName: itemNameController.text,
                                    itemCode: itemCodeController.text,
                                    category: itemType,
                                    purchasePrice: priceController.text,
                                    currentPrice: currentPriceController.text,
                                    purchaseDate: pickedDate!,
                                    assignTo: selectedUserId,
                                    createdAt: widget.isUpdating == 'true'
                                        ? widget.data.createdAt
                                        : DateTime.now(),
                                    comments: commentsController.text);

                                String response = widget.isUpdating == 'true'
                                    ? await dbService.updateAssets(
                                        assets, widget.assetsId)
                                    : await dbService.addAssets(assets);
                                if (response == 'ok') {
                                  provider.setUploadingValue(false);

                                  provider.refreshData();
                                  AppToasts.showToast(
                                      message: widget.isUpdating == 'true'
                                          ? "Item Updated"
                                          : 'Item Added');
                                  context.pop();
                                } else {
                                  provider.setUploadingValue(false);
                                  AppToasts.showToast(message: response);
                                }
                              }
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

  @override
  void dispose() {
    super.dispose();
  }

  disposeValues() {
    itemNameController.dispose();
    assetsTypeController.dispose();
    priceController.dispose();
    currentPriceController.dispose();
    quantityController.dispose();
    purchaseDateController.dispose();
    assignToController.dispose();
    assetStatusController.dispose();
    itemCodeController.dispose();
    commentsController.dispose();
  }

  void assignValuesToControllers(String emploeeName) {
    itemNameController.text = widget.data.itemName;
    assetsTypeController.text = widget.data.category;

    itemType = widget.data.category;
    priceController.text = widget.data.purchasePrice;
    currentPriceController.text = widget.data.currentPrice ?? '';

    purchaseDateController.text =
        widget.data.purchaseDate.showDate('dd-MMM-yyyy');
    pickedDate = widget.data.purchaseDate;
    assignToController.text = emploeeName;
    selectedUserId = widget.data.assignTo ?? "";
    assetStatusController.text = widget.data.itemStatus ?? "";
    itemCodeController.text = widget.data.itemCode;
    commentsController.text = widget.data.comments ?? "";
  }
}
