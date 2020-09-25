import 'package:flutter/material.dart';
import 'welcomebody.dart';
import '../helpers/helper.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: Helper.of(context).onWillPop,
        child: Scaffold(
          body: Body(),
        ),
    );
  }
}
