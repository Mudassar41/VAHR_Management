import 'package:expense_trackr/models/expense.dart';
import 'package:expense_trackr/service/remote_db_service.dart';
import 'package:flutter/material.dart';

class ExpenseProvider extends ChangeNotifier {
  //<-------------------------------------------------------------------------------------------->//
  List<Expense> expenseList = [];
  List<Expense> expenseFilteredList = [];
  final dbService = RemoteDBService();
  bool isUploadingExpense = false;
  bool isfetcheingData = false;
  bool isFiltering = false;
  DateTime dateFrom = DateTime(0);
  DateTime dateTo = DateTime(0);
  String selectedExpenseType = '';
  //<-------------------------------------------------------------------------------------------->//

  setExpenseType(String newVal) {
    selectedExpenseType = newVal;
    notifyListeners();
  }

  setUploadingValue(bool newVal) {
    isUploadingExpense = newVal;
    notifyListeners();
  }

  setFilterValue(bool newValue) {
    isFiltering = newValue;
    notifyListeners();
  }

  setFetching(bool newVal) {
    isfetcheingData = newVal;
    notifyListeners();
  }

  setExpenseList(List<Expense> newVal) {
    expenseList = newVal;
    notifyListeners();
  }

  getExpenseList() async {
    setFetching(true);
    List<Expense> list = await dbService.getExpenseList();
    setExpenseList(list);
    setFetching(false);
  }

  setDateFrom(DateTime newVal) {
    dateFrom = newVal;
    notifyListeners();
  }

  setDateTo(DateTime newVal) {
    dateTo = newVal;
    notifyListeners();
  }

  setFilteredList(List<Expense> newVal) {
    expenseFilteredList = newVal;
    notifyListeners();
  }

  getFilteredList() async {
    setFetching(true);

    List<Expense> list = await dbService.applyFilterExpense(dateFrom, dateTo,selectedExpenseType);
    setFilteredList(list);
    setFetching(false);
  }

  refreshData() async {
    expenseList.clear();
    List<Expense> list = await dbService.getExpenseList();
    setExpenseList(list);
  }
}
