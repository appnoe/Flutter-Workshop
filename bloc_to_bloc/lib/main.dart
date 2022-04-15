import 'package:bloc_to_bloc/dependency.dart';
import 'package:flutter/material.dart';

void main() async {
  await initializeIoC();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  static const centerKey = Key('MyHomePage.Center');

  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: const Center(
        key: MyHomePage.centerKey,
        child: Text('Dummy Text'),
      ),
    );
  }
}

class FooBar {
  String doSomething() {
    return 'mystring';
  }
}
