import 'package:byme_app/model/shop/shop_list_deatils.dart';
import 'package:json_annotation/json_annotation.dart';
part 'shop_list.g.dart';
@JsonSerializable()
class ShopList {
  ShopList? shops_list;
  List<ShopListDetails>? ME;

  ShopList(this.shops_list, this.ME, this.PH, this.LQ, this.FV, this.MD,
      this.KG, this.HW, this.LT, this.FB);

  List<dynamic>? PH;
  List<dynamic>? LQ;
  List<dynamic>? FV;
  List<dynamic>? MD;
  List<dynamic>? KG;
  List<dynamic>? HW;
  List<dynamic>? LT;
  List<dynamic>? FB;

  factory ShopList.fromJson(Map<String,dynamic> json) => _$ShopListFromJson(json);


}