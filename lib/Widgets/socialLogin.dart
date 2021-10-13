import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SocialLogin extends StatefulWidget {
  final Color? color;
  const SocialLogin({Key? key, this.color}) : super(key: key);

  @override
  _SocialLoginState createState() => _SocialLoginState();
}

class _SocialLoginState extends State<SocialLogin> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        //facebook login
        GestureDetector(
          onTap: () {
            //faacebook login here
          },
          child: Icon(
            FontAwesomeIcons.facebookF,
            size: 30,
            color: Color(0xff4267B2),
          ),
        ),
        // SignInButton(
        //   Buttons.Facebook,
        //   mini: true,
        //   onPressed: () {},
        // ),

        //google login
        GestureDetector(
          onTap: () {
            //google login here
          },
          child: Icon(
            FontAwesomeIcons.google,
            size: 30,
            color: Color(0xffea4335),
          ),
        ),
        // SignInButton(
        //   Buttons.Email,
        //   mini: true,
        //   onPressed: () {},
        // ),

        //twitter login
        GestureDetector(
          onTap: () {
            //twitter login here
          },
          child: Icon(
            FontAwesomeIcons.twitter,
            size: 30,
            color: Color(0xff1DA1F2),
          ),
        ),
        // SignInButton(
        //   Buttons.Twitter,
        //   mini: true,
        //   onPressed: () {},
        // ),
      ],
    );
  }
}
