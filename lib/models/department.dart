import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_trackr/models/time_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'department.freezed.dart';
part 'department.g.dart';

@freezed
class Department with _$Department {
  const factory Department(
      {required String departmentName,
      required String departmantCode,
      required String departmentId,
      @TimestampConverter() required DateTime createdAt}) = _Department;

  factory Department.fromJson(Map<String, dynamic> json) =>
      _$DepartmentFromJson(json);

  factory Department.empty() => Department(
      departmentName: '',
      departmantCode: '',
      departmentId: '',
      createdAt: DateTime.now());
}
