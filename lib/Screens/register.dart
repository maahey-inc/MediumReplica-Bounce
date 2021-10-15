import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:mediumreplica/Services/auth.dart';
import 'package:mediumreplica/Services/loading.dart';
import 'package:mediumreplica/Shared%20Prefrences/theme_manager.dart';
import 'package:mediumreplica/Widgets/bottom_navbar.dart';
import 'package:mediumreplica/Widgets/or_divider.dart';
import 'package:mediumreplica/Widgets/socialLogin.dart';
import 'package:mediumreplica/Screens/login.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  GlobalKey<FormState> formKeyR = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController pass2Controller = TextEditingController();

  final AuthService auth = AuthService();

  bool loading = false;

  String name = '';
  String email = '';
  String password = '';
  String rePassword = '';
  String error = '';

  bool _obscureText = true;
  bool _obscureText2 = true;

  Icon eye = Icon(Icons.visibility_off);
  Icon eye2 = Icon(Icons.visibility_off);
  Color eyeColor = Colors.grey;
  Color eye2Color = Colors.grey;

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
                      'Join Us',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  height: size.height * 0.45,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 0),
                        child: Text(
                          'Sign up with Email',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Form(
                        key: formKeyR,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              height: size.height * 0.08,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: TextFormField(
                                  controller: nameController,
                                  onChanged: (val) {
                                    setState(() => name = val);
                                  },
                                  keyboardType: TextInputType.name,
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.person,
                                        color:
                                            Theme.of(context).iconTheme.color,
                                      ),
                                      labelText: "Name"),
                                  validator: ValidationBuilder()
                                      .minLength(2)
                                      .maxLength(60)
                                      .build(),
                                ),
                              ),
                            ),
                            Container(
                              height: size.height * 0.08,
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
                              height: size.height * 0.08,
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
                                        child: Icon(eye.icon, color: eyeColor),
                                      ),
                                      prefixIcon: Icon(Icons.lock,
                                          color: Theme.of(context)
                                              .iconTheme
                                              .color),
                                      labelText: "Password"),
                                  validator: ValidationBuilder()
                                      .minLength(6)
                                      .maxLength(15)
                                      .build(),
                                ),
                              ),
                            ),
                            Container(
                              height: size.height * 0.08,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: TextFormField(
                                  controller: pass2Controller,
                                  onChanged: (val) {
                                    setState(() => rePassword = val);
                                  },
                                  keyboardType: TextInputType.text,
                                  obscureText: _obscureText2,
                                  decoration: InputDecoration(
                                      suffixIcon: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _obscureText2 = !_obscureText2;
                                            _obscureText2 == true
                                                ? eye2 =
                                                    Icon(Icons.visibility_off)
                                                : eye2 = Icon(Icons.visibility);
                                            _obscureText2 == true
                                                ? eye2Color = Colors.grey
                                                : eye2Color = Theme.of(context)
                                                    .iconTheme
                                                    .color!;
                                          });
                                        },
                                        child: Icon(
                                          eye2.icon,
                                          color: eye2Color,
                                        ),
                                      ),
                                      prefixIcon: Icon(
                                        Icons.lock,
                                        color:
                                            Theme.of(context).iconTheme.color,
                                      ),
                                      labelText: "Confirm Password"),
                                  validator: ValidationBuilder()
                                      .minLength(6)
                                      .maxLength(15)
                                      .build(),
                                ),
                              ),
                            ),
                            Container(
                              height: size.height * 0.01,
                            ),
                            GestureDetector(
                              onTap: () async {
                                if (passController.value ==
                                    pass2Controller.value) {
                                  if (formKeyR.currentState!.validate()) {
                                    setState(() => loading = true);
                                    dynamic result =
                                        await auth.registerWithEmailandPassword(
                                            email, password, name);

                                    if (result == null) {
                                      setState(() {
                                        loading = false;
                                        error = 'Please Enter a valid email';
                                      });
                                    } else {
                                      setState(() {
                                        loading = false;
                                      });
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  HomeScreen()));
                                    }
                                  }
                                } else {
                                  setState(() {
                                    error = "Password is not same!";
                                  });
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
                                    'Sign up',
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
                // Container(
                //   height: size.height * 0.1,
                //   child: Center(
                //     child: OrDivider(
                //       Theme.of(context).brightness == Brightness.light
                //           ? Colors.black
                //           : Colors.white,
                //     ),
                //   ),
                // ),
                // Container(
                //   height: size.height * 0.05,
                //   child: Text('Sign up with'),
                // ),
                // Container(
                //   height: size.height * 0.05,
                //   // color: Colors.red,
                //   child: SocialLogin(),
                // ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  child: Container(
                    height: size.height * 0.1,
                    child: Center(
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Already have an account?  ",
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
                              text: 'Sign In',
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
              ],
            ),
          );
  }
}
