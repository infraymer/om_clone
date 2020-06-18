import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tinder/widgets/circle_status.dart';

class TinderCardContent extends StatelessWidget {
  final String image;

  const TinderCardContent({Key key, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ClipRRect(
          child: Hero(
            tag: image,
            child: Image.network(
              image,
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10, bottom: 20),
          child: Align(alignment: Alignment.bottomRight, child: InfoButton()),
        ),
        Positioned(
          bottom: 10,
          left: 0,
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      'Noam 24',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(width: 8),
                    CircleStatus(isActive: true),
                  ],
                ),
                Text(
                  'IDC Herzlylah\n1 kilometer away',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w700),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

class InfoButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: Container(
        width: 30,
        height: 30,
        color: Colors.grey[300],
        child: Center(
          child: Text(
            'i',
            style:
            GoogleFonts.nunito(fontWeight: FontWeight.w800, fontSize: 16),
          ),
        ),
      ),
    );
  }
}