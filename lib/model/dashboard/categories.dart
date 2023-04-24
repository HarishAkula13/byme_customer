import 'package:json_annotation/json_annotation.dart';
part 'categories.g.dart';
@JsonSerializable(fieldRename: FieldRename.snake)
class Categories{
   bool? isClick;
   String? title;
  Categories({this.isClick,this.title});
  factory Categories.fromJson(Map<String,dynamic> json) => _$CategoriesFromJson(json);
}