import 'package:json_annotation/json_annotation.dart';
part 'menu.g.dart';
@JsonSerializable(fieldRename: FieldRename.snake)
class Menu{
  final String? icon;
  final String? title;
  final String? tag;

  Menu({this.icon,this.title,this.tag});
  factory Menu.fromJson(Map<String,dynamic> json) => _$MenuFromJson(json);
}