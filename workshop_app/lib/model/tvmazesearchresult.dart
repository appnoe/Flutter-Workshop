import 'package:json_annotation/json_annotation.dart';

import 'show_model.dart';

part 'tvmazesearchresult.g.dart';

@JsonSerializable(createToJson: false)
class TVMazeSearchResult {
  double? score;
  Show? show;

  TVMazeSearchResult({this.score, this.show});

  factory TVMazeSearchResult.fromJson(Map<String, dynamic> json) => _$TVMazeSearchResultFromJson(json);

}
