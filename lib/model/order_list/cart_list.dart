import 'package:json_annotation/json_annotation.dart';
part 'cart_list.g.dart';
@JsonSerializable(fieldRename: FieldRename.snake)
class CartList{
  dynamic servicePrice;
  List<CartList>? fetchCart;
  List<CartList>? userCart;
  String? category;

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
      this.serviceId);

  String? subCategory;
  String?  serviceType;
  String?  date;
  String?  additionalInstructions;
  String?  descriptionOfWork;
  String? productId;
  String? productName;
  String? productImage;
  String? unit;
  String? qty;
  String? amount;
  double? baseCharges;
  double? gst;
  double? total;
  String? serviceId;


  factory CartList.fromJson(Map<String,dynamic> json) => _$CartListFromJson(json);

}