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
  var rows = <TableRow>[];
  late Future<String> _title;

  @override
  void initState() {
    super.initState();
    _title = getValue();
    // var apiData = Api().fetchShow('simpsons');
    // apiData.then((value) {
    rows = buildTableRows();
    // });
  }

  void onTapImage() {
    print("onTapImage");
  }

  Future<String> getValue() async {
    await Future.delayed(Duration(seconds: 3));
    return 'Flutter Devs';
  }

  // List<TableRow> buildTableRows(List<Model.TVMazeSearchResult>? shows) {
  List<TableRow> buildTableRows() {
    var rows = <TableRow>[];
    // shows?.forEach((element) {
    //   print(element.show?.name);
    // });

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
        body: FutureBuilder<String>(
          future: _title,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Table(
                  children: rows,
                ),
              );
            }
            return Center(child: const CircularProgressIndicator());
          },
        ));
  }
}
