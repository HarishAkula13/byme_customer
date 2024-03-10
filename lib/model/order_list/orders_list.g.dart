// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orders_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrdersList _$OrdersListFromJson(Map<String, dynamic> json) => OrdersList(
      json['order_list'],
      json['order_type'] as String?,
      json['order_id'] as String?,
      json['order_date_time'] as String?,
      (json['product_info'] as List<dynamic>?)
          ?.map((e) => ProductInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['shop_id'] as String?,
      json['shop_name'] as String?,
      json['shop_photo'] as String?,
      (json['order_cost'] as num?)?.toDouble(),
      (json['delivery_charges'] as num?)?.toDouble(),
      (json['gst'] as num?)?.toDouble(),
      (json['sub_total'] as num?)?.toDouble(),
      json['order_status'] as String?,
      json['shop_category_img'] as String?,
      json['service_category'] as String?,
      json['service_subcategory'] as String?,
      (json['total'] as num?)?.toDouble(),
      json['servcie_owner_name'] as String?,
    );

Map<String, dynamic> _$OrdersListToJson(OrdersList instance) =>
    <String, dynamic>{
      'order_list': instance.orderList,
      'order_type': instance.orderType,
      'order_id': instance.orderId,
      'order_date_time': instance.orderDateTime,
      'product_info': instance.productInfo,
      'shop_id': instance.shopId,
      'shop_name': instance.shopName,
      'shop_photo': instance.shopPhoto,
      'order_cost': instance.orderCost,
      'delivery_charges': instance.deliveryCharges,
      'gst': instance.gst,
      'sub_total': instance.subTotal,
      'order_status': instance.orderStatus,
      'shop_category_img': instance.shopCategoryImg,
      'service_category': instance.serviceCategory,
      'service_subcategory': instance.serviceSubcategory,
      'total': instance.total,
      'servcie_owner_name': instance.servcieOwnerName,
    };

ProductInfo _$ProductInfoFromJson(Map<String, dynamic> json) => ProductInfo(
      json['product_name'] as String?,
      json['qty'] as String?,
      json['unit'] as String?,
      (json['amount'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ProductInfoToJson(ProductInfo instance) =>
    <String, dynamic>{
      'product_name': instance.productName,
      'qty': instance.qty,
      'unit': instance.unit,
      'amount': instance.amount,
    };
