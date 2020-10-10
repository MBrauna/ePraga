import 'package:epraga/allFiles.dart';

// ignore: must_be_immutable
class CardImage extends StatefulWidget {
  String image, animation;
  Color background;
  Widget title, subtitle;
  double elevation;

  CardImage({
    this.title,
    this.subtitle,
    this.image = 'robot',
    this.animation = 'reposo',
    this.background = Colors.white,
    this.elevation  = 3.0,
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
              //height: 90.0,
              padding: EdgeInsets.only(
                //bottom: 0.0,
                //top: 0.0,
              ),
              child: Card(
                elevation: widget.elevation,
                color: widget.background,
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
              height: 90.0,
              width: 90.0,
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