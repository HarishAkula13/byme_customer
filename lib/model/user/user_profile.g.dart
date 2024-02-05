// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfile _$UserProfileFromJson(Map<String, dynamic> json) => UserProfile(
      json['age'] as int?,
      json['phone_number'] as String?,
      json['user_id'] as String?,
      json['full_name'] as String?,
      json['email_id'] as String?,
      json['gender'] as String?,
      json['recent_payment_method'] as String?,
      json['address_id'] as String?,
      json['address_title'] as String?,
      json['saved_addresses'],
    );

Map<String, dynamic> _$UserProfileToJson(UserProfile instance) =>
    <String, dynamic>{
      'age': instance.age,
      'phone_number': instance.phoneNumber,
      'user_id': instance.userId,
      'full_name': instance.fullName,
      'email_id': instance.emailId,
      'gender': instance.gender,
      'recent_payment_method': instance.recentPaymentMethod,
      'address_title': instance.addressTitle,
      'address_id': instance.addressId,
      'saved_addresses': instance.savedAddresses,
    };
