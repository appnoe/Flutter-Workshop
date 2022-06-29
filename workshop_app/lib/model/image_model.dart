import 'package:json_annotation/json_annotation.dart';

part 'image_model.g.dart'; 

@JsonSerializable()
class Image {
  String? medium;
  String? original;

  Image({this.medium, this.original});

  factory Image.fromJson(Map<String, dynamic> json) => _$ImageFromJson(json);
  Map<String, dynamic> toJson() => _$ImageToJson(this);
}