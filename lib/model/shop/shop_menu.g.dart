// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop_menu.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShopMenu _$ShopMenuFromJson(Map<String, dynamic> json) => ShopMenu(
      json['shop_menu'] == null
          ? null
          : ShopMenu.fromJson(json['shop_menu'] as Map<String, dynamic>),
      json['menu_id'] as String?,
      json['shop_id'] as String?,
      (json['product_info'] as List<dynamic>?)
          ?.map((e) => ShopMenu.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['product_id'] as String?,
      json['product_name'] as String?,
      json['product_description'] as String?,
      json['product_type'] as String?,
      json['brand_name'] as String?,
      json['unit'] as String?,
      json['mrp_price'] as String?,
      json['discount'] as String?,
      json['specifications'] as String?,
      json['sub_category'] as String?,
      json['image_link'] as String?,
      json['method_oof_transport_required'] as String?,
      json['rating'] as String?,
      json['cart_qty'] as int? ?? 0,
      json['cart'] as String?,
      json['flag'] as bool?,
    );

Map<String, dynamic> _$ShopMenuToJson(ShopMenu instance) => <String, dynamic>{
      'shop_menu': instance.shopMenu,
      'menu_id': instance.menuId,
      'shop_id': instance.shopId,
      'product_info': instance.productInfo,
      'product_id': instance.productId,
      'product_name': instance.productName,
      'product_description': instance.productDescription,
      'product_type': instance.productType,
      'brand_name': instance.brandName,
      'unit': instance.unit,
      'mrp_price': instance.mrpPrice,
      'discount': instance.discount,
      'specifications': instance.specifications,
      'sub_category': instance.subCategory,
      'image_link': instance.imageLink,
      'method_oof_transport_required': instance.methodOofTransportRequired,
      'rating': instance.rating,
      'cart_qty': instance.cartQty,
      'cart': instance.cart,
      'flag': instance.flag,
    };
