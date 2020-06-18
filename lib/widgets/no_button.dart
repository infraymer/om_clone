import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tinder/resources/images.dart';

class NoButton extends StatelessWidget {
  final VoidCallback onTap;

  const NoButton({Key key, this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(100);
    final double size = 50;
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        borderRadius: radius,
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 5)],
      ),
      child: Material(
        borderRadius: radius,
        color: Colors.white,
        child: InkWell(
          borderRadius: radius,
          onTap: onTap ?? () {},
          highlightColor: Colors.black38,
          child: Center(
            child: SvgPicture.asset(
              AppImages.close,
              width: 20,
            ),
          ),
        ),
      ),
    );
  }
}