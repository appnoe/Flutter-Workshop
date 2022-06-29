import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:workshop_app/common/styles.dart';
import 'package:workshop_app/features/movie_list/usecase/get_movie_list.dart';

import '../../../../common/api/api.dart';
import '../../../movie_details/presentation/page/show_details.dart';
import '../../../../crypto/cryptokit.dart';
import '../../../../model/tvmazesearchresult.dart' as _model;
import '../bloc/movie_list_bloc.dart';

class ShowListWrapper extends StatelessWidget {
  const ShowListWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MovieListBloc(GetMovieList(Api())),
      child: const ShowList(title: 'App zum Workshop'),
    );
  }
}

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
    // _loadData(searchString);
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
                  child: Hero(
                    tag: element.show!.id!,
                    child: FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: element.show!.image!.medium!,
                    ),
                  ),
                  onTap: () {
                    if (element.show != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ShowDetails(show: element.show!),
                        ),
                      );
                    }
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

  Future _displayTextInputDialog() async {
    return showDialog(
        context: context,
        builder: (_) {
          return BlocProvider<MovieListBloc>.value(
            value: BlocProvider.of<MovieListBloc>(context),
            child: AlertDialog(
              title: const Text('Suche nach Filmen'),
              content: TextField(
                onChanged: (value) {
                  searchString = value;
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
                  child: const Text('Suchen', style: PSTextStyles.blackRegular14,),
                  onPressed: () {
                    setState(() {
                      context
                        .read<MovieListBloc>()
                        .add(MovieListRequested(searchString));
                      Navigator.pop(context);
                    });
                  },
                ),
              ],
            ),
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
            _displayTextInputDialog();
          },
          child: const Icon(
            Icons.search,
          ),
        ),
      ),
      body: BlocBuilder<MovieListBloc, MovieListState>(
        builder: (context, state) {
          return AnimatedSwitcher(
            duration: Duration(seconds: 6),
            child: (state is MovieListRequested)
                ? const Center(child: CircularProgressIndicator())
                : (state is MovieListLoadingSucceded)
                    ? SingleChildScrollView(
                        child: Table(
                          children: _buildTableRows(state.movieList),
                        ),
                      )
                    : Container(),
          );
        },
      ),
    );
  }
}

// LoadingState
// Daten geladen
// Error State
// no found state

// class MyFooContainerWidget extends StatelessWidget {
//   const MyFooContainerWidget({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => MovieListBloc(),
//       child: const MyFooWidget(),
//     );
//   }
// }

// class MyFooWidget extends StatefulWidget {
//   const MyFooWidget({Key? key}) : super(key: key);

//   @override
//   State<MyFooWidget> createState() => _MyFooWidgetState();
// }

// class _MyFooWidgetState extends State<MyFooWidget> {
//   @override
//   void initState() {
//     context.read<MovieListBloc>().add(MovieListRequested());
//     final myList = context.watch<MovieListBloc>().state;
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
