import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tinder/resources/colors.dart';

class OmLoading extends StatelessWidget {
  final bool white;

  const OmLoading({Key key, this.white = false}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitPumpingHeart(
        color: white ? Colors.white : AppColors.main,
        duration: Duration(milliseconds: 1000),
      ),
    );
  }
}