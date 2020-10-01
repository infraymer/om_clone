import 'package:flutter/material.dart';
import 'package:tinder/widgets/custom_app_bar_1.dart';

import 'base_screen.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      appBar: CustomAppBar1(textTitle: 'Terms of service'),
      body: Container(),
    );
  }
}
