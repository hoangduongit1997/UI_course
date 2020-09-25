import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'login.dart';
import 'signup.dart';
import 'welcomebackground.dart';
import '../components/rounded_button.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome to',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText1.merge(TextStyle(color: Theme.of(context).accentColor)),
            ),
            Text(
              'FoodAhuy',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline2.merge(TextStyle(fontSize: 40.0, letterSpacing: 1.0, fontWeight: FontWeight.w800, color: Theme.of(context).accentColor)),
            ),
            SizedBox(height: size.height * 0.05),
            SvgPicture.asset(
              "assets/icons/chat.svg",
              height: size.height * 0.45,
            ),
            SizedBox(height: size.height * 0.05),
            RoundedButton(
              text: "LOGIN",
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
            RoundedButton(
              text: "SIGN UP",
              color: Colors.black87,
              textColor: Colors.white,
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
    );
  }
}
