import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:tinder/model/user.dart';
import 'package:tinder/routes.dart';
import 'package:tinder/widgets/circle_status.dart';
import 'package:tinder/widgets/no_button.dart';
import 'package:tinder/widgets/screen_container.dart';
import 'package:tinder/widgets/yes_button.dart';
import 'package:dartx/dartx.dart';

class ProfileScreen extends StatelessWidget {
  final User user;

  const ProfileScreen({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenContainer(
      child: Container(
        width: double.infinity,
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                child: Hero(
                  tag: user.uid ?? '',
                  child: Image.network(
                    user.imgs.firstOrNull ?? '',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            _Content(data: user),
          ],
        ),
      ),
    );
  }
}

class _Content extends StatelessWidget {
  final User data;

  const _Content({Key key, this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(right: 20),
          alignment: Alignment.topRight,
          transform: Matrix4.translationValues(0.0, -30.0, 0.0),
          child: FloatingActionButton(
            onPressed: () => Navigator.pop(context),
            child: Icon(Icons.arrow_downward),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(height: 10),
              _Name(text: '${data.name} ${data.age}'),
              SizedBox(height: 8),
              _IconTextItem(
                icon: Icons.home,
                text: 'Lives in Orchard',
              ),
              SizedBox(height: 4),
              _IconTextItem(
                icon: Icons.place,
                text: '1 kilometer away',
              ),
              SizedBox(height: 20),
              _Description(data.aboutMe),
              SizedBox(height: 30),
              _ShareProfile(),
              SizedBox(height: 20),
              _Report(),
              SizedBox(height: 20),
              _Buttons(),
              SizedBox(height: 20),
            ],
          ),
        ),
      ],
    );
  }
}

class _Name extends StatelessWidget {
  final String text;
  final bool isActive;

  const _Name({Key key, this.text, this.isActive = false}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Text(
            text,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 8),
          CircleStatus(isActive: isActive),
        ],
      ),
    );
  }
}

class _Description extends StatelessWidget {
  final String text;

  const _Description(this.text, {Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: Text(
        text ?? '',
        style: TextStyle(fontSize: 12),
      ),
    );
  }
}

class _IconTextItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const _IconTextItem({Key key, this.icon, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Icon(
            icon,
            size: 16,
          ),
          SizedBox(width: 8),
          Text(
            text ?? '',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

class _ShareProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Share.share('Share profile OneMatch');
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Share Noam\'s profile'.toUpperCase(),
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 8),
          Text(
            'See what a friend thinks'.toUpperCase(),
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class _Report extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: FlatButton(
        child: Text('Report Noam'.toUpperCase(),
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
            )),
        onPressed: () {},
      ),
    );
  }
}

class _Buttons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        NoButton(
          onTap: () => Navigator.pop(context),
        ),
        SizedBox(width: 20),
        YesButton(
          onTap: () => Navigator.pushReplacement(context, MatchRoute()),
        ),
      ],
    );
  }
}
