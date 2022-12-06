// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Expense _$$_ExpenseFromJson(Map<String, dynamic> json) => _$_Expense(
      expenseId: json['expenseId'] as String,
      description: json['description'] as String,
      amount: (json['amount'] as num).toDouble(),
      comments: json['comments'] as String? ?? '',
      expenseType: json['expenseType'] as String,
      paymentTyoe: json['paymentTyoe'] as String,
      date: const TimestampConverter().fromJson(json['date'] as Timestamp),
      createdAt:
          const TimestampConverter().fromJson(json['createdAt'] as Timestamp),
    );

Map<String, dynamic> _$$_ExpenseToJson(_$_Expense instance) =>
    <String, dynamic>{
      'expenseId': instance.expenseId,
      'description': instance.description,
      'amount': instance.amount,
      'comments': instance.comments,
      'expenseType': instance.expenseType,
      'paymentTyoe': instance.paymentTyoe,
      'date': const TimestampConverter().toJson(instance.date),
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
    };
