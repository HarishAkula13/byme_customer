// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_user_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyUserResponse _$VerifyUserResponseFromJson(Map<String, dynamic> json) =>
    VerifyUserResponse(
      otp: json['otp'],
      mobileNumber: json['mobile_number'] as String?,
      userId: json['user_id'] as String?,
      fullName: json['full_name'] as String?,
      key: json['key'] as String?,
      token: json['token'] as String?,
    );

Map<String, dynamic> _$VerifyUserResponseToJson(VerifyUserResponse instance) =>
    <String, dynamic>{
      'otp': instance.otp,
      'mobile_number': instance.mobileNumber,
      'key': instance.key,
      'user_id': instance.userId,
      'full_name': instance.fullName,
      'token': instance.token,
    };
