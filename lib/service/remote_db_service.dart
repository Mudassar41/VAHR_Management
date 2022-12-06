import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_trackr/models/assets.dart';
import 'package:expense_trackr/models/department.dart';
import 'package:expense_trackr/models/employee.dart';
import 'package:expense_trackr/models/expense.dart';
import 'package:expense_trackr/shared/app_toasts.dart';
import 'package:flutter/material.dart';

class RemoteDBService {
  CollectionReference employeesRef =
      FirebaseFirestore.instance.collection('Employees');

  CollectionReference departmentsRef =
      FirebaseFirestore.instance.collection('Departments');
  CollectionReference assetsRef =
      FirebaseFirestore.instance.collection('Assets');

  CollectionReference expenseRef =
      FirebaseFirestore.instance.collection('Expense');

  final Stream<QuerySnapshot> departmentsStream = FirebaseFirestore.instance
      .collection('Departments')
      .orderBy('createdAt', descending: true)
      .snapshots();

  final Stream<QuerySnapshot> employeesStream = FirebaseFirestore.instance
      .collection('Employees')
      .orderBy('employeeCreatedAt', descending: true)
      .snapshots();
  Stream collectionStream = FirebaseFirestore.instance
      .collection('Employees')
      .orderBy('employeeCreatedAt', descending: true)
      .snapshots();
  final Stream<QuerySnapshot> assetsStream = FirebaseFirestore.instance
      .collection('Assets')
      .orderBy('createdAt', descending: true)
      .snapshots();
  final Stream<QuerySnapshot> expenseStream = FirebaseFirestore.instance
      .collection('Expense')
      .orderBy('createdAt', descending: true)
      .snapshots();

  //<--------------------------- Add Department------------------------------->//
  Future<String> addDepartment(Department departments) async {
    String response = '';
    String departmentId = departmentsRef.doc().id;
    await departmentsRef
        .doc(departmentId)
        .set(departments.copyWith(departmentId: departmentId).toJson())
        .then((value) {
      response = 'ok';
    }).catchError((error) {
      response = 'Failed to add record : $error';
    });
    return response;
  }

//<--------------------------- Update Department------------------------------->//
  Future<String> updateDepartment(Department department) async {
    String response = '';

    await departmentsRef
        .doc(department.departmentId)
        .update(department.toJson())
        .then((value) {
      response = 'ok';
    }).catchError((error) {
      response = 'Failed to update record : $error';
    });
    return response;
  }

//<--------------------------- Delete Department------------------------------->//
  Future<void> deleteDepartment(String departmentId) {
    return departmentsRef.doc(departmentId).delete().then((value) {
      AppToasts.showToast(message: 'Department deleted');
    }).catchError((error) {
      AppToasts.showToast(message: 'Failed to delte : $error');
    });
  }

//<--------------------------- Add Employee------------------------------->//
  Future<String> addemployees(Employee employee) async {
    String response = '';
    String employeeId = employeesRef.doc().id;

    await employeesRef
        .add(employee.copyWith(employeeId: employeeId).toJson())
        .then((value) {
      response = 'ok';
    }).catchError((error) {
      response = 'Failed to add record : $error';
    });
    return response;
  }

//<--------------------------- Update Employee------------------------------->//
  Future<String> updateployees(Employee employee, String employeeId) async {
    String response = '';

    await employeesRef.doc(employeeId).update(employee.toJson()).then((value) {
      response = 'ok';
    }).catchError((error) {
      response = 'Failed to update record : $error';
    });
    return response;
  }

//<--------------------------- Delete Employee------------------------------->//
  Future<void> deleteEmployee(String employeeId) {
    return employeesRef.doc(employeeId).delete().then((value) {
      AppToasts.showToast(message: 'Employee deleted');
    }).catchError((error) {
      AppToasts.showToast(message: 'Failed to delete : $error');
    });
  }

//<--------------------------- Add Asset------------------------------->//
  Future<String> addAssets(Assets assets) async {
    String response = '';
    String assetId = assetsRef.doc().id;

    await assetsRef
        .doc(assetId)
        .set(assets.copyWith(assetId: assetId).toJson())
        .then((value) {
      response = 'ok';
    }).catchError((error) {
      response = 'Failed to add record : $error';
    });
    return response;
  }

//<--------------------------- Update Asset------------------------------->//
  Future<String> updateAssets(Assets assets, String assetId) async {
    String response = '';

    await assetsRef.doc(assetId).update(assets.toJson()).then((value) {
      response = 'ok';
    }).catchError((error) {
      response = 'Failed to add record : $error';
    });
    return response;
  }
//<--------------------------- Delete Asset------------------------------->//

