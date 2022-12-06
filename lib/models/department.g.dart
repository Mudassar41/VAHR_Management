// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'department.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Department _$$_DepartmentFromJson(Map<String, dynamic> json) =>
    _$_Department(
      departmentName: json['departmentName'] as String,
      departmantCode: json['departmantCode'] as String,
      departmentId: json['departmentId'] as String,
      createdAt:
          const TimestampConverter().fromJson(json['createdAt'] as Timestamp),
    );

Map<String, dynamic> _$$_DepartmentToJson(_$_Department instance) =>
    <String, dynamic>{
      'departmentName': instance.departmentName,
      'departmantCode': instance.departmantCode,
      'departmentId': instance.departmentId,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
    };
