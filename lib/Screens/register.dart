import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:mediumreplica/Widgets/or_divider.dart';
import 'package:mediumreplica/Widgets/socialLogin.dart';
import 'package:mediumreplica/Screens/login.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController pass2Controller = TextEditingController();

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

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: size.height * 0.15,
            // color: Colors.blue,
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
                        height: size.height * 0.08,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: TextFormField(
                            controller: nameController,
                            onChanged: (val) {
                              setState(() => name = val);
                            },
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Theme.of(context).iconTheme.color,
                                ),
                                // border: OutlineInputBorder(),
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
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: TextFormField(
                            controller: emailController,
                            onChanged: (val) {
                              setState(() => email = val);
                            },
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: Theme.of(context).iconTheme.color,
                                ),
                                // border: OutlineInputBorder(),
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
                          padding: const EdgeInsets.symmetric(horizontal: 16),
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
                                          ? eye = Icon(Icons.visibility_off)
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
                                  color: Theme.of(context).iconTheme.color,
                                ),
                                // border: OutlineInputBorder(),
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
                          padding: const EdgeInsets.symmetric(horizontal: 16),
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
                                          ? eye2 = Icon(Icons.visibility_off)
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
                                  color: Theme.of(context).iconTheme.color,
                                ),
                                // border: OutlineInputBorder(),
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
                          if (formKey.currentState!.validate()) {
                            // setState(() => loading = true);
                            //   dynamic result =
                            //       await _auth.signInWithEmailandPassword(
                            //           email, password);
                            //   if (result == null) {
                            //     setState(() {
                            //       loading = false;
                            //       error = "Wrong Email or Password!";
                            //     });
                            //   }
                          }
                        },
                        child: Container(
                          height: size.height * 0.05,
                          width: size.width * 0.7,
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).brightness == Brightness.light
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
            child: Text('Sign up with'),
          ),
          Container(
            height: size.height * 0.05,
            // color: Colors.red,
            child: SocialLogin(),
          ),
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
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? Colors.black
                                  : Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextSpan(
                        text: 'Sign In',
                        style: TextStyle(
                          color:
                              Theme.of(context).brightness == Brightness.light
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