  Future<String> deleteAssets(String assetId) async {
    String response = '';

    await assetsRef.doc(assetId).delete().then((value) {
      response = 'ok';
    }).catchError((error) {
      response = 'Failed to add record : $error';
    });
    return response;
  }

//<--------------------------- Add Expense ------------------------------->//
  Future<String> addExpense(Expense expense) async {
    String response = '';
    String uniqueId = expenseRef.doc().id;
    expense.expenseId = uniqueId;

    expense.expenseId = uniqueId;
    await expenseRef
        .doc(uniqueId)
        .set(expense.copyWith(expenseId: uniqueId).toJson())
        .then((value) {
      response = 'ok';
    }).catchError((error) {
      response = 'Failed to add record : $error';
    });
    return response;
  }

//<--------------------------- Update Expense ------------------------------->//
  Future<String> updateExpense(Expense expense, String expenseId) async {
    String response = '';

    await expenseRef.doc(expenseId).update(expense.toJson()).then((value) {
      response = 'ok';
    }).catchError((error) {
      response = 'Failed to update record : $error';
    });
    return response;
  }

//<--------------------------- delete Expense ------------------------------->//
  Future<void> deleteExpense(String expenseId) {
    return expenseRef.doc(expenseId).delete().then((value) {
      AppToasts.showToast(message: 'Expense deleted');
    }).catchError((error) {
      AppToasts.showToast(message: 'Failed to delete : $error');
    });
  }

  // Future<List<Employee>> getEmployeeData() async {
  //   var employeeJson;

  //   List<Employee> employeeList = [];

  //   QuerySnapshot snapshot = await employeesRef.get();

  //   for (var element in snapshot.docs) {
  //     String id = element['departmentId'];
  //     employeeJson = element.data();
  //     var departmemntResponse = await departmentsRef.doc(id).get();

  //     Map<String, dynamic> map = {
  //       ...employeeJson,
  //       "department": departmemntResponse.data()
  //     };
  //     Employee employee = Employee.fromJson(map);
  //     employeeList.add(employee);
  //   }

  //   return employeeList;
  // }

  Future<List<Employee>> getEmployeeList() async {
    List<Employee> employeeList = [];

    QuerySnapshot data = await employeesRef.get();

    //  print(data);
    for (var element in data.docs) {
      Map<String, dynamic> map = element.data() as Map<String, dynamic>;

      Employee employee = Employee.fromJson(map);
      employeeList.add(employee);
    }
    // print(employeeList);
    return employeeList;
  }

  Future<List<Expense>> getExpenseList() async {
    List<Expense> expenseList = [];

    QuerySnapshot data = await expenseRef.get();

    //  print(data);
    for (var element in data.docs) {
      Map<String, dynamic> map = element.data() as Map<String, dynamic>;

      Expense employee = Expense.fromJson(map);
      expenseList.add(employee);
    }
    // print(employeeList);
    return expenseList;
  }

  Future<List<Assets>> getAssetsList() async {
    List<Assets> assetsList = [];

    QuerySnapshot data = await assetsRef.get();

    //  print(data);
    for (var element in data.docs) {
      Map<String, dynamic> map = element.data() as Map<String, dynamic>;

      Assets employee = Assets.fromJson(map);
      assetsList.add(employee);
    }
    // print(employeeList);
    return assetsList;
  }

  Future<List<Department>> getDepartmentsList() async {
    List<Department> departmentsList = [];

    QuerySnapshot data = await departmentsRef.get();

    for (var element in data.docs) {

      Map<String, dynamic> map = element.data() as Map<String, dynamic>;

      Department employee = Department.fromJson(map);
      
      departmentsList.add(employee);
    }

    return departmentsList;
  }

  Future<List<Employee>> applySearch(String name, String status) async {
    List<Employee> employeeList = await getEmployeeList();

    if (name.isNotEmpty) {
      employeeList.retainWhere((element) =>
          (element.firstName + element.lastName).contains(name.toLowerCase()));
    }

    if (status.isNotEmpty) {
      employeeList.retainWhere((element) => element.employeeStatus == status);
    }

    return employeeList;
  }

  Future<List<Expense>> applyFilterExpense(
      DateTime from, DateTime to, String selectedExpenseType) async {
    List<Expense> expenseList = await getExpenseList();

    if (from != DateTime(0)) {
      expenseList.retainWhere((element) => element.date.compareTo(from) >= 0);
    }
    if (to != DateTime(0)) {
      expenseList.retainWhere((element) => element.date.compareTo(from) <= 0);
    }
    if (selectedExpenseType.isNotEmpty) {
      expenseList.retainWhere((element) =>
          element.expenseType.toLowerCase() ==
          selectedExpenseType.toLowerCase());
    }

    return expenseList;
  }

  Future<List<Assets>> applyFilterAssets(String itemName, String userId) async {
    List<Assets> assetList = await getAssetsList();

    if (itemName.isNotEmpty) {
      assetList.retainWhere((element) => element.itemName.contains(itemName));
    }
    if (userId.isNotEmpty) {
      assetList.retainWhere((element) => element.assignTo == userId);
    }

    return assetList;
  }

  Future<List<Department>> applyFilterDepartment(String departmentName) async {
    List<Department> assetList = await getDepartmentsList();

    if (departmentName.isNotEmpty) {
      assetList.retainWhere(
          (element) => element.departmentName.contains(departmentName));
    }

    return assetList;
  }
}
