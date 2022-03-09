import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'api/api.dart';
import 'crypto/cryptokit.dart';

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
  static CryptoKit cryptoKit = CryptoKit();

  Future<void> _increment() async {
    MethodChannel methodChannel = const MethodChannel('com.appnoe.flutter-workshop/cryptokit');
    final result = await methodChannel.invokeMethod<int>('increment', {'count': 23});
    print(result);
  }

  @override
  void initState() {
    super.initState();
    _increment();
    cryptoKit.getHash("foobar");
    var apiData = Api().fetchShow('simpsons');
    apiData.then((value) {
      if (kDebugMode) {
        print(value);
      }
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
        future: cryptoKit.getHash('foobar'),
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
