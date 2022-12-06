// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'department.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Department _$DepartmentFromJson(Map<String, dynamic> json) {
  return _Department.fromJson(json);
}

/// @nodoc
mixin _$Department {
  String get departmentName => throw _privateConstructorUsedError;
  String get departmantCode => throw _privateConstructorUsedError;
  String get departmentId => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DepartmentCopyWith<Department> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DepartmentCopyWith<$Res> {
  factory $DepartmentCopyWith(
          Department value, $Res Function(Department) then) =
      _$DepartmentCopyWithImpl<$Res, Department>;
  @useResult
  $Res call(
      {String departmentName,
      String departmantCode,
      String departmentId,
      @TimestampConverter() DateTime createdAt});
}

/// @nodoc
class _$DepartmentCopyWithImpl<$Res, $Val extends Department>
    implements $DepartmentCopyWith<$Res> {
  _$DepartmentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? departmentName = null,
    Object? departmantCode = null,
    Object? departmentId = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      departmentName: null == departmentName
          ? _value.departmentName
          : departmentName // ignore: cast_nullable_to_non_nullable
              as String,
      departmantCode: null == departmantCode
          ? _value.departmantCode
          : departmantCode // ignore: cast_nullable_to_non_nullable
              as String,
      departmentId: null == departmentId
          ? _value.departmentId
          : departmentId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_DepartmentCopyWith<$Res>
    implements $DepartmentCopyWith<$Res> {
  factory _$$_DepartmentCopyWith(
          _$_Department value, $Res Function(_$_Department) then) =
      __$$_DepartmentCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String departmentName,
      String departmantCode,
      String departmentId,
      @TimestampConverter() DateTime createdAt});
}

/// @nodoc
class __$$_DepartmentCopyWithImpl<$Res>
    extends _$DepartmentCopyWithImpl<$Res, _$_Department>
    implements _$$_DepartmentCopyWith<$Res> {
  __$$_DepartmentCopyWithImpl(
      _$_Department _value, $Res Function(_$_Department) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? departmentName = null,
    Object? departmantCode = null,
    Object? departmentId = null,
    Object? createdAt = null,
  }) {
    return _then(_$_Department(
      departmentName: null == departmentName
          ? _value.departmentName
          : departmentName // ignore: cast_nullable_to_non_nullable
              as String,
      departmantCode: null == departmantCode
          ? _value.departmantCode
          : departmantCode // ignore: cast_nullable_to_non_nullable
              as String,
      departmentId: null == departmentId
          ? _value.departmentId
          : departmentId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Department implements _Department {
  const _$_Department(
      {required this.departmentName,
      required this.departmantCode,
      required this.departmentId,
      @TimestampConverter() required this.createdAt});

  factory _$_Department.fromJson(Map<String, dynamic> json) =>
      _$$_DepartmentFromJson(json);

  @override
  final String departmentName;
  @override
  final String departmantCode;
  @override
  final String departmentId;
  @override
  @TimestampConverter()
  final DateTime createdAt;

  @override
  String toString() {
    return 'Department(departmentName: $departmentName, departmantCode: $departmantCode, departmentId: $departmentId, createdAt: $createdAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Department &&
            (identical(other.departmentName, departmentName) ||
                other.departmentName == departmentName) &&
            (identical(other.departmantCode, departmantCode) ||
                other.departmantCode == departmantCode) &&
            (identical(other.departmentId, departmentId) ||
                other.departmentId == departmentId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, departmentName, departmantCode, departmentId, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DepartmentCopyWith<_$_Department> get copyWith =>
      __$$_DepartmentCopyWithImpl<_$_Department>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DepartmentToJson(
      this,
    );
  }
}

abstract class _Department implements Department {
  const factory _Department(
      {required final String departmentName,
      required final String departmantCode,
      required final String departmentId,
      @TimestampConverter() required final DateTime createdAt}) = _$_Department;

  factory _Department.fromJson(Map<String, dynamic> json) =
      _$_Department.fromJson;

  @override
  String get departmentName;
  @override
  String get departmantCode;
  @override
  String get departmentId;
  @override
  @TimestampConverter()
  DateTime get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$_DepartmentCopyWith<_$_Department> get copyWith =>
      throw _privateConstructorUsedError;
}
