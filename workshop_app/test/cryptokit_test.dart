import 'package:flutter/cupertino.dart';
import 'package:test/test.dart';
import 'package:workshop_app/models/cryptokit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  test('Test hashing of string with CryptoKit', () async {
    final CryptoKit cryptoKit = CryptoKit();
    const String clearText = 'foobar';
    final result = await cryptoKit.getHash('foobar');
    print(result);
    expect(clearText, result);
  });
}
