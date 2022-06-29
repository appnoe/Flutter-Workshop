import 'package:flutter/material.dart';

class BigButton extends StatelessWidget {
  void Function()? onTap;

  BigButton({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: onTap, child: Container(color: Colors.blue, width: 300, height: 200, child: Text('Drück mich'),));
  }
}