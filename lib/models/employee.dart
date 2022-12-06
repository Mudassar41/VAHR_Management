import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_trackr/models/department.dart';
import 'package:expense_trackr/models/time_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'employee.freezed.dart';
part 'employee.g.dart';

@freezed
abstract class Employee with _$Employee {
  const factory Employee(
      {required String employeeId,
      required String employeeCode,
      required String firstName,
      required String lastName,
      required String city,
      required String address,
      required DateTime dob,
      required String cnicNo,
      required String departmentId,
      required String contactNo,
      required String emergencyPerson,
      required String emergencyPersonContact,
      required String emergencyPersonRelation,
      required String employeeStatus,
      required String employeeSalary,
      @TimestampConverter() required DateTime employeeContractStartDate,
      @TimestampConverter() required DateTime employeeContractEndDate,
      @TimestampConverter() required DateTime employeeCreatedAt}) = _Employee;

  factory Employee.fromJson(Map<String, dynamic> json) =>
      _$EmployeeFromJson(json);

  factory Employee.empty() => Employee(
      employeeId: '',
      employeeCode: '',
      firstName: '',
      lastName: '',
      city: '',
      address: '',
      dob: DateTime(0, 0, 0),
      cnicNo: '',
      departmentId: '',
      contactNo: '',
      emergencyPerson: '',
      emergencyPersonContact: '',
      emergencyPersonRelation: '',
      employeeStatus: '',
      employeeSalary: '',
      employeeContractStartDate: DateTime(0, 0, 0),
      employeeContractEndDate: DateTime(0, 0, 0),
      employeeCreatedAt: DateTime(0, 0, 0));
}
