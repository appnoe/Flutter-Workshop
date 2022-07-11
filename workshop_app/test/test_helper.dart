import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'mocks.dart';

Future<NavigatorObserver> buildTestWidget(
  WidgetTester tester,
  Widget widgetToTest, {
  bool usePumpAndSettle = true,
}) async {
  final navigatorObserver = MockNavigatorObserver();
  await tester.pumpWidget(
    MaterialApp(home: widgetToTest, navigatorObservers: [navigatorObserver]),
  );

  if (usePumpAndSettle) {
    await tester.pumpAndSettle();
  } else {
    await tester.pump();
  }

  return navigatorObserver;
}

// get the first widget matched by the given type
// used to access the properties or methods of the widget
extension GetWidgetByType on WidgetTester {
  T getWidgetByType<T extends Widget>() {
    try {
      final foundElement = find.byType(T);
      return firstWidget<T>(foundElement);
    } on StateError catch (e) {
      if (e.message == 'No element') {
        throw AssertionError('could not find a widget with specific type=$T');
      }
      rethrow;
    }
  }
}

// does the same as GetWidgetByType but returns a list of all widgets
// matched by the given type
extension GetWidgetsByType on WidgetTester {
  List<T> getWidgetsByType<T extends Widget>() {
    try {
      final foundElement = find.byType(T);
      return widgetList<T>(foundElement).toList();
    } on StateError catch (e) {
      if (e.message == 'No element') {
        throw AssertionError('could not find a widget with specific type=$T');
      }
      rethrow;
    }
  }
}

// does the same as GetWidgetByType, but this time matched against the given
// key, so generic type and key are both mandatory
extension GetWidgetByKey on WidgetTester {
  T getWidgetByKey<T extends Widget>(Key key) {
    try {
      final foundElement = find.byKey(key);
      return firstWidget<T>(foundElement);
    } on StateError catch (e) {
      if (e.message == 'No element') {
        throw AssertionError('could not find a widget with provided key $key');
      }
      rethrow;
    }
  }
}
