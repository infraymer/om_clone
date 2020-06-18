import 'package:flutter/material.dart';

class CircleContainer extends StatelessWidget {
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final Widget child;
  final Color color;
  final Matrix4 transform;
  final double size;
  final Alignment alignment;

  const CircleContainer(
      {Key key,
      this.margin,
      this.padding,
      this.color,
      this.transform,
      this.child,
      this.size, this.alignment})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(1000),
        color: color,
      ),
      margin: margin,
      padding: padding,
      child: FittedBox(child: child),
      transform: transform,
      height: size,
      width: size,
    );
  }
}
