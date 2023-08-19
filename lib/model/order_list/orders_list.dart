import 'package:json_annotation/json_annotation.dart';
part 'orders_list.g.dart';
@JsonSerializable(fieldRename: FieldRename.snake)
class OrdersList {
  List<OrdersList>? orderList;
  String? orderType;
  String? orderId;
  String? orderDateTime;
  List<ProductInfo>? productInfo;
  String? shopId;
  String? shopName;
  String? shopPhoto;
  String? orderCost;
  String? deliveryCharges;
  String? gst;
  String? subTotal;
  String? orderStatus;
  String? shopCategoryImg;
  String? serviceCategory;
  String? serviceSubcategory;
  String? total;
  String? servcieOwnerName;

  OrdersList(this.orderList, this.orderType, this.orderId, this.orderDateTime, this.productInfo, this.shopId,
      this.shopName, this.shopPhoto, this.orderCost, this.deliveryCharges, this.gst, this.subTotal, this.orderStatus,
      this.shopCategoryImg, this.serviceCategory, this.serviceSubcategory, this.total, this.servcieOwnerName);


  factory OrdersList.fromJson(Map<String,dynamic> json) => _$OrdersListFromJson(json);

}
@JsonSerializable(fieldRename: FieldRename.snake)
class ProductInfo {
  String? productName;
  String? qty;
  String? unit;
  String? amount;
  ProductInfo(this.productName, this.qty, this.unit, this.amount);

  factory ProductInfo.fromJson(Map<String,dynamic> json) => _$ProductInfoFromJson(json);
}

