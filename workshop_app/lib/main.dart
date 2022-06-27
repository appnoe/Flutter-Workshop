import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:workshop_app/view/show_details.dart';

import 'api/api.dart';
import 'model/tvmazesearchresult.dart' as _model;

/* TODO
- Futurebuilder an API-Call koppeln
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
  var apiData = <_model.TVMazeSearchResult>[];
  String searchString = 'simpsons';

  @override
  void initState() {
    super.initState();
    _title = _getValue();
    _loadData(searchString);
  }

  void _loadData(String searchText) {
    var result = Api().fetchShow(searchText);
    result.then((value) {
      setState(() {
        apiData = value!;
        rows = buildTableRows(value);
      });
    });
  }

  _model.Show? _showWithID(int id) {
    for (var i = 0; i < apiData.length; i++) {
      if (apiData[i].show?.id == id) {
        return apiData[i].show;
      }
    }
    return null;
  }

  void _onTapImage(int id) {
    if (kDebugMode) {
      print("onTapImage: $id");
    }
    var show = _showWithID(id);
    if (show != null) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return ShowDetails(show: show);
      }));
    }
  }

  Future<String> _getValue() async {
    await Future.delayed(const Duration(seconds: 3));
    return 'placeholder';
  }

  List<TableRow> buildTableRows(List<_model.TVMazeSearchResult>? shows) {
    var rows = <TableRow>[];
    shows?.forEach((element) {
      var row = TableRow(children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 0.0, top: 12.0, right: 0.0, bottom: 0.0),
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
              padding: const EdgeInsets.only(
                  left: 0.0, top: 8.0, right: 0.0, bottom: 12.0),
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
            title: const Text('Suche nach Filmen'),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  searchString = value;
                });
              },
              decoration: const InputDecoration(hintText: "Suchbegriff"),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Abbrechen'),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              TextButton(
                child: const Text('Suchen'),
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
            child: const Icon(
              Icons.search,
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
            return const Center(child: CircularProgressIndicator());
          },
        ));
  }
}
