import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_validator/form_validator.dart';
import 'package:mediumreplica/Services/auth.dart';
import 'package:mediumreplica/Services/loading.dart';
import 'package:mediumreplica/Shared%20Prefrences/theme_manager.dart';
import 'package:mediumreplica/Widgets/bottom_navbar.dart';
import 'package:mediumreplica/Widgets/or_divider.dart';
import 'package:mediumreplica/Screens/register.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  final AuthService auth = AuthService();

  bool loading = false;

  String adminEmail = 'hpdellappleasus@gmail.com';

  String email = '';
  String password = '';
  String error = '';

  bool _obscureText = true;
  Icon eye = Icon(Icons.visibility_off);
  Color eyeColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    var theme = Provider.of<ThemeNotifier>(context);

    return loading
        ? Loading()
        : Scaffold(
            resizeToAvoidBottomInset: false,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: size.height * 0.15,
                  width: size.width,
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height * 0.06,
                      ),
                      Shimmer.fromColors(
                        baseColor:
                            theme.getTheme().brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black,
                        highlightColor: theme.getTheme().backgroundColor,
                        child: Image.asset("assets/img/logo.png"),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: size.height * 0.1,
                  child: Center(
                    child: Text(
                      'Welcome Back',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  height: size.height * 0.35,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 0),
                        child: Text(
                          'Sign in with Email',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Form(
                        key: formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              height: size.height * 0.1,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: TextFormField(
                                  controller: emailController,
                                  onChanged: (val) {
                                    setState(() => email = val);
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.email,
                                        color:
                                            Theme.of(context).iconTheme.color,
                                      ),
                                      labelText: "Email"),
                                  validator: ValidationBuilder()
                                      .email()
                                      .maxLength(50)
                                      .build(),
                                ),
                              ),
                            ),
                            Container(
                              height: size.height * 0.1,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: TextFormField(
                                  controller: passController,
                                  onChanged: (val) {
                                    setState(() => password = val);
                                  },
                                  keyboardType: TextInputType.text,
                                  obscureText: _obscureText,
                                  decoration: InputDecoration(
                                      suffixIcon: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _obscureText = !_obscureText;
                                            _obscureText == true
                                                ? eye =
                                                    Icon(Icons.visibility_off)
                                                : eye = Icon(Icons.visibility);
                                            _obscureText == true
                                                ? eyeColor = Colors.grey
                                                : eyeColor = Theme.of(context)
                                                    .iconTheme
                                                    .color!;
                                          });
                                        },
                                        child: Icon(
                                          eye.icon,
                                          color: eyeColor,
                                        ),
                                      ),
                                      prefixIcon: Icon(
                                        Icons.lock,
                                        color:
                                            Theme.of(context).iconTheme.color,
                                      ),
                                      labelText: "Password"),
                                  validator: ValidationBuilder()
                                      .minLength(6)
                                      .maxLength(15)
                                      .build(),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                if (formKey.currentState!.validate()) {
                                  setState(() => loading = true);

                                  dynamic result =
                                      await auth.signInWithEmailandPassword(
                                          email, password);
                                  if (result == null) {
                                    setState(() {
                                      loading = false;
                                      error = "Wrong Email or Password!";
                                    });
                                  } else {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                HomeScreen()));
                                  }
                                }
                              },
                              child: Container(
                                height: size.height * 0.05,
                                width: size.width * 0.7,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? Colors.black
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(
                                  child: Text(
                                    'Sign in',
                                    style: TextStyle(
                                      color: Theme.of(context).brightness ==
                                              Brightness.light
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: size.height * 0.01,
                            ),
                            Text(
                              error,
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: size.height * 0.1,
                  child: Center(
                    child: OrDivider(
                      Theme.of(context).brightness == Brightness.light
                          ? Colors.black
                          : Colors.white,
                    ),
                  ),
                ),
                Container(
                  height: size.height * 0.05,
                  child: Text('Sign in with'),
                ),
                Container(
                  height: size.height * 0.05,
                  // color: Colors.red,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //facebook login
                      InkWell(
                        onTap: () async {
                          setState(() {
                            loading = true;
                          });
                          dynamic result = await auth.signInWithFacebook();

                          if (result == null) {
                            setState(() {
                              loading = false;
                              error = 'Error Logging with Facebook.';
                            });
                          } else {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()));
                          }
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(shape: BoxShape.circle),
                          child: Icon(
                            FontAwesomeIcons.facebookF,
                            size: 30,
                            color: Color(0xff4267B2),
                          ),
                        ),
                      ),

                      //google login
                      InkWell(
                        onTap: () async {
                          setState(() {
                            loading = true;
                          });
                          dynamic result = await auth.googlesignin();
                          if (result == null) {
                            setState(() {
                              loading = false;
                              error = 'Error Logging with Google.';
                            });
                          } else {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()));
                          }
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(shape: BoxShape.circle),
                          child: Icon(
                            FontAwesomeIcons.google,
                            size: 30,
                            color: Color(0xffea4335),
                          ),
                        ),
                      ),

                      //twitter login
                      // GestureDetector(
                      //   onTap: () {
                      //     //twitter login here
                      //   },
                      //   child: Icon(
                      //     FontAwesomeIcons.twitter,
                      //     size: 30,
                      //     color: Color(0xff1DA1F2),
                      //   ),
                      // ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignupScreen()));
                  },
                  child: Container(
                    height: size.height * 0.1,
                    child: Center(
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Don't have an account?  ",
                              style: TextStyle(
                                color: Theme.of(context).brightness ==
                                        Brightness.light
                                    ? Colors.black
                                    : Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextSpan(
                              text: 'Sign Up',
                              style: TextStyle(
                                color: Theme.of(context).brightness ==
                                        Brightness.light
                                    ? Colors.black
                                    : Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: size.height * 0.1,
                ),
              ],
            ),
          );
  }
}
