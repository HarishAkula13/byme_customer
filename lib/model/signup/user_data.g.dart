// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserData _$UserDataFromJson(Map<String, dynamic> json) => UserData(
      mobileNumber: json['mobile_number'] as String?,
      userId: json['user_id'] as String?,
      fullName: json['full_name'] as String?,
      token: json['token'] as String?,
    );

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic>{
      'mobile_number': instance.mobileNumber,
      'user_id': instance.userId,
      'full_name': instance.fullName,
      'token': instance.token,
    };
