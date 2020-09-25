import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(
              "assets/img/welcome_bottom_right.png",
              width: size.width * 0.3,
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              "assets/img/welcome_top_left.png",
              width: size.width * 0.3,
            ),
          ),
          child,
        ],
      ),
    );
  }
}
