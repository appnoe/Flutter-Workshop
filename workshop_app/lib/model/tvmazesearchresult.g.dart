// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tvmazesearchresult.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TVMazeSearchResult _$TVMazeSearchResultFromJson(Map<String, dynamic> json) =>
    TVMazeSearchResult(
      score: (json['score'] as num?)?.toDouble(),
      show: json['show'] == null
          ? null
          : Show.fromJson(json['show'] as Map<String, dynamic>),
    );
