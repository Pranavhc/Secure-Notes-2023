import 'package:client/widgets/carousel_item.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:infinite_carousel/infinite_carousel.dart';

class InfiniteCarouselWidget extends StatefulWidget {
  const InfiniteCarouselWidget({super.key});

  @override
  InfiniteCarouselWidgetState createState() => InfiniteCarouselWidgetState();
}

class InfiniteCarouselWidgetState extends State<InfiniteCarouselWidget> {
  // Scroll controller for carousel
  late InfiniteScrollController _controller;

  // Maintain current index of carousel
  int _selectedIndex = 0;

  // Width of each item
  double? _itemExtent;

  // Get screen width of viewport.
  double get screenWidth => MediaQuery.of(context).size.width;

  @override
  void initState() {
    super.initState();
    _controller = InfiniteScrollController(initialItem: _selectedIndex);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _itemExtent = screenWidth - 20;
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  final List<Widget> _demo = [
    const CarouselItem(
        imgpath: "assets/gif1.gif",
        topline: "Document and Organize your work",
        bottomline: "the easy way! 👌"),
    const CarouselItem(
        imgpath: "assets/gif2.gif",
        topline: "Take notes fast as hell",
        bottomline: "be more productive! ⚡"),
    const CarouselItem(
        imgpath: "assets/gif3.gif",
        topline: "Don't wait, get started now",
        bottomline: "let's goooooo! 🤘 ")
  ];

  @override
  Widget build(BuildContext context) {
    return InfiniteCarousel.builder(
      center: true,
      itemCount: _demo.length,
      itemExtent: _itemExtent ?? 340,
      scrollBehavior: kIsWeb
          ? ScrollConfiguration.of(context).copyWith(dragDevices: {
              // Allows to swipe in web browsers
              PointerDeviceKind.touch,
              PointerDeviceKind.mouse
            })
          : null,
      loop: true,
      controller: _controller,
      onIndexChanged: (index) {
        if (_selectedIndex != index) {
          setState(() {
            _selectedIndex = index;
          });
        }
      },
      itemBuilder: (context, itemIndex, realIndex) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: GestureDetector(
            onTap: () {
              _controller.animateToItem(realIndex);
            },
            child: Container(
              child: _demo[itemIndex],
            ),
          ),
        );
      },
    );
  }
}
