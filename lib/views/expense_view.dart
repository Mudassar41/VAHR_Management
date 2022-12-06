// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_trackr/components/drop_down_expense_type.dart';
import 'package:expense_trackr/models/expense.dart';
import 'package:expense_trackr/providers/expense_provider.dart';
import 'package:expense_trackr/service/remote_db_service.dart';
import 'package:expense_trackr/shared/app_dialoges.dart';
import 'package:expense_trackr/shared/date_time_extensions.dart';
import 'package:expense_trackr/shared/search_filter_container.dart';
import 'package:expense_trackr/shared/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../components/buttons.dart';
import '../components/text_field.dart';
import '../models/bottom_sheet_items.dart';
import '../shared/app_colors.dart';
import '../shared/app_fonts.dart';
import '../shared/pick_date.dart';

class ExpensesView extends StatefulWidget {
  const ExpensesView({super.key});

  @override
  State<ExpensesView> createState() => _ExpensesViewState();
}

class _ExpensesViewState extends State<ExpensesView> {
  String isUpdating = 'false';

  final dbService = RemoteDBService();
  List<BottomSheetItems> expenseTypeList = [
    BottomSheetItems('Groceries', FontAwesomeIcons.cartShopping),
    BottomSheetItems('Rent', FontAwesomeIcons.house),
    BottomSheetItems('Maintainance', FontAwesomeIcons.screwdriverWrench),
    BottomSheetItems('Food', FontAwesomeIcons.bowlFood),
    BottomSheetItems('Utilities', FontAwesomeIcons.braille),
    BottomSheetItems('Entertainment', FontAwesomeIcons.cameraRetro),
    BottomSheetItems('Other', FontAwesomeIcons.objectGroup)
  ];
//<--------------------------- filter contollers initialization ------------------------------->//

