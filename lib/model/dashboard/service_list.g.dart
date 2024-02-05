// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServicesList _$ServicesListFromJson(Map<String, dynamic> json) => ServicesList(
      serviceName: json['service_name'] as String?,
      icon: json['icon'] as String?,
      category: (json['category'] as List<dynamic>?)
          ?.map((e) => Category.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ServicesListToJson(ServicesList instance) =>
    <String, dynamic>{
      'service_name': instance.serviceName,
      'icon': instance.icon,
      'category': instance.category,
    };

Category _$CategoryFromJson(Map<String, dynamic> json) => Category(
      categoryName: json['category_name'] as String?,
      subCategory: (json['sub_category'] as List<dynamic>?)
          ?.map((e) => Subcategory.fromJson(e as Map<String, dynamic>))
          .toList(),
      isClick: json['is_click'] as bool?,
    );

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      'category_name': instance.categoryName,
      'is_click': instance.isClick,
      'sub_category': instance.subCategory,
    };

Subcategory _$SubcategoryFromJson(Map<String, dynamic> json) => Subcategory(
      serviceId: json['service_id'] as String?,
      serviceName: json['service_name'] as String?,
      serviceType: json['service_type'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$SubcategoryToJson(Subcategory instance) =>
    <String, dynamic>{
      'service_id': instance.serviceId,
      'service_name': instance.serviceName,
      'service_type': instance.serviceType,
      'status': instance.status,
    };
