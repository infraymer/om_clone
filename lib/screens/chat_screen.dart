import 'package:flutter/material.dart';
import 'package:tinder/constants.dart';
import 'package:tinder/resources/colors.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            _AppBar(),
            Expanded(
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: <Widget>[
                  _MatchDate(),
//                  MessageItem(isDelivery: true),
//                  OwnerMessageItem(),
//                  DateItem(),
//                  MessageItem(),
                ],
              ),
            ),
            ChatInputMessage(),
            SizedBox(height: 10),
            ChatActionPanel(),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.black12),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        Container(
          alignment: Alignment.centerRight,
          child: IconButton(
            icon: Icon(Icons.beenhere, color: Colors.black12),
            onPressed: () {},
          ),
        ),
        Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  _Avatar(size: 40),
                  SizedBox(height: 2),
                  Text('Lola',
                      style: TextStyle(fontSize: 10, color: Colors.black38))
                ],
              ),
            ),
            Container(
              color: AppColors.divider,
              height: 2,
            )
          ],
        ),
      ],
    );
  }
}

class DateItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text(
        'Sat, 29 May, 8:24',
        style: TextStyle(
          fontSize: 12,
          color: Colors.black26,
        ),
      ),
    );
  }
}

class MessageItem extends StatelessWidget {
  final bool isDelivery;

  const MessageItem({Key key, this.isDelivery = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _Avatar(),
          SizedBox(width: 16),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(top: 2),
            child: _TextBody(isDelivery: isDelivery),
          )),
          SizedBox(width: 30),
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: _LikeButton(),
          ),
        ],
      ),
    );
  }
}

class OwnerMessageItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Expanded(
            child: _OwnerTextBody(),
          ),
        ],
      ),
    );
  }
}

class _MatchDate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: FittedBox(
        child: Text(
          'YOU MATCHED WIH RAYZA ON Sat, 29 may, 8:24',
          style: TextStyle(
            fontSize: 14,
            color: Colors.black38,
          ),
        ),
      ),
    );
  }
}

class _Sent extends StatelessWidget {
  final EdgeInsetsGeometry margin;
  final bool isDelivery;

  const _Sent({Key key, this.margin, this.isDelivery = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          if (isDelivery) _SentIcon(),
          SizedBox(width: 8),
          Text(
            'Sent, 2:43 PM',
            style: TextStyle(
              fontSize: 12,
              color: Colors.black26,
            ),
          ),
        ],
      ),
    );
  }
}

class _SentIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.blue,
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 2)]),
      child: Icon(
        Icons.done_all,
        size: 14,
        color: Colors.white,
      ),
    );
  }
}

class _LikeButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Icon(
        Icons.favorite_border,
        color: Colors.grey[200],
        size: 32,
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  final double size;

  const _Avatar({Key key, this.size = 50}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color: Colors.black12)),
        child: Image.network(
          Constants.womanImage,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _OwnerTextBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        IntrinsicWidth(
          child: Container(
            alignment: Alignment.centerRight,
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(30, 16, 16, 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(8),
                bottomRight: Radius.circular(8),
                bottomLeft: Radius.circular(40),
              ),
              color: Colors.blue[300],
            ),
            child: Text(
              'Text messageText ',
              style: TextStyle(fontSize: 14, color: Colors.white),
            ),
          ),
        ),
        _Sent(margin: EdgeInsets.only(top: 8)),
      ],
    );
  }
}

class _TextBody extends StatelessWidget {
  final bool isDelivery;

  const _TextBody({Key key, this.isDelivery}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
              bottomRight: Radius.circular(40),
              bottomLeft: Radius.circular(20),
            ),
            color: AppColors.textField,
          ),
          child: Text(
            'Text messageText ',
            style: TextStyle(fontSize: 14, color: Colors.black54),
          ),
        ),
        _Sent(
            margin: EdgeInsets.only(top: 8, right: 16), isDelivery: isDelivery),
      ],
    );
  }
}

class ChatInputMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      padding: EdgeInsets.only(left: 20, right: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: Colors.black12, width: 1),
        color: AppColors.textField.withOpacity(0.5),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              style: TextStyle(color: Colors.black38, fontSize: 12),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Type a message here...',
              ),
            ),
          ),
          Text(
            'Send',
            style: TextStyle(
              color: Colors.black38,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}

class ChatActionPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: <Widget>[
          ChatActionContainer(
            child: Icon(
              Icons.contact_phone,
              color: Colors.black38,
              size: 16,
            ),
          ),
          SizedBox(width: 16),
          ChatActionContainer(
            child: Icon(Icons.gif),
          ),
          SizedBox(width: 16),
          ChatActionContainer(
            child: Icon(
              Icons.music_note,
              size: 20,
              color: Colors.green,
            ),
          )
        ],
      ),
    );
  }
}


class ChatActionContainer extends StatelessWidget {
  final Widget child;

  const ChatActionContainer({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double size = 30;
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: AppColors.textField.withOpacity(0.5),
        border: Border.all(color: Colors.black12, width: 1),
      ),
      child: child,
    );
  }
}
