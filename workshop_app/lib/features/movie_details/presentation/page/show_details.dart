import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../../../model/show_model.dart';

class ShowDetails extends StatefulWidget {
  static const descriptionKey = Key('ShowDetails.descriptionKey');

  final Show show;
  const ShowDetails({Key? key, required this.show}) : super(key: key);

  @override
  State<ShowDetails> createState() => _ShowDetailsState();
}

class _ShowDetailsState extends State<ShowDetails> {
  @override
  void initState() {
    super.initState();
    if (kDebugMode) {
      print('Show: ${widget.show.name}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.show.name!),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (widget.show.image != null)
            Hero(
              tag: widget.show.id!,
              child: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: widget.show.image!.original!,
              ),
            ),
            Html(
              key: ShowDetails.descriptionKey,
              data: widget.show.summary!,
            )
          ],
        ),
      ),
    );
  }
}
