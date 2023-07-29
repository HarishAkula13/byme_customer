
import 'package:json_annotation/json_annotation.dart';
part 'verify_user_response.g.dart';
@JsonSerializable(fieldRename: FieldRename.snake)
class VerifyUserResponse {
   dynamic otp;
   String? mobileNumber;
   String? key;
    String? userId;
   String? fullName;
   String? token;
   VerifyUserResponse({this.otp, this.mobileNumber, this.userId,
     this.fullName,this.key,this.token});

  factory VerifyUserResponse.fromJson(Map<String,dynamic> json) => _$VerifyUserResponseFromJson(json);
   Map<String,dynamic> toJson()=> _$VerifyUserResponseToJson(this);

}