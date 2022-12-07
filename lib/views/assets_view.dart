// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_trackr/components/drop_down_asset.dart';
import 'package:expense_trackr/models/assets.dart';
import 'package:expense_trackr/providers/assets_provider.dart';
import 'package:expense_trackr/providers/employee_provider.dart';
import 'package:expense_trackr/service/remote_db_service.dart';
import 'package:expense_trackr/shared/app_colors.dart';
import 'package:expense_trackr/shared/date_time_extensions.dart';
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
import '../shared/app_fonts.dart';
import '../shared/search_filter_container.dart';

class AssetsView extends StatefulWidget {
  const AssetsView({super.key});

  @override
  State<AssetsView> createState() => _AssetsViewState();
}

class _AssetsViewState extends State<AssetsView> {
  String isUpdating = 'false';
  final dbService = RemoteDBService();
  final List<BottomSheetItems> assetscategoryList = [
    BottomSheetItems('fixed', FontAwesomeIcons.arrowRight),
    BottomSheetItems('consumable', FontAwesomeIcons.arrowRight)
  ];
  final nameFilterTextController = TextEditingController(text: '');

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AssetsProvider>(context, listen: false).getAssetsList();
      Provider.of<EmployeeProvider>(context, listen: false).getEmployeeData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.secondaryColor,
          onPressed: () {
            isUpdating = 'false';
            context.pushNamed('addAsset',
                params: {
                  'isUpdating': isUpdating.toString(),
                  'assetId': 'dummyId',
                  'employeeName': "No Employee"
                },
                extra: Assets.empty());
          },
          child: const Icon(
            FontAwesomeIcons.plus,
            color: AppColors.whiteColor,
          ),
        ),
        appBar: AppBar(
          centerTitle: false,
          title: Text(
            'Assets',
            style: TextStyle(fontFamily: AppFonts.poppinsBold),
          ),
        ),
        body: Column(
          children: [
            Consumer<AssetsProvider>(
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
                                        bottom: 20,
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
                                            label: 'Item name',
                                            prefixIcon: Icons.description,
                                            textInputAction:
                                                TextInputAction.done,
                                            textInputType: TextInputType.text,
                                            controller:
                                                nameFilterTextController,
                                            sufficIcon: Icons.abc,
                                            isSuffixIconRequired: false),
                                        Consumer<EmployeeProvider>(
                                          builder: (context, employeeProvider,
                                              child) {
                                            if (employeeProvider.isLoading) {
                                              return Center(
                                                  child: Text(
                                                      'loading employees'));
                                            } else {
                                              return DropDownUserList(
                                                provider: provider,
                                                employeeList: employeeProvider
                                                    .employeeList,
                                                tapToChangeVal: (value) {
                                                  provider.setAssigni(value);
                                                },
                                                horizentalPadding: 8.0,
                                                verticalalPadding: 8.0,
                                              );
                                            }
                                          },
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
                                                            .assignedEmployeeId
                                                            .isEmpty) {
                                                      Navigator.of(context)
                                                          .pop();
                                                    } else {
                                                      provider
                                                          .setFilterValue(true);
                                                      provider.getFilteredAssets(
                                                          nameFilterTextController
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
                        : FontAwesomeIcons.searchengin);
              },
            ),
            Consumer<AssetsProvider>(
              builder: (context, provider, child) {
                if (provider.isfetcheingData) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.blue,
                    ),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        ListView.builder(
                          itemCount: provider.isFiltering
                              ? provider.filteredAssetsList.length
                              : provider.assetsList.length,
                          itemBuilder: (context, index) {
                            Assets assets = provider.isFiltering
                                ? provider.filteredAssetsList[index]
                                : provider.assetsList[index];

                            String employeeName = '';
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
                                      if (employeeName == '') {
                                        employeeName = 'No Employee';
                                      }

                                      String assetId = assets.assetId;

                                      isUpdating = 'true';
                                      context.pushNamed('addAsset',
                                          params: {
                                            'isUpdating': isUpdating.toString(),
                                            'assetId': assetId,
                                            'employeeName': employeeName
                                          },
                                          extra: assets);
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
                                        title: 'Deleting Assets',
                                        subTitle:
                                            'Are you sure to delete asset?',
                                        onConfirm: () {
                                          dbService
                                              .deleteAssets(assets.assetId);
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
                                  String assetId = assets.assetId;

                                  // print(assets);
                                  // print(employeeName);
                                  if (employeeName == '') {
                                    employeeName = 'No Employee';
                                  }
                                  isUpdating = 'true';
                                  context.pushNamed('addAsset',
                                      params: {
                                        'isUpdating': isUpdating.toString(),
                                        'assetId': assetId,
                                        'employeeName': employeeName
                                      },
                                      extra: assets);
                                },
                                child: Card(
                                  child: ListTile(
                                    title: Text(
                                      assets.itemName
                                          .capitalizeFirstLetterOFSentence,
                                      style: const TextStyle(
                                          fontFamily: AppFonts.poppinsRegular,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87),
                                    ),
                                    subtitle: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 2),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            assets.purchasePrice,
                                            style: const TextStyle(
                                                fontFamily:
                                                    AppFonts.poppinsRegular,
                                                color: AppColors.primaryColor),
                                          ),
                                          assets.assignTo!.isNotEmpty
                                              ? FutureBuilder<DocumentSnapshot>(
                                                  future: dbService.employeesRef
                                                      .doc(assets.assignTo)
                                                      .get(),
                                                  builder: (BuildContext
                                                          context,
                                                      AsyncSnapshot<
                                                              DocumentSnapshot>
                                                          snapshot) {
                                                    if (snapshot.hasError) {
                                                      return Text("");
                                                    }

                                                    if (snapshot.hasData &&
                                                        !snapshot
                                                            .data!.exists) {
                                                      return Text("");
                                                    }

                                                    if (snapshot
                                                            .connectionState ==
                                                        ConnectionState.done) {
                                                      Map<String, dynamic>
                                                          data =
                                                          snapshot.data!.data()
                                                              as Map<String,
                                                                  dynamic>;

                                                      employeeName = data[
                                                              'firstName']
                                                          .toString()
                                                          .capitalizeFirstLetterOFSentence;

                                                      return Text(
                                                        "",
                                                        style: TextStyle(
                                                            fontFamily: AppFonts
                                                                .poppinsRegular,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: AppColors
                                                                .secondaryColor),
                                                      );
                                                    }

                                                    return Text("");
                                                  },
                                                )
                                              : SizedBox.shrink(),
                                          Text(
                                            assets.purchaseDate
                                                .showDate('dd-MM-yyyy'),
                                            style: const TextStyle(
                                                fontFamily:
                                                    AppFonts.poppinsRegular),
                                          )
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
                      ],
                    ),
                  );
                }
              },
            ),
          ],
        ));
  }

  clearFilter(AssetsProvider provider) {
    provider.setFilteredList([]);
    provider.assignedEmployeeId = '';
    provider.assigini = '';
    provider.setFilterValue(false);
    nameFilterTextController.clear();
  }
}
