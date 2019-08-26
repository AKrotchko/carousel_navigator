import 'package:flutter/material.dart';

List<Widget> selectedTab = <Widget>[
  TotalsTab(),
  WheelchairTab(),
  DelaysTab(),
  SpannerTab(),
  TrainTab(),
];

class TotalsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.red, borderRadius: BorderRadius.circular(30)),
      child: ListView(
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: Text("Tab 0"),
          ),
          Container(
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FlatButton(
                  color: Colors.green,
                  onPressed: () {},
                  child: Text("Press me!"),
                ),
                Text("This button does nothing"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class WheelchairTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.orange, borderRadius: BorderRadius.circular(30)),
      child: ListView(
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: Text("Tab 1"),
          ),
          Container(
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FlatButton(
                  color: Colors.blue,
                  onPressed: () {},
                  child: Text("Press me!"),
                ),
                Text("This button does nothing"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DelaysTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.yellow, borderRadius: BorderRadius.circular(30)),
      child: ListView(
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: Text("Tab 2"),
          ),
          Container(
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FlatButton(
                  color: Colors.purple,
                  onPressed: () {},
                  child: Text("Press me!"),
                ),
                Text("This button does nothing")
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SpannerTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.green, borderRadius: BorderRadius.circular(30)),
      child: ListView(
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: Text("Tab 3"),
          ),
          Container(
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FlatButton(
                  color: Colors.red,
                  onPressed: () {},
                  child: Text("Press me!"),
                ),
                Text("This button does nothing"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TrainTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.blue, borderRadius: BorderRadius.circular(30)),
      child: ListView(
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: Text("Tab 4"),
          ),
          Container(
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FlatButton(
                  color: Colors.orange,
                  onPressed: () {},
                  child: Text("Press me!"),
                ),
                Text("This button does nothing"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CarouselAnimatedContainer extends StatelessWidget {
  CarouselAnimatedContainer(
      {@required this.backgroundColor, @required this.content})
      : assert(content != null);

  final backgroundColor;
  final content;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height - 225,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 5),
        borderRadius: BorderRadius.circular(20),
        color: backgroundColor,
      ),
      child: content,
    );
  }
}

class DynamicContainer extends StatefulWidget {
  DynamicContainer({@required this.controller, Key key}) : super(key: key);

  final PageController controller;

  _DynamicContainerState createState() =>
      _DynamicContainerState(controller: controller);
}

class _DynamicContainerState extends State<DynamicContainer> {
  _DynamicContainerState({@required this.controller});

  final PageController controller;
  Widget _myAnimatedWidget;

  @override
  void initState() {
    super.initState();
    controller.addListener(switchWidget);
    _myAnimatedWidget = selectedTab[0];
  }

  @override
  void dispose() {
    super.dispose();
  }

  //selectedTab[0],
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      color: Colors.transparent,
      height: MediaQuery.of(context).size.height * (63 / 100),
      child: AnimatedSwitcher(
        switchInCurve: Curves.fastOutSlowIn,
        switchOutCurve: Curves.fastOutSlowIn,
        transitionBuilder: (Widget child, Animation<double> animation) {
          final posAnimation =
              Tween(begin: Offset(0.0, -1.0), end: Offset(0.0, 0.0))
                  .animate(animation);

          return SlideTransition(
            position: posAnimation,
            child: child,
          );
        },
        duration: Duration(milliseconds: 500),
        child: _myAnimatedWidget,
      ),
    );
  }

  switchWidget() {
    setState(() {
      _myAnimatedWidget =
          selectedTab[controller.page.round() % selectedTab.length];
    });
  }
}
