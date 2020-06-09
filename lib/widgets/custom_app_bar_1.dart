import 'package:flutter/material.dart';

import 'app_back_button.dart';

class CustomAppBar1 extends StatelessWidget {
  final Widget leading;
  final String textTitle;

  CustomAppBar1({
    Key key,
    this.textTitle,
    this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ModalRoute<dynamic> parentRoute = ModalRoute.of(context);
    final canPop = parentRoute.canPop;
    return Container(
      padding: EdgeInsets.only(top: 16),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Align(
            alignment: Alignment.bottomLeft,
            child: leading == null && canPop
                ? AppBackButton(
                    onPressed: () => Navigator.pop(context),
                  )
                : leading,
          ),
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width * 0.5,
            child: Text(
              textTitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
