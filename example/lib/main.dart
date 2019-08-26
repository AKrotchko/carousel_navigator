import 'package:flutter/material.dart';

import 'carousel_items.dart';
import 'dynamic_carousel/dynamic_carousel.dart';
import 'simple_carousel/simple_carousel.dart';

void main() => runApp(Example());

class Example extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CarouselSelection(),
    );
  }
}

class CarouselSelection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: ListView(
        children: <Widget>[
          RaisedButton(
            child: Text("Basic Carousel"),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SimpleCarousel()));
            },
          ),
          RaisedButton(
            child: Text("Dynamic Carousel"),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DynamicCarousel()));
            },
          )
        ],
      ),
    );
  }
}
