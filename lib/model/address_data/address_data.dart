
import 'package:json_annotation/json_annotation.dart';
part 'address_data.g.dart';
@JsonSerializable(fieldRename: FieldRename.snake)
class AddressData {
  String? longitude;
  String? latitude;
  String? address;
  String? addressTitle;
  String? addressId;
  AddressData(
      this.longitude, this.latitude, this.address,this.addressId,this.addressTitle);

  factory AddressData.fromJson(Map<String,dynamic> json) => _$AddressDataFromJson(json);
  Map<String,dynamic> toJson()=> _$AddressDataToJson(this);

}