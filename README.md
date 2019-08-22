# CarouselNavigator

An attempt to make the spotlight_carousel written by dnys1 - Dillon Nys - More flexible and responsive.

## Getting Started

This project is a starting point for a Dart
[package](https://flutter.dev/developing-packages/),
a library module containing code that can be shared easily across
multiple Flutter or Dart projects.

For help getting started with Flutter, view our 
[online documentation](https://flutter.dev/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.

## Using the Carousel
Simply call the SpotlightCarousel build method, and enter the required parameters.

```dart
class MyCarousel extends StatelessWidget {
  MyCarousel({this.children});
  
  List<Widget> children;
  
  @override
  Widget build(BuildContext context) {
    return SpotlightCarousel(
      children: children,
      titles: null,
      descriptions: null,
      onTapped: null,
    );
  }
}
```

Simply include 2 or more children for the Carousel. You may surround this with a container in order to limit the height or width.