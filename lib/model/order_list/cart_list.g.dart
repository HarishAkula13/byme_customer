// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartList _$CartListFromJson(Map<String, dynamic> json) => CartList(
      json['service_price'],
      (json['fetch_cart'] as List<dynamic>?)
          ?.map((e) => CartList.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['user_cart'] as List<dynamic>?)
          ?.map((e) => CartList.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['category'] as String?,
      json['sub_category'] as String?,
      json['service_type'] as String?,
      json['date'] as String?,
      json['additional_instructions'] as String?,
      json['description_of_work'] as String?,
      json['product_id'] as String?,
      json['product_name'] as String?,
      json['product_image'] as String?,
      json['unit'] as String?,
      json['qty'] as String?,
      json['amount'],
      (json['base_charges'] as num?)?.toDouble(),
      (json['gst'] as num?)?.toDouble(),
      (json['total'] as num?)?.toDouble(),
      json['service_id'] as String?,
      json['shop_id'] as String?,
      json['menu_id'] as String?,
      (json['total_amount'] as num?)?.toDouble(),
      (json['tax'] as num?)?.toDouble(),
      (json['delivery_charges'] as num?)?.toDouble(),
      (json['overall_discount'] as num?)?.toDouble(),
      (json['final_amount'] as num?)?.toDouble(),
      (json['shop_latitude'] as num?)?.toDouble(),
      (json['shop_longitude'] as num?)?.toDouble(),
      json['order_id'] as String?,
    );

Map<String, dynamic> _$CartListToJson(CartList instance) => <String, dynamic>{
      'service_price': instance.servicePrice,
      'fetch_cart': instance.fetchCart,
      'user_cart': instance.userCart,
      'category': instance.category,
      'sub_category': instance.subCategory,
      'service_type': instance.serviceType,
      'date': instance.date,
      'order_id': instance.orderId,
      'additional_instructions': instance.additionalInstructions,
      'description_of_work': instance.descriptionOfWork,
      'product_id': instance.productId,
      'product_name': instance.productName,
      'product_image': instance.productImage,
      'unit': instance.unit,
      'qty': instance.qty,
      'amount': instance.amount,
      'base_charges': instance.baseCharges,
      'gst': instance.gst,
      'total': instance.total,
      'service_id': instance.serviceId,
      'shop_id': instance.shopId,
      'menu_id': instance.menuId,
      'total_amount': instance.totalAmount,
      'tax': instance.tax,
      'delivery_charges': instance.deliveryCharges,
      'overall_discount': instance.overallDiscount,
      'final_amount': instance.finalAmount,
      'shop_latitude': instance.shopLatitude,
      'shop_longitude': instance.shopLongitude,
    };
