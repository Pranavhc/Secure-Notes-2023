import 'package:client/colors.dart';
import 'package:flutter/material.dart';

class NavigatingElevatedButton extends StatelessWidget {
  final String string;
  final Widget? location;

  const NavigatingElevatedButton({
    Key? key,
    required this.string,
    this.location,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: 200,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [kFairText, Color(0xFFC6C6C6)],
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
        child: Text(string,
            style: const TextStyle(
                color: kDarkText, fontWeight: FontWeight.bold, fontSize: 18)),
      ),
    );
  }
}
