import 'package:carousel_navigator/spotlight_carousel.dart';
import 'package:flutter/material.dart';

import '../carousel_items.dart';

BuildContext scaffoldContext;

class SimpleCarousel extends StatelessWidget {
  final List<Widget> children = <Widget>[
    Icon(
      Icons.message,
      size: 60.0,
    ),
    Icon(
      Icons.person,
      size: 60.0,
    ),
    Icon(
      Icons.style,
      size: 60.0,
    ),
    Icon(
      Icons.transform,
      size: 60.0,
    ),
    Icon(
      Icons.refresh,
      size: 60.0,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar,
        body: Builder(builder: (BuildContext context) {
          scaffoldContext = context;
          return ListView(
            children: <Widget>[
              Container(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    "Swipe left or right to move the carousel",
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                height: 500,
                child: SpotlightCarousel(
                  maxSize: Size(200, 200),
                  children: children, //carouselItems//
                  titles: null,
                  descriptions: null,
                  onTapped: () =>
                      createSnackBar("You tapped one of the Carousel buttons"),
                ),
              ),
              Container(
                child: Align(
                  alignment: Alignment.center,
                  child: Text("Carousel Items may be tapped"),
                ),
              )
            ],
          );
        }));
  }

  createSnackBar(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      action: SnackBarAction(
          label: "dismiss",
          onPressed: () => Scaffold.of(scaffoldContext).hideCurrentSnackBar()),
    );

    Scaffold.of(scaffoldContext).showSnackBar(snackBar);
  }
}
