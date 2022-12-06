// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'employee.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Employee _$EmployeeFromJson(Map<String, dynamic> json) {
  return _Employee.fromJson(json);
}

/// @nodoc
mixin _$Employee {
  String get employeeId => throw _privateConstructorUsedError;
  String get employeeCode => throw _privateConstructorUsedError;
  String get firstName => throw _privateConstructorUsedError;
  String get lastName => throw _privateConstructorUsedError;
  String get city => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  DateTime get dob => throw _privateConstructorUsedError;
  String get cnicNo => throw _privateConstructorUsedError;
  String get departmentId => throw _privateConstructorUsedError;
  String get contactNo => throw _privateConstructorUsedError;
  String get emergencyPerson => throw _privateConstructorUsedError;
  String get emergencyPersonContact => throw _privateConstructorUsedError;
  String get emergencyPersonRelation => throw _privateConstructorUsedError;
  String get employeeStatus => throw _privateConstructorUsedError;
  String get employeeSalary => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get employeeContractStartDate => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get employeeContractEndDate => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get employeeCreatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EmployeeCopyWith<Employee> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmployeeCopyWith<$Res> {
  factory $EmployeeCopyWith(Employee value, $Res Function(Employee) then) =
      _$EmployeeCopyWithImpl<$Res, Employee>;
  @useResult
  $Res call(
      {String employeeId,
      String employeeCode,
      String firstName,
      String lastName,
      String city,
      String address,
      DateTime dob,
      String cnicNo,
      String departmentId,
      String contactNo,
      String emergencyPerson,
      String emergencyPersonContact,
      String emergencyPersonRelation,
      String employeeStatus,
      String employeeSalary,
      @TimestampConverter() DateTime employeeContractStartDate,
      @TimestampConverter() DateTime employeeContractEndDate,
      @TimestampConverter() DateTime employeeCreatedAt});
}

/// @nodoc
class _$EmployeeCopyWithImpl<$Res, $Val extends Employee>
    implements $EmployeeCopyWith<$Res> {
  _$EmployeeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? employeeId = null,
    Object? employeeCode = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? city = null,
    Object? address = null,
    Object? dob = null,
    Object? cnicNo = null,
    Object? departmentId = null,
    Object? contactNo = null,
    Object? emergencyPerson = null,
    Object? emergencyPersonContact = null,
    Object? emergencyPersonRelation = null,
    Object? employeeStatus = null,
    Object? employeeSalary = null,
    Object? employeeContractStartDate = null,
    Object? employeeContractEndDate = null,
    Object? employeeCreatedAt = null,
  }) {
    return _then(_value.copyWith(
      employeeId: null == employeeId
          ? _value.employeeId
          : employeeId // ignore: cast_nullable_to_non_nullable
              as String,
      employeeCode: null == employeeCode
          ? _value.employeeCode
          : employeeCode // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      city: null == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      dob: null == dob
          ? _value.dob
          : dob // ignore: cast_nullable_to_non_nullable
              as DateTime,
      cnicNo: null == cnicNo
          ? _value.cnicNo
          : cnicNo // ignore: cast_nullable_to_non_nullable
              as String,
      departmentId: null == departmentId
          ? _value.departmentId
          : departmentId // ignore: cast_nullable_to_non_nullable
              as String,
      contactNo: null == contactNo
          ? _value.contactNo
          : contactNo // ignore: cast_nullable_to_non_nullable
              as String,
      emergencyPerson: null == emergencyPerson
          ? _value.emergencyPerson
          : emergencyPerson // ignore: cast_nullable_to_non_nullable
              as String,
      emergencyPersonContact: null == emergencyPersonContact
          ? _value.emergencyPersonContact
          : emergencyPersonContact // ignore: cast_nullable_to_non_nullable
              as String,
      emergencyPersonRelation: null == emergencyPersonRelation
          ? _value.emergencyPersonRelation
          : emergencyPersonRelation // ignore: cast_nullable_to_non_nullable
              as String,
      employeeStatus: null == employeeStatus
          ? _value.employeeStatus
          : employeeStatus // ignore: cast_nullable_to_non_nullable
              as String,
      employeeSalary: null == employeeSalary
          ? _value.employeeSalary
          : employeeSalary // ignore: cast_nullable_to_non_nullable
              as String,
      employeeContractStartDate: null == employeeContractStartDate
          ? _value.employeeContractStartDate
          : employeeContractStartDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      employeeContractEndDate: null == employeeContractEndDate
          ? _value.employeeContractEndDate
          : employeeContractEndDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      employeeCreatedAt: null == employeeCreatedAt
          ? _value.employeeCreatedAt
          : employeeCreatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_EmployeeCopyWith<$Res> implements $EmployeeCopyWith<$Res> {
  factory _$$_EmployeeCopyWith(
          _$_Employee value, $Res Function(_$_Employee) then) =
      __$$_EmployeeCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String employeeId,
      String employeeCode,
      String firstName,
      String lastName,
      String city,
      String address,
      DateTime dob,
      String cnicNo,
      String departmentId,
      String contactNo,
      String emergencyPerson,
      String emergencyPersonContact,
      String emergencyPersonRelation,
      String employeeStatus,
      String employeeSalary,
      @TimestampConverter() DateTime employeeContractStartDate,
      @TimestampConverter() DateTime employeeContractEndDate,
      @TimestampConverter() DateTime employeeCreatedAt});
}

/// @nodoc
class __$$_EmployeeCopyWithImpl<$Res>
    extends _$EmployeeCopyWithImpl<$Res, _$_Employee>
    implements _$$_EmployeeCopyWith<$Res> {
  __$$_EmployeeCopyWithImpl(
      _$_Employee _value, $Res Function(_$_Employee) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? employeeId = null,
    Object? employeeCode = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? city = null,
    Object? address = null,
    Object? dob = null,
    Object? cnicNo = null,
    Object? departmentId = null,
    Object? contactNo = null,
    Object? emergencyPerson = null,
    Object? emergencyPersonContact = null,
    Object? emergencyPersonRelation = null,
    Object? employeeStatus = null,
    Object? employeeSalary = null,
    Object? employeeContractStartDate = null,
    Object? employeeContractEndDate = null,
    Object? employeeCreatedAt = null,
  }) {
    return _then(_$_Employee(
      employeeId: null == employeeId
          ? _value.employeeId
          : employeeId // ignore: cast_nullable_to_non_nullable
              as String,
      employeeCode: null == employeeCode
          ? _value.employeeCode
          : employeeCode // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      city: null == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      dob: null == dob
          ? _value.dob
          : dob // ignore: cast_nullable_to_non_nullable
              as DateTime,
      cnicNo: null == cnicNo
          ? _value.cnicNo
          : cnicNo // ignore: cast_nullable_to_non_nullable
              as String,
      departmentId: null == departmentId
          ? _value.departmentId
          : departmentId // ignore: cast_nullable_to_non_nullable
              as String,
      contactNo: null == contactNo
          ? _value.contactNo
          : contactNo // ignore: cast_nullable_to_non_nullable
              as String,
      emergencyPerson: null == emergencyPerson
          ? _value.emergencyPerson
          : emergencyPerson // ignore: cast_nullable_to_non_nullable
              as String,
      emergencyPersonContact: null == emergencyPersonContact
          ? _value.emergencyPersonContact
          : emergencyPersonContact // ignore: cast_nullable_to_non_nullable
              as String,
      emergencyPersonRelation: null == emergencyPersonRelation
          ? _value.emergencyPersonRelation
          : emergencyPersonRelation // ignore: cast_nullable_to_non_nullable
              as String,
      employeeStatus: null == employeeStatus
          ? _value.employeeStatus
          : employeeStatus // ignore: cast_nullable_to_non_nullable
              as String,
      employeeSalary: null == employeeSalary
          ? _value.employeeSalary
          : employeeSalary // ignore: cast_nullable_to_non_nullable
              as String,
      employeeContractStartDate: null == employeeContractStartDate
          ? _value.employeeContractStartDate
          : employeeContractStartDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      employeeContractEndDate: null == employeeContractEndDate
          ? _value.employeeContractEndDate
          : employeeContractEndDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      employeeCreatedAt: null == employeeCreatedAt
          ? _value.employeeCreatedAt
          : employeeCreatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Employee implements _Employee {
  const _$_Employee(
      {required this.employeeId,
      required this.employeeCode,
      required this.firstName,
      required this.lastName,
      required this.city,
      required this.address,
      required this.dob,
      required this.cnicNo,
      required this.departmentId,
      required this.contactNo,
      required this.emergencyPerson,
      required this.emergencyPersonContact,
      required this.emergencyPersonRelation,
      required this.employeeStatus,
      required this.employeeSalary,
      @TimestampConverter() required this.employeeContractStartDate,
      @TimestampConverter() required this.employeeContractEndDate,
      @TimestampConverter() required this.employeeCreatedAt});

  factory _$_Employee.fromJson(Map<String, dynamic> json) =>
      _$$_EmployeeFromJson(json);

  @override
  final String employeeId;
  @override
  final String employeeCode;
  @override
  final String firstName;
  @override
  final String lastName;
  @override
  final String city;
  @override
  final String address;
  @override
  final DateTime dob;
  @override
  final String cnicNo;
  @override
  final String departmentId;
  @override
  final String contactNo;
  @override
  final String emergencyPerson;
  @override
  final String emergencyPersonContact;
  @override
  final String emergencyPersonRelation;
  @override
  final String employeeStatus;
  @override
  final String employeeSalary;
  @override
  @TimestampConverter()
  final DateTime employeeContractStartDate;
  @override
  @TimestampConverter()
  final DateTime employeeContractEndDate;
  @override
  @TimestampConverter()
  final DateTime employeeCreatedAt;

  @override
  String toString() {
    return 'Employee(employeeId: $employeeId, employeeCode: $employeeCode, firstName: $firstName, lastName: $lastName, city: $city, address: $address, dob: $dob, cnicNo: $cnicNo, departmentId: $departmentId, contactNo: $contactNo, emergencyPerson: $emergencyPerson, emergencyPersonContact: $emergencyPersonContact, emergencyPersonRelation: $emergencyPersonRelation, employeeStatus: $employeeStatus, employeeSalary: $employeeSalary, employeeContractStartDate: $employeeContractStartDate, employeeContractEndDate: $employeeContractEndDate, employeeCreatedAt: $employeeCreatedAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Employee &&
            (identical(other.employeeId, employeeId) ||
                other.employeeId == employeeId) &&
            (identical(other.employeeCode, employeeCode) ||
                other.employeeCode == employeeCode) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.dob, dob) || other.dob == dob) &&
            (identical(other.cnicNo, cnicNo) || other.cnicNo == cnicNo) &&
            (identical(other.departmentId, departmentId) ||
                other.departmentId == departmentId) &&
            (identical(other.contactNo, contactNo) ||
                other.contactNo == contactNo) &&
            (identical(other.emergencyPerson, emergencyPerson) ||
                other.emergencyPerson == emergencyPerson) &&
            (identical(other.emergencyPersonContact, emergencyPersonContact) ||
                other.emergencyPersonContact == emergencyPersonContact) &&
            (identical(
                    other.emergencyPersonRelation, emergencyPersonRelation) ||
                other.emergencyPersonRelation == emergencyPersonRelation) &&
            (identical(other.employeeStatus, employeeStatus) ||
                other.employeeStatus == employeeStatus) &&
            (identical(other.employeeSalary, employeeSalary) ||
                other.employeeSalary == employeeSalary) &&
            (identical(other.employeeContractStartDate,
                    employeeContractStartDate) ||
                other.employeeContractStartDate == employeeContractStartDate) &&
            (identical(
                    other.employeeContractEndDate, employeeContractEndDate) ||
                other.employeeContractEndDate == employeeContractEndDate) &&
            (identical(other.employeeCreatedAt, employeeCreatedAt) ||
                other.employeeCreatedAt == employeeCreatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      employeeId,
      employeeCode,
      firstName,
      lastName,
      city,
      address,
      dob,
      cnicNo,
      departmentId,
      contactNo,
      emergencyPerson,
      emergencyPersonContact,
      emergencyPersonRelation,
      employeeStatus,
      employeeSalary,
      employeeContractStartDate,
      employeeContractEndDate,
      employeeCreatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_EmployeeCopyWith<_$_Employee> get copyWith =>
      __$$_EmployeeCopyWithImpl<_$_Employee>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_EmployeeToJson(
      this,
    );
  }
}

abstract class _Employee implements Employee {
  const factory _Employee(
      {required final String employeeId,
      required final String employeeCode,
      required final String firstName,
      required final String lastName,
      required final String city,
      required final String address,
      required final DateTime dob,
      required final String cnicNo,
      required final String departmentId,
      required final String contactNo,
      required final String emergencyPerson,
      required final String emergencyPersonContact,
      required final String emergencyPersonRelation,
      required final String employeeStatus,
      required final String employeeSalary,
      @TimestampConverter()
          required final DateTime employeeContractStartDate,
      @TimestampConverter()
          required final DateTime employeeContractEndDate,
      @TimestampConverter()
          required final DateTime employeeCreatedAt}) = _$_Employee;

  factory _Employee.fromJson(Map<String, dynamic> json) = _$_Employee.fromJson;

  @override
  String get employeeId;
  @override
  String get employeeCode;
  @override
  String get firstName;
  @override
  String get lastName;
  @override
  String get city;
  @override
  String get address;
  @override
  DateTime get dob;
  @override
  String get cnicNo;
  @override
  String get departmentId;
  @override
  String get contactNo;
  @override
  String get emergencyPerson;
  @override
  String get emergencyPersonContact;
  @override
  String get emergencyPersonRelation;
  @override
  String get employeeStatus;
  @override
  String get employeeSalary;
  @override
  @TimestampConverter()
  DateTime get employeeContractStartDate;
  @override
  @TimestampConverter()
  DateTime get employeeContractEndDate;
  @override
  @TimestampConverter()
  DateTime get employeeCreatedAt;
  @override
  @JsonKey(ignore: true)
  _$$_EmployeeCopyWith<_$_Employee> get copyWith =>
      throw _privateConstructorUsedError;
}
