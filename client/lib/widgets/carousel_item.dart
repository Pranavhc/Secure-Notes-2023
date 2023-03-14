import 'package:flutter/material.dart';

class CarouselItem extends StatelessWidget {
  final String imgpath;
  final String topline;
  final String bottomline;
  const CarouselItem(
      {super.key,
      required this.imgpath,
      required this.topline,
      required this.bottomline});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Image.asset(imgpath),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(topline,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 22,
                    fontWeight: FontWeight.bold)),
            Text(
              bottomline,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 20,
              ),
            )
          ],
        ),
      ],
    );
  }
}
