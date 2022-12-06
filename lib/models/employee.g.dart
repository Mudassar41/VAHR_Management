// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Employee _$$_EmployeeFromJson(Map<String, dynamic> json) => _$_Employee(
      employeeId: json['employeeId'] as String,
      employeeCode: json['employeeCode'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      city: json['city'] as String,
      address: json['address'] as String,
      dob: DateTime.parse(json['dob'] as String),
      cnicNo: json['cnicNo'] as String,
      departmentId: json['departmentId'] as String,
      contactNo: json['contactNo'] as String,
      emergencyPerson: json['emergencyPerson'] as String,
      emergencyPersonContact: json['emergencyPersonContact'] as String,
      emergencyPersonRelation: json['emergencyPersonRelation'] as String,
      employeeStatus: json['employeeStatus'] as String,
      employeeSalary: json['employeeSalary'] as String,
      employeeContractStartDate: const TimestampConverter()
          .fromJson(json['employeeContractStartDate'] as Timestamp),
      employeeContractEndDate: const TimestampConverter()
          .fromJson(json['employeeContractEndDate'] as Timestamp),
      employeeCreatedAt: const TimestampConverter()
          .fromJson(json['employeeCreatedAt'] as Timestamp),
    );

Map<String, dynamic> _$$_EmployeeToJson(_$_Employee instance) =>
    <String, dynamic>{
      'employeeId': instance.employeeId,
      'employeeCode': instance.employeeCode,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'city': instance.city,
      'address': instance.address,
      'dob': instance.dob.toIso8601String(),
      'cnicNo': instance.cnicNo,
      'departmentId': instance.departmentId,
      'contactNo': instance.contactNo,
      'emergencyPerson': instance.emergencyPerson,
      'emergencyPersonContact': instance.emergencyPersonContact,
      'emergencyPersonRelation': instance.emergencyPersonRelation,
      'employeeStatus': instance.employeeStatus,
      'employeeSalary': instance.employeeSalary,
      'employeeContractStartDate':
          const TimestampConverter().toJson(instance.employeeContractStartDate),
      'employeeContractEndDate':
          const TimestampConverter().toJson(instance.employeeContractEndDate),
      'employeeCreatedAt':
          const TimestampConverter().toJson(instance.employeeCreatedAt),
    };
