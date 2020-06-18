import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tinder/resources/images.dart';

class YesButton extends StatelessWidget {
  final VoidCallback onTap;
  final int count;

  const YesButton({Key key, this.count, this.onTap}) : super(key: key);

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
        child: InkWell(
          onTap: onTap ?? () {},
          borderRadius: radius,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset(
                AppImages.heart,
                width: count == null ? 24 : 16,
                color: Colors.red[400],
              ),
              if (count != null)
                Text(
                  count.toString(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