  final dateFilterFromController = TextEditingController(text: '');
  final dateFilterToController = TextEditingController(text: '');
  String expenseTypeFilter = '';
  DateTime? dateFrom;
  DateTime? dateTo;
//<-------------------------------------------------------------------------------------------->//
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ExpenseProvider>(context, listen: false).getExpenseList();
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
            context.pushNamed(
              'addExpense',
              params: {
                "isUpdating": isUpdating.toString(),
                'expenseId': 'dummyId'
              },
              extra: Expense.empty(),
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
            'Expense',
            style: TextStyle(fontFamily: AppFonts.poppinsBold),
          ),
        ),
        body: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer<ExpenseProvider>(
              builder: (context, provider, child) {
                return Expanded(
                    flex: 1,
                    child: SearchFilterContainer(
                      searchBarIcon: provider.isFiltering
                          ? FontAwesomeIcons.xmark
                          : FontAwesomeIcons.searchengin,
                      searchBarTitle: provider.isFiltering
                          ? 'clear filters'
                          : 'search by filters',
                      onTap: () {
                        provider.isFiltering
                            ? clearFilters(provider)
                            : showModalBottomSheet(
                                isDismissible: true,
                                isScrollControlled: true,
                                context: context,
                                builder: (context) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10,
                                        right: 10,
                                        bottom: 40,
                                        top: 10),
                                    child: Wrap(
                                      // crossAxisAlignment:
                                      //     CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            provider.isFiltering
                                                ? "Clear filters"
                                                : "Apply filters"
                                                    .capitalizeFirstLetterOFSentence,
                                            style: TextStyle(
                                              fontFamily: AppFonts.poppinsBold,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),

                                        Column(children: [
                                          InkWell(
                                            onTap: (() async {
                                              dateFrom =
                                                  await PickDate.pick(context);
                                              if (dateFrom != null) {
                                                dateFilterFromController.text =
                                                    dateFrom!.showDate(
                                                        "dd-MMM-yyyy");

                                                provider.setDateFrom(dateFrom!);
                                              }
                                            }),
                                            child: IgnorePointer(
                                              child: InputField(
                                                label: 'Date From',
                                                textFieldColor:
                                                    dateFilterFromController
                                                                .text ==
                                                            ''
                                                        ? Colors.grey
                                                        : Colors.black54,
                                                prefixIcon: FontAwesomeIcons
                                                    .calendarDay,
                                                textInputAction:
                                                    TextInputAction.next,
                                                textInputType:
                                                    TextInputType.number,
                                                controller:
                                                    dateFilterFromController,
                                                horizentalPadding: 8,
                                                verticalalPadding: 8,
                                                isSuffixIconRequired: false,
                                                sufficIcon: Icons.abc,
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: (() async {
                                              dateTo =
                                                  await PickDate.pick(context);
                                              if (dateTo != null) {
                                                dateFilterToController.text =
                                                    dateTo!.showDate(
                                                        "dd-MMM-yyyy");

                                                provider.setDateTo(dateTo!);
                                              }
                                            }),
                                            child: IgnorePointer(
                                              child: InputField(
                                                label: 'Date To',
                                                textFieldColor:
                                                    dateFilterToController
                                                                .text ==
                                                            ''
                                                        ? Colors.grey
                                                        : Colors.black54,
                                                prefixIcon: FontAwesomeIcons
                                                    .calendarDay,
                                                textInputAction:
                                                    TextInputAction.next,
                                                textInputType:
                                                    TextInputType.number,
                                                controller:
                                                    dateFilterToController,
                                                horizentalPadding: 8,
                                                verticalalPadding: 8,
                                                isSuffixIconRequired: false,
                                                sufficIcon: Icons.abc,
                                              ),
                                            ),
                                          ),
                                          DropDownExpenseType(
                                            horizentalPadding: 8,
                                            verticalalPadding: 8,
                                            tapToChangeVal: (value) {
                                              provider.setExpenseType(value);
                                            },
                                            expensTypeList: expenseTypeList,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(children: <Widget>[
                                              Expanded(
                                                child: CustomButton(
                                                    horizentalPadding: 1,
                                                    verticalalPadding: 1,
                                                    title: 'apply',
                                                    pressButton: () async {
                                                      if (dateFrom == null &&
                                                          dateTo == null) {
                                                        Navigator.of(context)
                                                            .pop();
                                                      } else {
                                                        provider
                                                            .getFilteredList();
                                                        Navigator.of(context)
                                                            .pop();

                                                        provider.setFilterValue(
                                                            true);
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
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    textColor: Colors.white,
                                                    buttonBg: AppColors
                                                        .secondaryColor),
                                              ),
                                            ]),
                                          ),
                                        ])
                                        //   },
                                        //)
                                      ],
                                    ),
                                  );
                                });
                      },
                    ));
              },
            ),
            Expanded(
                flex: 8,
                child: Consumer<ExpenseProvider>(
                  builder: (context, provider, child) {
                    if (provider.isfetcheingData) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.builder(
                            itemCount: provider.isFiltering
                                ? provider.expenseFilteredList.length
                                : provider.expenseList.length,
                            itemBuilder: (context, index) {
                              Expense expense = provider.isFiltering
                                  ? provider.expenseFilteredList[index]
                                  : provider.expenseList[index];

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
                                        String expensId = expense.expenseId;
                                        context.pushNamed('addExpense',
                                            params: {
                                              'isUpdating':
                                                  isUpdating.toString(),
                                              'expenseId': expensId
                                            },
                                            extra: expense);
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
                                          title: 'Deleting Expense',
                                          subTitle:
                                              'Are you sure to delete expense?',
                                          onConfirm: () {
                                            dbService.deleteExpense(
                                                expense.expenseId);
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
                                    String expensId = expense.expenseId;
                                    context.pushNamed('addExpense',
                                        params: {
                                          'isUpdating': isUpdating.toString(),
                                          'expenseId': expensId
                                        },
                                        extra: expense);
                                  },
                                  child: Card(
                                    child: ListTile(
                                      title: Text(
                                        expense.description
                                            .capitalizeFirstLetterOFSentence,
                                        style: const TextStyle(
                                            fontFamily: AppFonts.poppinsRegular,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 2),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            //need refactoring
                                            Text(
                                              "${expense.amount}0",
                                              style: TextStyle(
                                                  fontFamily:
                                                      AppFonts.poppinsRegular,
                                                  color:
                                                      AppColors.primaryColor),
                                            ),
                                            Text(
                                              expense.date
                                                  .showDate('dd-MM-yyyy'),
                                              style: TextStyle(
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
                          ));
                    }
                  },
                )),
            Consumer<ExpenseProvider>(
              builder: (context, provider, child) {
                return Expanded(
                    flex: 1,
                    child: provider.isFiltering
                        ? SizedBox.shrink()
                        : StreamBuilder<QuerySnapshot>(
                            stream: dbService.expenseStream,
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasError) {
                                return Text('Something went wrong');
                              }

                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Text("Loading");
                              }

                              double sumTotal = 0;
                              for (var doc in snapshot.data!.docs) {
                                sumTotal = sumTotal +
                                    doc["amount"]; // make sure you create the variable sumTotal somewhere
                              }
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 5.0),
                                child: Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      'Total',
                                      style: TextStyle(
                                          fontFamily: AppFonts.poppinsBold,
                                          color: AppColors.primaryColor),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      "$sumTotal${0}",
                                      style: TextStyle(
                                        fontFamily: AppFonts.poppinsBold,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ));
              },
            )
          ],
        )
            //   },
            ));
  }

  clearFilters(ExpenseProvider provider) {
    provider.setFilterValue(false);
    provider.setDateFrom(DateTime(0));
    provider.setDateTo(DateTime(0));
    provider.setFilteredList([]);
    provider.setExpenseType('');
    dateFilterFromController.clear();
    dateFilterToController.clear();
  }
}
