import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:flutter_svg/svg.dart';
import '../../generated/l10n.dart';
import '../controllers/user_controller.dart';
import '../elements/BlockButtonWidget.dart';
import '../helpers/app_config.dart' as config;
import 'welcomebackground.dart';
import 'signup.dart';
import 'login.dart';
import '../components/already_have_an_account_acheck.dart';
import '../components/return_to_login.dart';
class ForgetPasswordWidget extends StatefulWidget {
  @override
  _ForgetPasswordWidgetState createState() => _ForgetPasswordWidgetState();
}

class _ForgetPasswordWidgetState extends StateMVC<ForgetPasswordWidget> {
  UserController _con;

  _ForgetPasswordWidgetState() : super(UserController()) {
    _con = controller;
  }
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final border = OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(100.0)),
            borderSide: BorderSide.none,
    );

    return Scaffold(
        key: _con.scaffoldKey,
        body: Background(
           child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "FORGOT PASSWORD",
                   style: Theme.of(context).textTheme.headline2.merge(TextStyle(color: Theme.of(context).accentColor)),
                ),
                SizedBox(height: size.height * 0.02),
                SvgPicture.asset(
                "assets/icons/forgot.svg",
                height: size.height * 0.30,
                ),
                Form(
                  key: _con.loginFormKey,
                  child: Container(
                    padding: EdgeInsets.only(top: 5, right: 20, left: 20, bottom: 5),
                    width: config.App(context).appWidth(88),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        TextFormField(
                          style: TextStyle(
                              color: Colors.black,
                          ),
                          keyboardType: TextInputType.emailAddress,
                          onSaved: (input) => _con.user.email = input,
                          validator: (input) => !input.contains('@') ? S.of(context).should_be_a_valid_email : null,
                          decoration: InputDecoration(
                            labelText: S.of(context).email,
                            labelStyle: TextStyle(color: Colors.black),
                            contentPadding: EdgeInsets.all(20),
                            fillColor: Colors.black12,
                            filled: true,
                            hintText: 'sample@email.com',
                            hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),
                            prefixIcon: Icon(Icons.alternate_email, color: Theme.of(context).accentColor),
                            border: border,
                            focusedBorder: border,
                          ),
                        ),
                        SizedBox(height: 20),
                        BlockButtonWidget(
                          text: Text(
                            'SEND LINK',
                            style: TextStyle(color: Theme.of(context).primaryColor),
                          ),
                          color: Theme.of(context).accentColor,
                          onPressed: () {
                            _con.resetPassword();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                ReturntoLogin(
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return LoginWidget();
                        },
                      ),
                    );
                  },
                ),
                SizedBox(height: size.height * 0.03),
                AlreadyHaveAnAccountCheck(
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return SignUpWidget();
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
    );
  }
}
