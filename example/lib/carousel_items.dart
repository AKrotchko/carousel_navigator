import 'package:flutter/material.dart';

var totalsAsset = AssetImage('assets/totals.png');
var wheelchairAsset = AssetImage('assets/wheelchair.png');
var delayAsset = AssetImage('assets/delay.png');
var spannerAsset = AssetImage('assets/spanner.png');
var trainAsset = AssetImage('assets/train.png');

var totals = Image(
  image: totalsAsset,
  fit: BoxFit.cover,
);
var wheelchair = Image(
  image: wheelchairAsset,
  fit: BoxFit.cover,
);
var delay = Image(
  image: delayAsset,
  fit: BoxFit.cover,
);
var maintenance = Image(
  image: spannerAsset,
  fit: BoxFit.cover,
);
var train = Image(
  image: trainAsset,
  fit: BoxFit.cover,
);

//A list of images that will be our carousel's items
final List<Image> carouselItems = <Image>[
  totals,
  wheelchair,
  delay,
  maintenance,
  train
];

List<Widget> carouselItemsLimited = <Widget>[
  //Simpler carousel items that are not active - This prevents awkward overflows
  // when using text, as well as preventing the icons in the back from being pressed.
  Container(
    child: IgnorePointer(
      child: totals,
    ),
  ),
  Container(
    child: IgnorePointer(
      child: wheelchair,
    ),
  ),
  Container(
    child: IgnorePointer(
      child: delay,
    ),
  ),
  Container(
    child: IgnorePointer(
      child: maintenance,
    ),
  ),
  Container(
    child: IgnorePointer(
      child: train,
    ),
  ),
];

final appBar = AppBar(
  backgroundColor: Colors.indigo,
  centerTitle: true,
  title: Container(
    child: FlutterLogo(),
  ),
);
