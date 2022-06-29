import 'package:json_annotation/json_annotation.dart';

import 'image_model.dart';

part 'show_model.g.dart';

@JsonSerializable()
class Show {
  int? id;
  String? name;
  Image? image;
  String? summary;

  Show({this.id, this.name, this.image, this.summary});

  factory Show.fromJson(Map<String, dynamic> json) => _$ShowFromJson(json);
  Map<String, dynamic> toJson() => _$ShowToJson(this);
}
