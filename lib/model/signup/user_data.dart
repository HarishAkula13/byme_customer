
import 'package:json_annotation/json_annotation.dart';
part 'user_data.g.dart';
@JsonSerializable(fieldRename: FieldRename.snake)
class UserData {
  String? mobileNumber;
  String? userId;
  String? fullName;
  String? token;
  UserData({this.mobileNumber, this.userId, this.fullName,this.token});

  factory UserData.fromJson(Map<String,dynamic> json) => _$UserDataFromJson(json);
  Map<String,dynamic> toJson()=> _$UserDataToJson(this);

}