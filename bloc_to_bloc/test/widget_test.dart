// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:bloc_to_bloc/main.dart';
import 'package:mocktail/mocktail.dart';

class MockFooBar extends Mock implements FooBar {}

void main() {
  late MockFooBar _mockFooBar;

  setUp(() {
    _mockFooBar = MockFooBar();
    when(() => _mockFooBar.doSomething()).thenReturn('teststring');
  });

  group('mytestgroup', () {
    test('testfoo', () {
      when(() => _mockFooBar.doSomething()).thenReturn('teststring2');
    });
  });

  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());
    
    find.byKey(MyHomePage.centerKey);
    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byKey(MyHomePage.centerKey));
    await tester.pump();
    await tester.pumpAndSettle();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
