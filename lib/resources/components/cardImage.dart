import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CardImage extends StatefulWidget {
  String title, subtitle, image, animation;
  bool alert;

  CardImage({
    this.title = '',
    this.subtitle = '',
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
                left: 40.0,
                right: 10.0,
                bottom: 10.0,
                top: 10.0,
              ),
              child: Card(
                color: (widget.alert) ? Colors.red : Theme.of(context).cardColor,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 60.0,
                  ),
                  child: ListTile(
                    title: Text(
                      '${widget.title}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: (widget.alert) ? Colors.white : Theme.of(context).primaryColor,
                          fontFamily: 'PassionOne',
                          //fontSize: 30.0,
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      '${widget.subtitle}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Roboto',
                        color: (widget.alert) ? Colors.white : Theme.of(context).primaryColor,
                      ),
                    ),
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
