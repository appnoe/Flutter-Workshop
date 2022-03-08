import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pongping/view/ball.dart';
import 'package:pongping/view/bat.dart';

enum Direction { up, down, left, right }

class Game extends StatefulWidget {
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> with SingleTickerProviderStateMixin {
  double width = 0;
  double height = 0;
  double xPosition = 0;
  double yPosition = 0;
  double batWidth = 0;
  double batHeight = 0;
  double batPosition = 0;
  Direction verticalDirection = Direction.down;
  Direction horizontalDirection = Direction.right;
  late Animation<double> animation;
  late AnimationController animationController;
  double increment = 5;
  double randomX = 1;
  double randomY = 1;
  int score = 0;

  @override
  void initState() {
    super.initState();
    xPosition = 0;
    yPosition = 0;
    animationController = AnimationController(
      duration: const Duration(minutes: 10000),
      vsync: this,
    );

    animation = Tween<double>(begin: 0, end: 100).animate(animationController);
    animation.addListener(() {
      setState(() {
        checkBorders();
        (horizontalDirection == Direction.right)
            ? xPosition += ((increment * randomX).round())
            : xPosition -= ((increment * randomX).round());
        (verticalDirection == Direction.down)
            ? yPosition += ((increment * randomY).round())
            : yPosition -= ((increment * randomY).round());
      });

      checkBorders();
    });

    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      height = constraints.maxHeight;
      width = constraints.maxWidth;
      batWidth = width / 5;
      batHeight = height / 20;

      return Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            right: 24,
            child: Text('Score: ' + score.toString()),
          ),
          Positioned(
            child: Ball(),
            top: yPosition,
            left: xPosition,
          ),
          Positioned(
              bottom: 0,
              left: batPosition,
              child: GestureDetector(
                  onHorizontalDragUpdate: (DragUpdateDetails update) => moveBat(update, context),
                  child: Bat(batWidth, batHeight))),
        ],
      );
    });
  }

  void checkBorders() {
    double diameter = 50;
    if (xPosition <= 0 && horizontalDirection == Direction.left) {
      horizontalDirection = Direction.right;
      randomX = randomNumber();
    }
    if (xPosition >= width - diameter && horizontalDirection == Direction.right) {
      horizontalDirection = Direction.left;
      randomX = randomNumber();
    }
    //check the bat position as well
    if (yPosition >= height - diameter - batHeight && verticalDirection == Direction.down) {
      //check if the bat is here, otherwise loose
      if (xPosition >= (batPosition - diameter) &&
          xPosition <= (batPosition + batWidth + diameter)) {
        verticalDirection = Direction.up;
        randomY = randomNumber();
        setState(() {
          score++;
        });
      } else {
        animationController.stop();
        showMessage(context);
      }
    }
    if (yPosition <= 0 && verticalDirection == Direction.up) {
      verticalDirection = Direction.down;
      randomX = randomNumber();
    }
  }

  void moveBat(DragUpdateDetails update, BuildContext context) {
    setState(() {
      batPosition += update.delta.dx;
    });
  }

  double randomNumber() {
    //this is a number between 0.5 and 1.5;
    var ran = new Random();
    int myNum = ran.nextInt(100);
    return (50 + myNum) / 100;
  }

  void showMessage(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Game Over'),
            content: Text('Would you like to play again?'),
            actions: <Widget>[
              FlatButton(
                child: Text('Yes'),
                onPressed: () {
                  setState(() {
                    xPosition = 0;
                    yPosition = 0;
                    score = 0;
                  });
                  Navigator.of(context).pop();
                  animationController.repeat();
                },
              ),
              FlatButton(
                child: Text('No'),
                onPressed: () {
                  Navigator.of(context).pop();
                  dispose();
                },
              )
            ],
          );
        });
  }
}
