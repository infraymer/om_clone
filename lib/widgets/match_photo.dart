import 'package:flutter/material.dart';

class MatchPhoto extends StatelessWidget {
  final String imageNetwork;

  const MatchPhoto(this.imageNetwork, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(500);
    final size = 500.0;
    return ClipRRect(
      borderRadius: radius,
      child: Container(
        color: Colors.white,
        width: size,
        height: size,
        padding: EdgeInsets.all(10),
        child: ClipRRect(
          borderRadius: radius,
          child: Image.network(
            imageNetwork,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
