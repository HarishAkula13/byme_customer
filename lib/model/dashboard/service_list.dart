import 'package:json_annotation/json_annotation.dart';
part 'service_list.g.dart';
@JsonSerializable(fieldRename: FieldRename.snake)
class ServicesList {
  String? serviceName;
  String? icon;
  List<Category>? category;



  ServicesList({this.serviceName, this.icon, this.category});
  factory ServicesList.fromJson(Map<String,dynamic> json) => _$ServicesListFromJson(json);

}
@JsonSerializable(fieldRename: FieldRename.snake)
class Category {
  String? categoryName;
  bool? isClick;
  List<Subcategory>? subCategory;
  Category({this.categoryName, this.subCategory,this.isClick});
  factory Category.fromJson(Map<String,dynamic> json) => _$CategoryFromJson(json);
}
@JsonSerializable(fieldRename: FieldRename.snake)
class Subcategory {
  String? serviceId;
  String? serviceName;
  String? serviceType;
  String? status;
  Subcategory({this.serviceId, this.serviceName, this.serviceType, this.status});
  factory Subcategory.fromJson(Map<String,dynamic> json) => _$SubcategoryFromJson(json);

}