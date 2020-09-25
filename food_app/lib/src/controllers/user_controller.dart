import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../helpers/helper.dart';
import '../models/user.dart';
import '../repository/user_repository.dart' as repository;

class UserController extends ControllerMVC {
  User user = new User();
  bool hidePassword = true;
  bool loading = false;
  GlobalKey<FormState> loginFormKey;
  GlobalKey<ScaffoldState> scaffoldKey;
  FirebaseMessaging _firebaseMessaging;
  OverlayEntry loader;

  UserController() {
    loader = Helper.overlayLoader(context);
    loginFormKey = new GlobalKey<FormState>();
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    _firebaseMessaging = FirebaseMessaging();
    _firebaseMessaging.getToken().then((String _deviceToken) {
      user.deviceToken = _deviceToken;
    }).catchError((e) {
      print('Notification not configured');
    });
  }

  void login() async {
    FocusScope.of(context).unfocus();
    if (loginFormKey.currentState.validate()) {
      loginFormKey.currentState.save();
      Overlay.of(context).insert(loader);
      repository.login(user).then((value) {
        if (value != null && value.apiToken != null) {
          Navigator.of(scaffoldKey.currentContext).pushReplacementNamed('/Pages', arguments: 2);
        } else {
          scaffoldKey?.currentState?.showSnackBar(SnackBar(
            content: Text(S.of(context).wrong_email_or_password),
          ));
        }
      }).catchError((e) {
        loader.remove();
        scaffoldKey?.currentState?.showSnackBar(SnackBar(
          content: Text(S.of(context).this_account_not_exist),
        ));
      }).whenComplete(() {
        Helper.hideLoader(loader);
      });
    }
  }

  void register() async {
    FocusScope.of(context).unfocus();
    if (loginFormKey.currentState.validate()) {
      loginFormKey.currentState.save();
      Overlay.of(context).insert(loader);
      repository.register(user).then((value) {
        if (value != null && value.apiToken != null) {
          Navigator.of(scaffoldKey.currentContext).pushReplacementNamed('/SetupDeliveryAddress');
        } else {
          scaffoldKey?.currentState?.showSnackBar(SnackBar(
            content: Text(S.of(context).wrong_email_or_password),
          ));
        }
      }).catchError((e) {
        loader?.remove();
        scaffoldKey?.currentState?.showSnackBar(SnackBar(
          content: Text(S.of(context).this_email_account_exists),
        ));
      }).whenComplete(() {
        Helper.hideLoader(loader);
      });
    }
  }

  void resetPassword() {
    FocusScope.of(context).unfocus();
    if (loginFormKey.currentState.validate()) {
      loginFormKey.currentState.save();
      Overlay.of(context).insert(loader);
      repository.resetPassword(user).then((value) {
        if (value != null && value == true) {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                // return object of type Dialog
                return AlertDialog(
                  title: Wrap(
                    spacing: 10,
                    children: <Widget>[
                      Icon(Icons.check_circle, color: Colors.green),
                      Text(
                        S.of(context).your_reset_link_has_been_sent_to_your_email,
                        style: TextStyle(color: Colors.green),
                      ),
                    ],
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 25),
                  actions: <Widget>[
                    FlatButton(
                      child: new Text(
                        "Ok",
                        style: TextStyle(color: Theme.of(context).hintColor),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(scaffoldKey.currentContext).pushReplacementNamed('/Login');
                      },
                    ),
                  ],
                );
              },
            );
        } else {
          loader.remove();
          showDialog(
              context: context,
              builder: (BuildContext context) {
                // return object of type Dialog
                return AlertDialog(
                  title: Wrap(
                    spacing: 10,
                    children: <Widget>[
                      Icon(Icons.close, color: Colors.red),
                      Text(
                        'Invalid email address',
                        style: TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 25),
                  actions: <Widget>[
                    FlatButton(
                      child: new Text(
                        "Retry",
                        style: TextStyle(color: Theme.of(context).hintColor),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
        }
      }).whenComplete(() {
        Helper.hideLoader(loader);
      });
    }
  }
}
