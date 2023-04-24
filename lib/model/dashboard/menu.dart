import 'package:json_annotation/json_annotation.dart';
part 'menu.g.dart';
@JsonSerializable(fieldRename: FieldRename.snake)
class Menu{
  final String? icon;
  final String? title;
  Menu({this.icon,this.title});
  factory Menu.fromJson(Map<String,dynamic> json) => _$MenuFromJson(json);
}