
import 'package:json_annotation/json_annotation.dart';
part 'user_profile.g.dart';
@JsonSerializable(fieldRename: FieldRename.snake)
class UserProfile {
  int? age;
  String? phoneNumber;
  String? userId;
  String? fullName;
  String? emailId;
  String? gender;
  String? recentPaymentMethod;
  String? addressTitle;
  String? addressId;
  UserProfile(this.age, this.phoneNumber, this.userId, this.fullName,
      this.emailId, this.gender, this.recentPaymentMethod,this.addressId,this.addressTitle);




  factory UserProfile.fromJson(Map<String,dynamic> json) => _$UserProfileFromJson(json);
  Map<String,dynamic> toJson()=> _$UserProfileToJson(this);

}