import 'package:flutter/material.dart';

class CircleStatus extends StatelessWidget {
  final bool isActive;
  final double size;

  const CircleStatus({Key key, this.isActive = false, this.size = 10})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: Container(
        width: size,
        height: size,
        color: isActive ? Colors.green : Colors.red,
      ),
    );
  }
}