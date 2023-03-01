import 'package:client/utils/colors.dart';
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
        Image.asset(imgpath),
        const SizedBox(height: 10),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              topline,
              style: const TextStyle(
                  color: kFairText, fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(
              bottomline,
              style: const TextStyle(
                color: kFairText,
                fontSize: 20,
              ),
            )
          ],
        ),
      ],
    );
  }
}
