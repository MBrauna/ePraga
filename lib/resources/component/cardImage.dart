import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CardImage extends StatefulWidget {
  String image, animation;
  bool alert;
  Widget title, subtitle;

  CardImage({
    this.title,
    this.subtitle,
    this.image = 'robot',
    this.animation = 'reposo',
    this.alert = false,
  });

  @override
  _CardImage createState() => _CardImage();
}

class _CardImage extends State<CardImage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      width: double.infinity,
      child: Center(
        child: Stack(
          alignment: Alignment.centerLeft,
          children: <Widget>[
            Container(
              width: double.infinity,
              //height: 120.0,
              padding: EdgeInsets.only(
                left: 15.0,
                right: 15.0,
                bottom: 10.0,
                top: 10.0,
              ),
              child: Card(
                color: (widget.alert) ? Colors.red[900] : Theme.of(context).cardColor,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 60.0,
                  ),
                  child: ListTile(
                    title: widget.title,
                    subtitle: widget.subtitle,
                  ),
                ),
              ),
            ),
            Container(
              height: 120.0,
              width: 120.0,
              color: Colors.transparent,
              child: new FlareActor(
                widget.image,
                animation: widget.animation,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
