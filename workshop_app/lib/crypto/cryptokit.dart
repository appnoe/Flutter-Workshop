import 'package:flutter/services.dart';

class CryptoKit {
  Future<String>? getHash(String text) async {
    MethodChannel methodChannel = const MethodChannel('com.appnoe.flutter-workshop/cryptokit');
    final result = await methodChannel.invokeMethod<String>('getHash', {'text': text});
    if (result != null) {
      print(result);
      return result;
    } else {
      return 'No hash available';
    }
  }
}
