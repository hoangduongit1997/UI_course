import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../generated/l10n.dart';
import '../controllers/user_controller.dart';
import '../elements/BlockButtonWidget.dart';
import '../helpers/app_config.dart' as config;
import '../helpers/helper.dart';
import '../repository/user_repository.dart' as userRepo;
import '../components/already_have_an_account_acheck.dart';
import '../components/forgot_password.dart';
import 'signup.dart';
import 'forget_password.dart';
import 'loginbackground.dart';

class LoginWidget extends StatefulWidget {
  @override

  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends StateMVC<LoginWidget> {
  UserController _con;

  _LoginWidgetState() : super(UserController()) {
    _con = controller;
  }
  @override
  void initState() {
    super.initState();
    if (userRepo.currentUser.value.apiToken != null) {
      Navigator.of(context).pushReplacementNamed('/Pages', arguments: 2);
    }
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
                  "LOGIN",
                   style: Theme.of(context).textTheme.headline2.merge(TextStyle(color: Theme.of(context).accentColor)),
                ),
                SizedBox(height: size.height * 0.02),
                SvgPicture.asset(
                "assets/icons/login.svg",
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
                        TextFormField(
                          style: TextStyle(
                              color: Colors.black,
                          ),
                          keyboardType: TextInputType.text,
                          onSaved: (input) => _con.user.password = input,
                          validator: (input) => input.length < 3 ? S.of(context).should_be_more_than_3_characters : null,
                          obscureText: _con.hidePassword,
                          decoration: InputDecoration(
                            labelText: S.of(context).password,
                            labelStyle: TextStyle(color: Colors.black),
                            contentPadding: EdgeInsets.all(20),
                            fillColor: Colors.black12,
                            filled: true,
                            hintText: '••••••••••••',
                            hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),
                            prefixIcon: Icon(Icons.lock_outline, color: Theme.of(context).accentColor),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _con.hidePassword = !_con.hidePassword;
                                });
                              },
                              color: Theme.of(context).focusColor,
                              icon: Icon(_con.hidePassword ? Icons.visibility : Icons.visibility_off),
                            ),
                            border: border,
                            focusedBorder:  border,
                          ),
                        ),
                        SizedBox(height: 20),
                        BlockButtonWidget(
                          text: Text(
                            'LOGIN',
                            style: TextStyle(color: Theme.of(context).primaryColor),
                          ),
                          color: Theme.of(context).accentColor,
                          onPressed: () {
                            _con.login();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                ForgotPassword(
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return ForgetPasswordWidget();
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
