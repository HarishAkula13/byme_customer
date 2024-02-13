import 'package:json_annotation/json_annotation.dart';
part 'shop_menu.g.dart';
@JsonSerializable(fieldRename: FieldRename.snake)
class ShopMenu{
  ShopMenu? shopMenu;
  String? menuId;

  ShopMenu(
      this.shopMenu,
      this.menuId,
      this.shopId,
      this.productInfo,
      this.productId,
      this.productName,
      this.productDescription,
      this.productType,
      this.brandName,
      this.unit,
      this.mrpPrice,
      this.discount,
      this.specifications,
      this.subCategory,
      this.imageLink,
      this.methodOofTransportRequired,
      this.rating,this.cartQty,this.cart,this.flag,this.status,this.key);

  String? shopId;
  List<ShopMenu>? productInfo;
  String? productId;
  String? productName;
  String? productDescription;
  String? productType;
  String? brandName;
  String? unit;
  String? mrpPrice;
  String? discount;
  String? specifications;
  String? subCategory;
  String? imageLink;
  String? methodOofTransportRequired;
  String? rating;
  @JsonKey(defaultValue: 0)
  int? cartQty;
  String? cart;
  bool? flag;
  int? status;
  String? key;

  factory ShopMenu.fromJson(Map<String,dynamic> json) => _$ShopMenuFromJson(json);

}