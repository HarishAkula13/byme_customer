import 'package:json_annotation/json_annotation.dart';
part 'cart_list.g.dart';
@JsonSerializable(fieldRename: FieldRename.snake)
class CartList{
  dynamic servicePrice;
  List<CartList>? fetchCart;
  List<CartList>? userCart;
  String? category;
  String? subCategory;
  String?  serviceType;
  String?  date;
  String? orderId;

  CartList(
      this.servicePrice,
      this.fetchCart,
      this.userCart,
      this.category,
      this.subCategory,
      this.serviceType,
      this.date,
      this.additionalInstructions,
      this.descriptionOfWork,
      this.productId,
      this.productName,
      this.productImage,
      this.unit,
      this.qty,
      this.amount,
      this.baseCharges,
      this.gst,
      this.total,
      this.serviceId,
      this.shopId,
      this.menuId,
      this.totalAmount,
      this.tax,
      this.deliveryCharges,
      this.overallDiscount,
      this.finalAmount,this.shopLatitude,this.shopLongitude,this.orderId);

  String?  additionalInstructions;
  String?  descriptionOfWork;
  String? productId;
  String? productName;
  String? productImage;
  String? unit;
  String? qty;
  dynamic amount;
  double? baseCharges;
  double? gst;
  double? total;
  String? serviceId;
  String? shopId;
  String? menuId;
  double? totalAmount;
  double? tax;
  double? deliveryCharges;
  double? overallDiscount;
  double? finalAmount;
  double? shopLatitude;
  double? shopLongitude;




  factory CartList.fromJson(Map<String,dynamic> json) => _$CartListFromJson(json);

  Map<String,dynamic> toJson()=> _$CartListToJson(this);
}