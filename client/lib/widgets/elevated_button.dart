import 'package:client/utils/colors.dart';
import 'package:flutter/material.dart';

class NavigatingElevatedButton extends StatelessWidget {
  final String string;
  final Widget? location;
  final Color color1;
  final Color color2;
  final double radius;
  final double top;
  final double bottom;
  final double right;
  final double left;
  final double width;
  final double height;
  final String imgpath;

  const NavigatingElevatedButton({
    Key? key,
    required this.string,
    this.location,
    this.top = 0,
    this.bottom = 0,
    this.right = 0,
    this.left = 0,
    this.radius = 0,
    this.width = 200,
    this.height = 45,
    this.color1 = kFairText,
    this.color2 = const Color(0xFFC6C6C6),
    this.imgpath = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(top: top, bottom: bottom, left: left, right: right),
      child: Container(
        height: height,
        width: width,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [color2, color1],
            )),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => location!));
          },
          style: ButtonStyle(
              shadowColor: MaterialStateProperty.all(Colors.transparent),
              backgroundColor: MaterialStateProperty.all(Colors.transparent),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              imgpath.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: Image.asset(
                        imgpath,
                        height: 25,
                        width: 25,
                      ),
                    )
                  : const Padding(padding: EdgeInsets.zero),
              Text(string,
                  style: const TextStyle(
                      color: kDarkText,
                      fontWeight: FontWeight.bold,
                      fontSize: 18)),
            ],
          ),
        ),
      ),
    );
  }
}
