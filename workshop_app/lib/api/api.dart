import 'dart:async';

import 'package:http/http.dart';
import 'package:workshop_app/models/tvmazeresult.dart';

class Api {
  String baseURL = 'https://api.tvmaze.com/search/shows?q=';

  Future<List<TVMazeResult>?> fetchShow(String name) async {
    await Future.delayed(const Duration(seconds: 2));

    final uri = Uri.parse('$baseURL + $name');
    final response = await get(uri).timeout(Duration(seconds: 10));
    if (response.statusCode == 200) {
      List<TVMazeResult> resultList = TVMazeResult.fromJsonArray(response.body);
      return resultList;
    } else {
      return null;
    }
  }
}
