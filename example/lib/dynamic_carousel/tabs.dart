import 'package:flutter/material.dart';

/// These nearly identical widgets are only duplicated to prevent the necessity
/// of passing a key into the DynamicContainer in order to be animated. Because
/// these are differently named, they will all still animate. If you make them
/// into one constructor, the animations will stop working, but the container
/// will still change.

class TotalsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
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
      color: Colors.orange,
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
                Text("This button does nothing"),
                FlatButton(
                  color: Colors.blue,
                  onPressed: () {},
                  child: Text("Press me!"),
                ),
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
      color: Colors.yellow,
      child: ListView(
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: Text("Tab 2"),
          ),
          Container(
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
      color: Colors.green,
      child: ListView(
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: Text("Tab 3"),
          ),
          Container(
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text("This button does nothing"),
                FlatButton(
                  color: Colors.red,
                  onPressed: () {},
                  child: Text("Press me!"),
                ),
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
      color: Colors.blue,
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
