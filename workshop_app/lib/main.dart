import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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
  var rows = <TableRow>[];

  @override
  void initState() {
    super.initState();
    rows = buildTableRows();
    var apiData = Api().fetchShow('simpsons');
    apiData.then((value) {
      if (kDebugMode) {
        print(value);
      }
    });
  }

  void onTapImage() {
    print("onTapImage");
  }

  List<TableRow> buildTableRows() {
    var rows = <TableRow>[];

    for (var i = 0; i < 3; i++) {
      var row = TableRow(children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 0.0, top: 12.0, right: 0.0, bottom: 0.0),
              child: GestureDetector(
                  child: Image.network('https://picsum.photos/250?image=${i}'), onTap: onTapImage),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 0.0, top: 8.0, right: 0.0, bottom: 12.0),
              child: Text("Image ${i}"),
            )
          ],
        )
      ]);
      rows.add(row);
    }

    return rows;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
          child: Table(
            children: rows,
          ),
        ));
  }
}
