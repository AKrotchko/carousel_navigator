library carousel_navigator;

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/painting.dart';
import 'package:carousel_navigator/page_indicator.dart';

/// The heavy lifting of the Spotlight Carousel comes from the ability to
/// calculate the correct position and size of each image based on the current
/// "page" value of the invisible PageView.
class _SpotlightCarouselLayoutDelegate extends MultiChildLayoutDelegate {
  _SpotlightCarouselLayoutDelegate({
    @required this.page,
    @required this.itemCount,
    this.maxSize,
    this.minSize = const Size(0, 0),
  })  : assert(page != null && page >= 0),
        assert(itemCount != null && itemCount > 0);

  /// The changing page value
  final double page;

  /// The number of images to display
  final int itemCount;

  /// The maximum size of the images
  final Size maxSize;

  /// The minimum size of the images
  final Size minSize;

  @override
  void performLayout(Size size) {
    final double offset = (page % itemCount) / itemCount;

    for (int i = 0; i < itemCount; i++) {
      final String childId = 'item$i';
      final double alpha =
          2 * pi * (1 - (i - offset * itemCount) / itemCount) % (2 * pi);

      final double x = (1 - sin(alpha)) / 2;
      final double z = 1 - (1 - cos(alpha)) / 2;

      if (hasChild(childId)) {
        Size imageSize = (maxSize ?? size / 4) * z;
        if (imageSize.width < minSize.width ||
            imageSize.height < minSize.height) {
          imageSize = minSize;
        }
        layoutChild(childId, BoxConstraints.tight(imageSize));
        positionChild(
            childId,
            Offset(
                size.width * x - (imageSize.width / 2 * z), size.height / 6));
      }
    }
  }

  @override
  bool shouldRelayout(_SpotlightCarouselLayoutDelegate oldDelegate) =>
      page != oldDelegate.page || itemCount != oldDelegate.itemCount;
}

class SpotlightCarousel extends StatefulWidget {
  const SpotlightCarousel({
    Key key,
    @required this.children,
    @required this.titles,
    @required this.descriptions,
    @required this.onTapped,
    this.showPageIndicator = true,
    this.pageIndicatorColor = CupertinoColors.inactiveGray,
    this.maxSize,
    this.minSize = const Size(0, 0),
    this.splashColor,
    this.materialColor,
    this.controller,
  })  : assert(titles == null || children.length == titles.length),
        assert(descriptions == null || children.length == descriptions.length),
        super(key: key);

  /// A list of widgets that will be in your carousel. Typically an Image.
  final List<Widget> children;

  /// Function passed if you wish for the children to be tappable. Pass it in
  /// dynamically, using the controller as your index.
  final Function onTapped;

  /// A list of headlined titles to show below.
  /// Set to null to show none.
  final List<String> titles;

  /// A list of descriptions to include beneath the titles.
  /// Set to null to show none.
  final List<String> descriptions;

  /// Whether to show dots indicating the current page below the widget.
  final bool showPageIndicator;

  /// Color for the dots indicating the current page.
  final Color pageIndicatorColor;

  /// The maximum size of the images
  final Size maxSize;

  /// The minimum size of the images
  final Size minSize;

  /// Color of the effect when tapping. Pass in dynamically using the controller
  /// as your index.
  /// Set to null to remove the splash.
  final Color splashColor;

  /// Color of the material background. Pass in dynamically using the controller
  /// as your index
  /// Set to null to make transparent
  final Color materialColor;

  /// Use a custom scroll controller to control the carousel
  final ScrollController controller;

  @override
  _SpotlightCarouselState createState() => _SpotlightCarouselState();
}

class _SpotlightCarouselState extends State<SpotlightCarousel> {
  ScrollController _controller;
  static const Duration _kDuration = Duration(milliseconds: 300);
  static const Cubic _kCurve = Curves.ease;

  double _page = 0.0;
  int _pageIndex = 0;

  int get itemCount => widget.children.length;

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _controller = PageController(
          keepPage: false,
          initialPage: (100 *
              itemCount)); //Initial page of 100 times the item count ensures endless scrolling in either direction
    } else {
      _controller = widget.controller;
    }
    _controller.addListener(() => setState(() {
          if (_controller.offset >= 0) {
            _page = _controller.offset / MediaQuery.of(context).size.width;
            _pageIndex = (_page % itemCount).round() % itemCount;
          }
        }));
  }

  @override
  Widget build(BuildContext context) {
    final double offset = (_page % itemCount) / itemCount;
    // Sort the widgets by distance. Order of LayoutIds determines render order.
    final Map<Widget, double> distance =
        widget.children.asMap().map((int i, Widget child) {
      final double alpha =
          2 * pi * (1 - (i - offset * itemCount) / itemCount) % (2 * pi);
      final double z = cos(alpha);
      return MapEntry<Widget, double>(
          LayoutId(
            id: 'item$i',
            child: (widget.onTapped ==
                    null) //If onTapped is null, the carousel item will not be interact-able
                ? Container(
                    child: IgnorePointer(
                      child: child,
                    ),
                  )
                : Material(
                    //If a list of onTapped functions is given, each carousel item will have a unique onTapped method
                    color: (widget.materialColor == null)
                        ? Colors.transparent
                        : widget.materialColor,
                    child: InkWell(
                      child: child,
                      onTap: widget.onTapped,
                      splashColor: widget.splashColor,
                    ),
                  ),
          ),
          z);
    });
    final List<MapEntry<Widget, double>> itemList = distance.entries.toList()
      ..sort((MapEntry<Widget, double> a, MapEntry<Widget, double> b) {
        return a.value.compareTo(b.value);
      });
    final List<Widget> images =
        Map<Widget, double>.fromEntries(itemList).keys.toList();
    return Stack(
      children: <Widget>[
        _controller is PageController
            ? PageView.builder(
                controller: _controller,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    color: Colors.transparent,
                  );
                },
              )
            : ListView.builder(
                controller: _controller,
                scrollDirection: Axis.horizontal,
                itemExtent: MediaQuery.of(context).size.width,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    color: Colors.transparent,
                  );
                },
              ),
        CustomMultiChildLayout(
          children: images,
          delegate: _SpotlightCarouselLayoutDelegate(
            maxSize: widget.maxSize,
            minSize: widget.minSize,
            itemCount: itemCount,
            page: _page,
          ),
        ),
        widget.titles == null && widget.descriptions == null
            ? Container()
            : Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: MediaQuery.of(context).size.height / 2,
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      widget.titles != null
                          ? Text(widget.titles[_pageIndex],
                              style: Theme.of(context).textTheme.headline)
                          : Container(),
                      widget.descriptions != null
                          ? Text(
                              widget.descriptions[_pageIndex],
                              style: Theme.of(context)
                                  .textTheme
                                  .body2
                                  .copyWith(fontSize: 18.0),
                              textAlign: TextAlign.center,
                            )
                          : Container(),
                    ],
                  ),
                ),
              ),
        widget.showPageIndicator
            ? Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: PageIndicator(
                    page: _page,
                    itemCount: itemCount,
                    color: CupertinoColors.inactiveGray,
                    onPageSelected: (int page) {
                      _controller.animateTo(
                        page * MediaQuery.of(context).size.width,
                        duration: _kDuration,
                        curve: _kCurve,
                      );
                    },
                  ),
                ),
              )
            : Container(),
      ],
    );
  }
}
