import 'package:json_annotation/json_annotation.dart';
part 'cart_list.g.dart';
@JsonSerializable(fieldRename: FieldRename.snake)
class CartList{
  dynamic servicePrice;
  List<CartList>? fetchCart;
  String? category;
  CartList(this.fetchCart, this.category, this.subCategory, this.serviceType,
      this.date, this.additionalInstructions, this.descriptionOfWork,this.servicePrice);
  String? subCategory;
  String?  serviceType;
  String?  date;
  String?  additionalInstructions;
  String?  descriptionOfWork;

  factory CartList.fromJson(Map<String,dynamic> json) => _$CartListFromJson(json);

}