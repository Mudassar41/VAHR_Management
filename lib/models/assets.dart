import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_trackr/models/time_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'assets.freezed.dart';
part 'assets.g.dart';

@freezed
abstract class Assets with _$Assets {
  const factory Assets(
      {required String assetId,
      required String itemCode,
      required String itemName,
      required String category,
      @Default('') String? itemStatus,
      required String purchasePrice,
      @Default('') String? currentPrice,
      @Default('') String? assignTo,
      @Default('') String? comments,
      @TimestampConverter() required DateTime purchaseDate,
      @TimestampConverter() required DateTime createdAt}) = _Assets;

  factory Assets.fromJson(Map<String, dynamic> json) => _$AssetsFromJson(json);

  factory Assets.empty() => Assets(
      assetId: '',
      itemCode: '',
      itemName: '',
      category: '',
      purchasePrice: '',
      purchaseDate: DateTime(0, 0, 0),
      createdAt: DateTime(0, 0, 0));
}
