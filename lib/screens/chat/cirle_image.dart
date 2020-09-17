import 'package:flutter/material.dart';

class CircleImage extends StatelessWidget {
  final String img;
  const CircleImage({@required this.img});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 55,
      backgroundColor: Color(0xffFDCF09),
      child: CircleAvatar(
        radius: 50,
        backgroundImage: AssetImage(img),
      ),
    );
  }
}
