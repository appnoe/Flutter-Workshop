import 'dart:convert';

import 'package:crypto/crypto.dart';

class HashFactory {
  String generateHash(String text) {
    var bytes = utf8.encode(text);
    var digest = sha1.convert(bytes);
    return digest.toString();
  }
}
