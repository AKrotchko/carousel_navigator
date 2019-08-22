# CarouselNavigator

An attempt to make the spotlight_carousel written by [dnys1 - Dillon Nys](SpotlightCarousel) more flexible and responsive.

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