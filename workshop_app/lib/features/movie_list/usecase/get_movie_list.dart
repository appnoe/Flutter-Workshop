import 'dart:convert';

import '../../../common/api/api.dart';
import '../../../model/tvmazesearchresult.dart';

class GetMovieList {
  final Api api;

  GetMovieList(this.api);

  Future<List<TVMazeSearchResult>?> fetchData(String name) async {
    final body = await api.fetchShow(name);

    final jsonBody = json.decode(body) as List;

    List<TVMazeSearchResult> resultList = List.from(
        jsonBody.map((element) => TVMazeSearchResult.fromJson(element)));

    return resultList;
  }
}
