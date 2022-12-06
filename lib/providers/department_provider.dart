import 'package:expense_trackr/models/department.dart';
import 'package:flutter/material.dart';

import '../service/remote_db_service.dart';

class DepartmentProvider extends ChangeNotifier {
  //<-------------------------------------------------------------------------------------------->//
  bool isfetcheingData = false;
  bool isFiltering = false;
  bool isUploadingDepartment = false;
  List<Department> departmentList = [];
  List<Department> filteredDepartmentList = [];
  final dbService = RemoteDBService();
  //<-------------------------------------------------------------------------------------------->//

  setUploadingValue(bool newVal) {
    isUploadingDepartment = newVal;
    notifyListeners();
  }

  setFilterValue(bool newValue) {
    isFiltering = newValue;
    notifyListeners();
  }

  setDepartmentsList(List<Department> newVal) {
    departmentList = newVal;
    notifyListeners();
  }

  setFetching(bool newVal) {
    isfetcheingData = newVal;
    notifyListeners();
  }

  getDepartmentList() async {
    setFetching(true);
    
    List<Department> list = await dbService.getDepartmentsList();
    setDepartmentsList(list);
    setFetching(false);
  }

  setFilteredList(List<Department> newVal) {
    filteredDepartmentList = newVal;
    notifyListeners();
  }

  getFilteredList(String departmentName) async {
    setFetching(true);
    List<Department> list =
        await dbService.applyFilterDepartment(departmentName);
    setFilteredList(list);
    setFetching(false);
  }

  refreshData() async {
    departmentList.clear();
    List<Department> list = await dbService.getDepartmentsList();
    setDepartmentsList(list);
  }
}
