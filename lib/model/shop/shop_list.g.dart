// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShopList _$ShopListFromJson(Map<String, dynamic> json) => ShopList(
      json['shops_list'] == null
          ? null
          : ShopList.fromJson(json['shops_list'] as Map<String, dynamic>),
      (json['ME'] as List<dynamic>?)
          ?.map((e) => ShopListDetails.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['PH'] as List<dynamic>?,
      json['LQ'] as List<dynamic>?,
      json['FV'] as List<dynamic>?,
      json['MD'] as List<dynamic>?,
      json['KG'] as List<dynamic>?,
      json['HW'] as List<dynamic>?,
      json['LT'] as List<dynamic>?,
      json['FB'] as List<dynamic>?,
    );

Map<String, dynamic> _$ShopListToJson(ShopList instance) => <String, dynamic>{
      'shops_list': instance.shops_list,
      'ME': instance.ME,
      'PH': instance.PH,
      'LQ': instance.LQ,
      'FV': instance.FV,
      'MD': instance.MD,
      'KG': instance.KG,
      'HW': instance.HW,
      'LT': instance.LT,
      'FB': instance.FB,
    };
