import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';

import 'api/api.dart';

void main() {
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
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static String hash = "";

  Future<void> _increment() async {
    MethodChannel methodChannel = const MethodChannel('com.appnoe.flutter-workshop/cryptokit');
    final result = await methodChannel.invokeMethod<int>('increment', {'count': 23});
    print(result);
  }

  Future<void> _getHash() async {
    MethodChannel methodChannel = const MethodChannel('com.appnoe.flutter-workshop/cryptokit');
    final result = await methodChannel.invokeMethod<String>('getHash', {'text': 'foobar'});
    print(result);
  }

  Future<String> fetchShow(String name) async {
    await Future.delayed(const Duration(seconds: 2));

    // https://www.tvmaze.com/api
    final uri = Uri.parse('https://api.tvmaze.com/search/shows?q=$name');
    final response = await get(uri);

    return response.body;
  }

  @override
  void initState() {
    super.initState();
    _increment();
    _getHash();
    var apiData = Api().fetchShow('simpsons');
    apiData.then((value) {
      print(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: FutureBuilder<String>(
        future: fetchShow('scrubs'),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Text(
                snapshot.data!,
              ),
            );
          }
          return const CircularProgressIndicator();
        },
      )),
    );
  }
}
