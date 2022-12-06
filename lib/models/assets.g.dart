// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assets.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Assets _$$_AssetsFromJson(Map<String, dynamic> json) => _$_Assets(
      assetId: json['assetId'] as String,
      itemCode: json['itemCode'] as String,
      itemName: json['itemName'] as String,
      category: json['category'] as String,
      itemStatus: json['itemStatus'] as String? ?? '',
      purchasePrice: json['purchasePrice'] as String,
      currentPrice: json['currentPrice'] as String? ?? '',
      assignTo: json['assignTo'] as String? ?? '',
      comments: json['comments'] as String? ?? '',
      purchaseDate: const TimestampConverter()
          .fromJson(json['purchaseDate'] as Timestamp),
      createdAt:
          const TimestampConverter().fromJson(json['createdAt'] as Timestamp),
    );

Map<String, dynamic> _$$_AssetsToJson(_$_Assets instance) => <String, dynamic>{
      'assetId': instance.assetId,
      'itemCode': instance.itemCode,
      'itemName': instance.itemName,
      'category': instance.category,
      'itemStatus': instance.itemStatus,
      'purchasePrice': instance.purchasePrice,
      'currentPrice': instance.currentPrice,
      'assignTo': instance.assignTo,
      'comments': instance.comments,
      'purchaseDate': const TimestampConverter().toJson(instance.purchaseDate),
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
    };
