import 'package:flutter/material.dart';

import '../models/employee.dart';
import '../service/remote_db_service.dart';

class EmployeeProvider extends ChangeNotifier {
  //<------------------------------ initializing variables------------------------------------->//
  bool isUploadingEmployee = false;
  final dbService = RemoteDBService();
  bool isLoading = false;
  List<Employee> employeeList = [];
  List<Employee> filteredEmployeeList = [];
  bool isFiltering = false;

  String selectedStatusFilter = '';
  //<-------------------------------------------------------------------------------------------->//

  setFilteredStatus(String newVal) {
    selectedStatusFilter = newVal;
    notifyListeners();
  }

  setLoading(bool newVal) {
    isLoading = newVal;
    notifyListeners();
  }

  setEmployeeList(List<Employee> newEmployeeList) {
    employeeList = newEmployeeList;
    notifyListeners();
  }

  setFilterValue(bool newValue) {
    isFiltering = newValue;
    notifyListeners();
  }

  getEmployeeData() async {
    setLoading(true);
    List<Employee> list = await dbService.getEmployeeList();

    setEmployeeList(list);
    setLoading(false);
  }

  setFilteredList(List<Employee> newFilteredList) {
    filteredEmployeeList = newFilteredList;
    notifyListeners();
  }

  getFilteredData(String employeename, String status) async {
    setLoading(true);

    List<Employee> filteredList =
        await dbService.applySearch(employeename, status);
    setFilteredList(filteredList);
    setLoading(false);
  }

  setUploadingValue(bool newVal) {
    isUploadingEmployee = newVal;
    notifyListeners();
  }

  refreshData() async {
    employeeList.clear();
    List<Employee> list = await dbService.getEmployeeList();

    setEmployeeList(list);
  }
}
