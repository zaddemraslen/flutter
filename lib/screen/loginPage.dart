import 'package:RadioWave/screen/radioScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:RadioWave/screen/signUpScreen.dart';
import 'package:RadioWave/services/auth.dart';
import 'package:RadioWave/style/app_style.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  bool isEmailValid = false;
  bool isPasswordValid = false;
  String? textError = null;
  String? passwordError = null;
  bool _obscureText = true;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.mainColor,
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.exit_to_app),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Center(child: Text("Exit?")),
                  actions: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          child: Text("No"),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        ElevatedButton(
                          child: Text("Yes"),
                          onPressed: () {
                            Navigator.pop(context);
                            SystemNavigator.pop();
                          },
                        ),
                      ],
                    ),
                  ],
                );
              },
            );
          },
        ),
        title: Row(
          children: [
            SizedBox(width: 55),
            Image.asset(
              'assets/utilities/RadioWaveLogo.png',
              height: 30,
            ),
            SizedBox(width: 10),
            Text("FireNotes"),
          ],
        ),
        centerTitle: true,
        backgroundColor: AppStyle.accentColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(height: 80.0),
                Center(
                  child: Container(
                    height: 150.0,
                    width: 190.0,
                    padding: EdgeInsets.only(top: 40),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(200),
                    ),
                    child: Center(
                      child: Image.asset(
                        'assets/utilities/RadioWaveLogo.png',
                        height: 200.0,
                        scale: 1.5,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50.0,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        style: TextStyle(color: AppStyle.bgColor),
                        decoration: InputDecoration(
                          errorText: textError,
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: AppStyle.accentColor),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: AppStyle.accentColor2),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: AppStyle.accentColor2),
                          ),
                          labelText: 'Email',
                          labelStyle: TextStyle(color: AppStyle.accentColor),
                          hintText: 'person@gmail.com',
                          hintStyle: AppStyle.mainContent3,
                          //textStyle,
                        ),
                        controller: _emailController,
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            passwordError = null;
                            if (value == null || value.isEmpty) {
                              isEmailValid = false;
                              textError = null;
                            } else {
                              bool test = false;
                              // Regular expression pattern for email address
                              final pattern =
                                  r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
                              // Create a RegExp object from the pattern
                              final regExp = RegExp(pattern);
                              // Check if the email matches the pattern
                              isEmailValid = regExp.hasMatch(value);
                              isEmailValid == true
                                  ? textError = null
                                  : textError = "Invalid email format";
                            }
                          });
                        },
                      ),
                      TextFormField(
                        obscureText: _obscureText,
                        style: TextStyle(color: AppStyle.bgColor),
                        decoration: InputDecoration(
                          errorText: passwordError,
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: AppStyle.accentColor),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: AppStyle.accentColor2),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: AppStyle.accentColor2),
                          ),
                          labelText: 'Password',
                          labelStyle: TextStyle(color: AppStyle.accentColor),
                          hintText: 'type your password',
                          hintStyle: AppStyle.mainContent3,
                          suffixIcon: IconButton(
                            icon: Icon(
                                _obscureText
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: AppStyle.accentColor2),
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                          ),
                          //textStyle,
                        ),
                        controller: _passwordController,
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            textError = null;
                            passwordError = null;
                            if (value == null || value.isEmpty)
                              isPasswordValid = false;
                            else
                              isPasswordValid = true;
                          });
                        },
                      ),
                      SizedBox(height: 78.0),
                      SizedBox(height: 10.0),
                      GestureDetector(
                        onTap: () {
                          // TODO: Navigate to Forgot Password screen
                        },
                        child: Text(
                          'Forgot Password',
                          style: TextStyle(
                            color: AppStyle.bgColor,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Container(
                        height: 50,
                        width: 250,
                        decoration: BoxDecoration(
                            color: isEmailValid && isPasswordValid
                                ? AppStyle.accentColor
                                : Colors.blueGrey,
                            borderRadius: BorderRadius.circular(20)),
                        child: ElevatedButton(
                          onPressed: isEmailValid && isPasswordValid
                              ? () async {
                                  try {
                                    User? user = await AuthService()
                                        .signInWithEmailAndPassword(
                                            _emailController.text,
                                            _passwordController.text);

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => RadioScreen()),
                                    );
                                    // TODO: Navigate to Forgot Password screen

                                    // handle successful sign in
                                  } on FirebaseAuthException catch (e) {
                                    if (e.code == 'user-not-found') {
                                      setState(() {
                                        textError = "No such user";
                                      });
                                    } else if (e.code == 'wrong-password') {
                                      passwordError = 'Wrong password';
                                    }
                                  } catch (e) {
                                    print("what ?" + e.toString());
                                  }
                                }
                              : null,
                          child: Text('Sign In'),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.0),
                GestureDetector(
                  child: Text(
                    'New User? Create Account',
                    style: TextStyle(
                      color: AppStyle.bgColor,
                      fontSize: 15,
                    ),
                  ),
                  onTap: (() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignUpScreen()));
                  }),
                )
              ],
            )),
      ),
    );
  }
}
