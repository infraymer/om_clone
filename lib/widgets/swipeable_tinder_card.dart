library swipeable_tinder_card;

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

double cardPaddingX = 0.1;
double cardPaddingY = 0.2;

class SwipeableCard extends StatefulWidget {
  final Function callback;
  final Widget child;

  SwipeableCard({Key key, this.callback, this.child}) : super(key: key);

  State createState() => _SwipeableState();
}

class _SwipeableState extends State<SwipeableCard> {
  double posX = -1;
  double posY = -1;
  double defX = -1;
  double defY = -1;
  double swipeRightAnchor = 200;
  double swipeLeftAnchor = -100;
  bool offScreen = false;
  int dir = 0;

  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height * 0.80;
    double widgetWidth = width * (1 - cardPaddingX);
    double widgetHeight = height * (1 - cardPaddingY);

    if (posX == -1) {
      posX = width * cardPaddingX / 2;
      posY = height * cardPaddingY / 2;
      defX = posX;
      defY = posY;
      swipeLeftAnchor = defX - (widgetWidth / 2);
      swipeRightAnchor = defX + (widgetWidth / 2);
    }

    double d = sqrt(pow(defX - posX, 2));
    Widget w = Container(
      width: widgetWidth,
      height: widgetHeight,
      child: widget.child,
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            // color: posX == defX ? Colors.black38 : posX > defX ? Colors.green : Colors.redAccent,
            color: Colors.black,
            blurRadius: d, // has the effect of softening the shadow
            spreadRadius: 0.0, // has the effect of extending the shadow
            offset: Offset(
              posX == defX ? 0 : 2.0, // horizontal, move right 10
              posX == defX ? 0 : 2.0, // vertical, move down 10
            ),
          )
        ],
      ),
    );

    w = AnimatedPositioned(
      left: posX,
      top: posY + 40,
      child: w,
      duration: Duration(milliseconds: 100),
      onEnd: () {
        if (offScreen) {
          widget.callback(
              dir == -1 ? SwipeDirection.LEFT : SwipeDirection.RIGHT,
              this.widget);
        }
      },
    );
    w = Stack(
      children: <Widget>[w],
    );
    w = GestureDetector(
        onPanUpdate: (tapInfo) {
          setState(() {
            posX += tapInfo.delta.dx;
            posY += tapInfo.delta.dy;
          });
        },
        onPanEnd: (tapInfo) {
          if (posX < -100 && !offScreen) {
            posX = -width;
            offScreen = true;
            dir = (-1);
          }
          if (posX > 200 && !offScreen) {
            posX = width * 2;
            offScreen = true;
            dir = (1);
          }

          setState(() {
            if (!offScreen) {
              posX = -1;
              posY = -1;
            }
          });
        },
        child: w);

    return w;
  }
}

enum SwipeDirection { LEFT, RIGHT }
