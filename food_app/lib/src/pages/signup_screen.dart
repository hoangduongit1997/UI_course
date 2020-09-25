import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../controllers/user_controller.dart';
import 'signup.dart';

  class SignUpScreenWidget extends StatefulWidget {
    @override
    _SignUpScreenWidgetState createState() => _SignUpScreenWidgetState();
  }

  class _SignUpScreenWidgetState extends StateMVC<SignUpScreenWidget> {
    UserController _con;

    _SignUpScreenWidgetState() : super(UserController()) {
      _con = controller;
    }
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        key: _con.scaffoldKey,
        resizeToAvoidBottomPadding: false,
        body: SignUpWidget(),
      );
    }
  }
