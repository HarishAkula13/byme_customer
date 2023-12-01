import 'package:json_annotation/json_annotation.dart';
part 'shop_list_deatils.g.dart';
@JsonSerializable(fieldRename: FieldRename.snake)
class ShopListDetails{
  ShopListDetails? shopsListDistance;
  List<ShopListDetails>? shopsList;
  String? shopId;

  ShopListDetails({
      this.shopsListDistance,
      this.shopsList,
      this.shopId,
      this.distance,
      this.shopDetails,
      this.phoneNumber,
      this.shopName,
      this.shopStatus,
      this.shopAddress,
      this.addressId,
      this.cityName,
      this.imageLink,
      this.latitude,
      this.longitude,
      this.shopRating,this.flag});

  dynamic distance;
  ShopListDetails? shopDetails;
  String? phoneNumber;
  String? shopName;
  String? shopStatus;
  String? shopAddress;
  String? addressId;
  String? cityName;
  String? imageLink;
  String? latitude;
  String? longitude;
  String? shopRating;
  bool? flag;

  factory ShopListDetails.fromJson(Map<String,dynamic> json) => _$ShopListDetailsFromJson(json);

}