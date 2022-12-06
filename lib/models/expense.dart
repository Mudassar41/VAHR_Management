import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_trackr/models/time_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'expense.freezed.dart';
part 'expense.g.dart';

@unfreezed
class Expense with _$Expense {
  Expense._();
  factory Expense(
      {required String expenseId,
      required String description,
      required double amount,
      @Default('') String comments,
      required String expenseType,
      required String paymentTyoe,
      @TimestampConverter() required DateTime date,
      @TimestampConverter() required DateTime createdAt}) = _Expense;

  factory Expense.fromJson(Map<String, dynamic> json) =>
      _$ExpenseFromJson(json);

  factory Expense.empty() => Expense(
      expenseId: '',
      description: '',
      amount: 0.0,
      expenseType: '',
      paymentTyoe: '',
      date: DateTime(0, 0, 0),
      createdAt: DateTime(0, 0, 0));
}
