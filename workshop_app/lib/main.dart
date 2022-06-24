import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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
      home: const MyHomePage(title: 'Die App zum Workshop'),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
          child: Table(
            children: [
              TableRow(children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 0.0, top: 12.0, right: 0.0, bottom: 0.0),
                      child: Image.network('https://picsum.photos/250?image=1'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 0.0, top: 8.0, right: 0.0, bottom: 12.0),
                      child: Text("Image 1"),
                    )
                  ],
                )
              ]),
              TableRow(children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 0.0, top: 12.0, right: 0.0, bottom: 0.0),
                      child: Image.network('https://picsum.photos/250?image=2'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 0.0, top: 8.0, right: 0.0, bottom: 12.0),
                      child: Text("Image 2"),
                    )
                  ],
                )
              ]),
              TableRow(children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 0.0, top: 12.0, right: 0.0, bottom: 0.0),
                      child: Image.network('https://picsum.photos/250?image=3'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 0.0, top: 8.0, right: 0.0, bottom: 12.0),
                      child: Text("Image 3"),
                    )
                  ],
                )
              ])
            ],
          ),
        ));
  }
}
