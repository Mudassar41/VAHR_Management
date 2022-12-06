// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'expense.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Expense _$ExpenseFromJson(Map<String, dynamic> json) {
  return _Expense.fromJson(json);
}

/// @nodoc
mixin _$Expense {
  String get expenseId => throw _privateConstructorUsedError;
  set expenseId(String value) => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  set description(String value) => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  set amount(double value) => throw _privateConstructorUsedError;
  String get comments => throw _privateConstructorUsedError;
  set comments(String value) => throw _privateConstructorUsedError;
  String get expenseType => throw _privateConstructorUsedError;
  set expenseType(String value) => throw _privateConstructorUsedError;
  String get paymentTyoe => throw _privateConstructorUsedError;
  set paymentTyoe(String value) => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get date => throw _privateConstructorUsedError;
  @TimestampConverter()
  set date(DateTime value) => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;
  @TimestampConverter()
  set createdAt(DateTime value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ExpenseCopyWith<Expense> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExpenseCopyWith<$Res> {
  factory $ExpenseCopyWith(Expense value, $Res Function(Expense) then) =
      _$ExpenseCopyWithImpl<$Res, Expense>;
  @useResult
  $Res call(
      {String expenseId,
      String description,
      double amount,
      String comments,
      String expenseType,
      String paymentTyoe,
      @TimestampConverter() DateTime date,
      @TimestampConverter() DateTime createdAt});
}

/// @nodoc
class _$ExpenseCopyWithImpl<$Res, $Val extends Expense>
    implements $ExpenseCopyWith<$Res> {
  _$ExpenseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? expenseId = null,
    Object? description = null,
    Object? amount = null,
    Object? comments = null,
    Object? expenseType = null,
    Object? paymentTyoe = null,
    Object? date = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      expenseId: null == expenseId
          ? _value.expenseId
          : expenseId // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      comments: null == comments
          ? _value.comments
          : comments // ignore: cast_nullable_to_non_nullable
              as String,
      expenseType: null == expenseType
          ? _value.expenseType
          : expenseType // ignore: cast_nullable_to_non_nullable
              as String,
      paymentTyoe: null == paymentTyoe
          ? _value.paymentTyoe
          : paymentTyoe // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ExpenseCopyWith<$Res> implements $ExpenseCopyWith<$Res> {
  factory _$$_ExpenseCopyWith(
          _$_Expense value, $Res Function(_$_Expense) then) =
      __$$_ExpenseCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String expenseId,
      String description,
      double amount,
      String comments,
      String expenseType,
      String paymentTyoe,
      @TimestampConverter() DateTime date,
      @TimestampConverter() DateTime createdAt});
}

/// @nodoc
class __$$_ExpenseCopyWithImpl<$Res>
    extends _$ExpenseCopyWithImpl<$Res, _$_Expense>
    implements _$$_ExpenseCopyWith<$Res> {
  __$$_ExpenseCopyWithImpl(_$_Expense _value, $Res Function(_$_Expense) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? expenseId = null,
    Object? description = null,
    Object? amount = null,
    Object? comments = null,
    Object? expenseType = null,
    Object? paymentTyoe = null,
    Object? date = null,
    Object? createdAt = null,
  }) {
    return _then(_$_Expense(
      expenseId: null == expenseId
          ? _value.expenseId
          : expenseId // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      comments: null == comments
          ? _value.comments
          : comments // ignore: cast_nullable_to_non_nullable
              as String,
      expenseType: null == expenseType
          ? _value.expenseType
          : expenseType // ignore: cast_nullable_to_non_nullable
              as String,
      paymentTyoe: null == paymentTyoe
          ? _value.paymentTyoe
          : paymentTyoe // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Expense extends _Expense {
  _$_Expense(
      {required this.expenseId,
      required this.description,
      required this.amount,
      this.comments = '',
      required this.expenseType,
      required this.paymentTyoe,
      @TimestampConverter() required this.date,
      @TimestampConverter() required this.createdAt})
      : super._();

  factory _$_Expense.fromJson(Map<String, dynamic> json) =>
      _$$_ExpenseFromJson(json);

  @override
  String expenseId;
  @override
  String description;
  @override
  double amount;
  @override
  @JsonKey()
  String comments;
  @override
  String expenseType;
  @override
  String paymentTyoe;
  @override
  @TimestampConverter()
  DateTime date;
  @override
  @TimestampConverter()
  DateTime createdAt;

  @override
  String toString() {
    return 'Expense(expenseId: $expenseId, description: $description, amount: $amount, comments: $comments, expenseType: $expenseType, paymentTyoe: $paymentTyoe, date: $date, createdAt: $createdAt)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ExpenseCopyWith<_$_Expense> get copyWith =>
      __$$_ExpenseCopyWithImpl<_$_Expense>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ExpenseToJson(
      this,
    );
  }
}

abstract class _Expense extends Expense {
  factory _Expense(
      {required String expenseId,
      required String description,
      required double amount,
      String comments,
      required String expenseType,
      required String paymentTyoe,
      @TimestampConverter() required DateTime date,
      @TimestampConverter() required DateTime createdAt}) = _$_Expense;
  _Expense._() : super._();

  factory _Expense.fromJson(Map<String, dynamic> json) = _$_Expense.fromJson;

  @override
  String get expenseId;
  set expenseId(String value);
  @override
  String get description;
  set description(String value);
  @override
  double get amount;
  set amount(double value);
  @override
  String get comments;
  set comments(String value);
  @override
  String get expenseType;
  set expenseType(String value);
  @override
  String get paymentTyoe;
  set paymentTyoe(String value);
  @override
  @TimestampConverter()
  DateTime get date;
  @TimestampConverter()
  set date(DateTime value);
  @override
  @TimestampConverter()
  DateTime get createdAt;
  @TimestampConverter()
  set createdAt(DateTime value);
  @override
  @JsonKey(ignore: true)
  _$$_ExpenseCopyWith<_$_Expense> get copyWith =>
      throw _privateConstructorUsedError;
}
