import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transparent_image/transparent_image.dart';

import '../model/show_model.dart';
import './show_details.dart';
import '../api/api.dart';
import '../crypto/cryptokit.dart';
import '../model/tvmazesearchresult.dart' as _model;
import 'bloc/movie_list_bloc.dart';

class ShowList extends StatefulWidget {
  const ShowList({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<ShowList> createState() => _ShowListState();
}

class _ShowListState extends State<ShowList> {
  static String hash = "";
  static CryptoKit cryptoKit = CryptoKit();
  var apiData = <_model.TVMazeSearchResult>[];
  String searchString = 'simpsons';

  @override
  void initState() {
    super.initState();
    cryptoKit.getHash("foobar");
    _loadData(searchString);
  }

  Future<bool> _loadData(String searchText) async {
    var result = await Api().fetchShow(searchText);
    setState(() {
      apiData = result!;
    });
    return true;
  }

  Show? _showWithID(int id) {
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

  List<TableRow> _buildTableRows(List<_model.TVMazeSearchResult>? shows) {
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
        body: BlocProvider(
          create: (context) => MovieListBloc()..add(MovieListRequested()),
          child: Builder(builder: (context) {
            BlocListener<MovieListBloc, MovieListState>(listener: (context, state) {

            },);


            return BlocBuilder<MovieListBloc, MovieListState>(builder: (context, state) {
              if (state is MovieListRequested) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is MovieListLoadingSucceded) {
                return SingleChildScrollView(
                    child: Table(
                      children: _buildTableRows(apiData),
                    ),
                  );
              }
              return Container();
            });
          }),
        ));
  }
}

// LoadingState
// Daten geladen
// Error State
// no found state

class MyFooContainerWidget extends StatelessWidget {
  const MyFooContainerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MovieListBloc(),
      child: const MyFooWidget(),
    );
  }
}

class MyFooWidget extends StatefulWidget {
  const MyFooWidget({Key? key}) : super(key: key);

  @override
  State<MyFooWidget> createState() => _MyFooWidgetState();
}

class _MyFooWidgetState extends State<MyFooWidget> {

  @override
  void initState() {
    context.read<MovieListBloc>().add(MovieListRequested());
    final myList = context.watch<MovieListBloc>().state;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
