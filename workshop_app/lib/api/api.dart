import 'dart:async';
import 'dart:convert';

import 'package:flutter_login/flutter_login.dart';
import 'package:http/http.dart';

import '../model/tvmazesearchresult.dart';

class Api {
  String baseURL = 'https://api.tvmaze.com/search/shows?q=';

  Future<List<TVMazeSearchResult>?> fetchShow(String name) async {
    // await Future.delayed(const Duration(seconds: 2));

    final uri = Uri.parse('$baseURL + $name');
    final response = await get(uri).timeout(const Duration(seconds: 10));
    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body) as List;
      
      List<TVMazeSearchResult> resultList = List.from(jsonBody.map((element) => TVMazeSearchResult.fromJson(element)));

      return resultList;
    } else {
      return null;
    }
  }

  Future<bool> validateUser(LoginData data) async {
    await Future.delayed(const Duration(seconds: 2));

    var user = "user";
    var password = "foobar23";
    // var salt = "9p45nvocwe9urfnioseruzgnx347xn3w4nrx9";
    // var bytes = utf8.encode(salt + password);
    // var hash = sha256.convert(bytes);

    if ((data.name == user) && (data.password == password)) {
      return true;
    } else {
      return false;
    }
  }
}
