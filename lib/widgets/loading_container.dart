import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tinder/view_model/loading_controller.dart';
import 'package:tinder/widgets/om_loading.dart';

class LoadingContainer extends StatelessWidget {
  final Widget child;

  const LoadingContainer({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Obx(() => Visibility(
              visible: LoadingController.to.isLoading.value,
              child: _loading(),
            )),
      ],
    );
  }

  Widget _loading() => Container(
        color: Colors.black54,
        child: OmLoading(white: true),
      );
}
