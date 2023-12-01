// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop_list_deatils.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShopListDetails _$ShopListDetailsFromJson(Map<String, dynamic> json) =>
    ShopListDetails(
      shopsListDistance: json['shops_list_distance'] == null
          ? null
          : ShopListDetails.fromJson(
              json['shops_list_distance'] as Map<String, dynamic>),
      shopsList: (json['shops_list'] as List<dynamic>?)
          ?.map((e) => ShopListDetails.fromJson(e as Map<String, dynamic>))
          .toList(),
      shopId: json['shop_id'] as String?,
      distance: json['distance'],
      shopDetails: json['shop_details'] == null
          ? null
          : ShopListDetails.fromJson(
              json['shop_details'] as Map<String, dynamic>),
      phoneNumber: json['phone_number'] as String?,
      shopName: json['shop_name'] as String?,
      shopStatus: json['shop_status'] as String?,
      shopAddress: json['shop_address'] as String?,
      addressId: json['address_id'] as String?,
      cityName: json['city_name'] as String?,
      imageLink: json['image_link'] as String?,
      latitude: json['latitude'] as String?,
      longitude: json['longitude'] as String?,
      shopRating: json['shop_rating'] as String?,
      flag: json['flag'] as bool?,
    );

Map<String, dynamic> _$ShopListDetailsToJson(ShopListDetails instance) =>
    <String, dynamic>{
      'shops_list_distance': instance.shopsListDistance,
      'shops_list': instance.shopsList,
      'shop_id': instance.shopId,
      'distance': instance.distance,
      'shop_details': instance.shopDetails,
      'phone_number': instance.phoneNumber,
      'shop_name': instance.shopName,
      'shop_status': instance.shopStatus,
      'shop_address': instance.shopAddress,
      'address_id': instance.addressId,
      'city_name': instance.cityName,
      'image_link': instance.imageLink,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'shop_rating': instance.shopRating,
      'flag': instance.flag,
    };
