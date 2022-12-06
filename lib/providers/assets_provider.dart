import 'package:expense_trackr/models/assets.dart';
import 'package:expense_trackr/service/remote_db_service.dart';
import 'package:flutter/material.dart';

class AssetsProvider extends ChangeNotifier {
  //<-------------------------------------------------------------------------------------------->//
  bool isUploadingAsset = false;
  bool isfetcheingData = false;
  bool isFiltering = false;
  List<Assets> assetsList = [];
  List<Assets> filteredAssetsList = [];
  final dbService = RemoteDBService();
  String assigini = '';
  String assignedEmployeeId = '';
  //<-------------------------------------------------------------------------------------------->//
  setUploadingValue(bool newVal) {
    isUploadingAsset = newVal;
    notifyListeners();
  }

  setFilterValue(bool newValue) {
    isFiltering = newValue;
    notifyListeners();
  }

  setAssetsList(List<Assets> newVal) {
    assetsList = newVal;
    notifyListeners();
  }

  setFetching(bool newVal) {
    isfetcheingData = newVal;
    notifyListeners();
  }

  getAssetsList() async {
    setFetching(true);
    List<Assets> list = await dbService.getAssetsList();
    setAssetsList(list);
    setFetching(false);
  }

  setAssigni(String newVal) {
    assigini = newVal;
    notifyListeners();
  }

  setUserId(String newVal) {
    assignedEmployeeId = newVal;
    notifyListeners();
  }

  setFilteredList(List<Assets> newVal) {
    filteredAssetsList = newVal;
    notifyListeners();
  }

  getFilteredAssets(String itemName) async {
    setFetching(true);
    List<Assets> list =
        await dbService.applyFilterAssets(itemName, assignedEmployeeId);
    setFilteredList(list);
    setFetching(false);
  }

  refreshData() async {
    assetsList.clear();
    List<Assets> list = await dbService.getAssetsList();
    setAssetsList(list);
  }
}
