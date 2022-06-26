import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import 'api/api.dart';
import 'model/tvmazesearchresult.dart' as Model;

/* TODO
- Futurebuilder an API-Call koppeln
- Show-Details auf Detailseite zeigen
- Platform Channels
- GridView
- Login
*/

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
  String searchString = 'simpsons';

  @override
  void initState() {
    super.initState();
    _title = getValue();
    _loadData(searchString);
  }

  void _loadData(String searchText) {
    var apiData = Api().fetchShow(searchText);
    apiData.then((value) {
      this.setState(() {
        rows = buildTableRows(value);
      });
    });
  }

  void _onTapImage(int id) {
    print("onTapImage: ${id}");
  }

  Future<String> getValue() async {
    await Future.delayed(Duration(seconds: 3));
    return 'placeholder';
  }

  List<TableRow> buildTableRows(List<Model.TVMazeSearchResult>? shows) {
    var rows = <TableRow>[];
    shows?.forEach((element) {
      var row = TableRow(children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 0.0, top: 12.0, right: 0.0, bottom: 0.0),
              child: GestureDetector(
                  child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: element.show!.image!.medium!,
                  ),
                  onTap: () {
                    _onTapImage(element.show!.id!);
                  }),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 0.0, top: 8.0, right: 0.0, bottom: 12.0),
              child: Text(element.show!.name!),
            )
          ],
        )
      ]);
      rows.add(row);
    });

    return rows;
  }

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Suche nach Filmen'),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  searchString = value;
                });
              },
              decoration: InputDecoration(hintText: "Suchbegriff"),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Abbrechen'),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              TextButton(
                child: Text('Suchen'),
                onPressed: () {
                  setState(() {
                    _loadData(searchString);
                    Navigator.pop(context);
                  });
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          leading: GestureDetector(
            onTap: () {
              _displayTextInputDialog(context);
            },
            child: Icon(
              Icons.search, // add custom icons also
            ),
          ),
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
