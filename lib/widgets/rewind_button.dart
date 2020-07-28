import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tinder/resources/images.dart';
import 'package:tinder/resources/ui_icons.dart';

class RewindButton extends StatelessWidget {
  final VoidCallback onTap;
  final int count;

  const RewindButton({Key key, this.count, this.onTap}) : super(key: key);

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
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Icon(UiIcons.refresh, size: 32, color: Colors.orange,),
              if (count != null)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    count.toString(),
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}