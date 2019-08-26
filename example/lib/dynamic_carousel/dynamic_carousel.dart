import 'package:carousel_navigator/spotlight_carousel.dart';
import 'package:flutter/material.dart';

import '../carousel_items.dart';
import 'dynamic_container.dart';

class DynamicCarousel extends StatelessWidget {
  final controller = PageController(
      initialPage: (carouselItems.length *
          100)); //To allow infinite scrolling backwards.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
//      endDrawer: MiniMenu(),
      body: Container(
        height:
            (MediaQuery.of(context).size.height - appBar.preferredSize.height),
        color: Colors.grey,
        child: ListView(
          children: <Widget>[
            DynamicContainer(controller: controller),
            Carousel(
              controller: controller,
            ),
            Container(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                    "Swiping on the carousel changes the active widget above"),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Carousel extends StatefulWidget {
  Carousel({Key key, @required this.controller}) : super(key: key);

  final controller;

  _CarouselState createState() => _CarouselState(controller: controller);
}

class _CarouselState extends State<Carousel> {
  _CarouselState({@required this.controller});

  final controller;

  List<Widget> activeCarouselItems = <Widget>[
    //Which carousel widgets are currently displaying.
    carouselItems[0],
    carouselItemsLimited[1],
    carouselItemsLimited[2],
    carouselItemsLimited[3],
    carouselItemsLimited[4]
  ];

  @override
  void initState() {
    print("init called");
    super.initState();
    controller.addListener(updateCarouselWidgets);
  }

  @override
  void dispose() {
    print("dispose called");
    controller.dispose();
    super.dispose();
  }

  //ToDo - Reimplement the listener for switching in and out of a dynamic carousel item

  updateCarouselWidgets() {
    //This ridiculous listener replaces widgets when they're in front or not
    for (int i = 0; i < activeCarouselItems.length; i++) {
      activeCarouselItems[i] =
          (controller.page % activeCarouselItems.length == i)
              ? carouselItems[i]
              : carouselItemsLimited[i];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      color: Colors.grey,
      width: MediaQuery.of(context).size.width,
      child: InkWell(
        child: SpotlightCarousel(
          maxSize: Size(120, 120),
          children: carouselItems,
          titles: null,
          descriptions: ["Totals", "Wheelchair", "Delay", "Spanner", "Train"],
          controller: controller,
          showPageIndicator: false,
          onTapped: null,
          materialColor: Colors.blue,
        ),
      ),
    );
  }
}
