import 'package:flutter/cupertino.dart';
import 'package:test/test.dart';
import 'package:workshop_app/crypto/hash_factory.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  test('Test hashing of string ', () async {
    final HashFactory hashFactory = HashFactory();
    const String clearText = 'foobar';
    final result = hashFactory.generateHash(clearText);
    print(result);
    expect('8843d7f92416211de9ebb963ff4ce28125932878', result);
  });
}
