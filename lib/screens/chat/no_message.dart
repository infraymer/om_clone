import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:tinder/view_model/chat_controller.dart';

class NoMessage extends StatelessWidget {
  final data;
  const NoMessage({this.data});
  @override
  Widget build(BuildContext context) {
    final data = ChatController.to.user.value;
    print('###################   ChatController.to.user');
    print(data.heroTag);
    return Column(
      children: [
        Padding(
          padding: EdgeInsetsDirectional.only(top: 24.0),
          child: Column(
            children: [
              Text(
                'You matched width',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '19 minutes ago',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.only(top: 24.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(300),
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: Colors.black12)),
              child: Image.network(
                data.imgs.firstOrNull ?? '',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.only(top: 24.0),
          child: Text(
            'See when ${data.name} answers',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.only(top: 24.0),
          child: OutlineButton(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Enable Notifications"),
            ),
            onPressed: () {},
            color: Colors.blueAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
        ),
      ],
    );
  }
}
