import 'package:RadioWave/screen/loginPage.dart';
import 'package:RadioWave/screen/radioScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:RadioWave/services/auth.dart';
import 'package:RadioWave/style/app_style.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  bool isEmailValid = false;
  bool isPasswordValid = false;
  bool isPasswordVerif = false;
  String? textError = null;
  String? passwordError = null;
  String? passwordVerifError = null;
  bool _obscureText = true;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _passwordVerifController = TextEditingController();

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
        title: Row(
          children: [
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
                      ///////// email
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
//////////////////////// password
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
                            if (value == null || value.isEmpty) {
                              isPasswordValid = false;
                              isPasswordVerif = false;
                              passwordError = null;
                              passwordVerifError = null;
                            } else if (value.length < 5) {
                              isPasswordValid = false;
                              passwordError = "at least 5 caracters";
                              isPasswordVerif = false;
                              passwordVerifError = null;
                            } else {
                              isPasswordValid = true;
                              passwordError = null;
                              if (_passwordVerifController.text != null &&
                                  _passwordVerifController.text.isNotEmpty &&
                                  _passwordVerifController.text.length > 0) {
                                if (value == _passwordVerifController.text) {
                                  isPasswordVerif = true;
                                  passwordVerifError = null;
                                } else {
                                  isPasswordVerif = false;
                                  passwordVerifError = "verify password";
                                }
                              } else {
                                isPasswordVerif = false;
                                passwordVerifError = null;
                              }
                            }
                          });
                        },
                      ),

/////////// verif
                      TextFormField(
                        obscureText: _obscureText,
                        style: TextStyle(color: AppStyle.bgColor),
                        decoration: InputDecoration(
                          errorText: passwordVerifError,
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
                          labelText: 'Confirm password',
                          labelStyle: TextStyle(color: AppStyle.accentColor),
                          hintText: 'Confirm password',
                          hintStyle: AppStyle.mainContent3,

                          //textStyle,
                        ),
                        controller: _passwordVerifController,
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Confirm your password';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            if (_passwordController.text == null ||
                                _passwordController.text.isEmpty ||
                                _passwordController.text.length < 5) {
                              isPasswordVerif = false;
                              passwordVerifError = null;
                            } else if (value == null ||
                                value.isEmpty ||
                                value.length < 5) {
                              isPasswordVerif = false;
                              passwordVerifError = null;
                            } else {
                              if (isPasswordValid == false) {
                                isPasswordVerif = false;
                                passwordVerifError = null;
                              } else if (value == _passwordController.text) {
                                isPasswordVerif = true;
                                passwordVerifError = null;
                              } else {
                                isPasswordVerif = false;
                                passwordVerifError = "verify password";
                              }
                            }
                          });
                        },
                      ),
                      SizedBox(height: 16),
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
                            color: isEmailValid &&
                                    isPasswordValid &&
                                    isPasswordVerif
                                ? AppStyle.accentColor
                                : Colors.blueGrey,
                            borderRadius: BorderRadius.circular(20)),
                        child: ElevatedButton(
                          onPressed: isEmailValid &&
                                  isPasswordValid &&
                                  isPasswordVerif
                              ? () async {
                                  try {
                                    User? user = await AuthService()
                                        .registerWithEmailAndPassword(
                                            _emailController.text,
                                            _passwordController.text);
                                    print(
                                        "héooo ${_emailController.text}  ${_passwordController.text}");
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => LoginPage()));
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
                          child: Text('Sign Up'),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.0),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    // TODO: Navigate to Forgot Password screen
                  },
                  child: Text(
                    'Already a User? Create Account',
                    style: TextStyle(
                      color: AppStyle.bgColor,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}

//TODO
bool isValidPassword(String password) {
  if (password == null) return false;

  if (password.length < 8) {
    // Password must be at least 8 characters long
    return false;
  }
  if (!password.contains(RegExp(r'[A-Z]'))) {
    // Password must contain at least one uppercase letter
    return false;
  }
  if (!password.contains(RegExp(r'[a-z]'))) {
    // Password must contain at least one lowercase letter
    return false;
  }
  if (!password.contains(RegExp(r'[0-9]'))) {
    // Password must contain at least one digit
    return false;
  }
  if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
    // Password must contain at least one special character
    return false;
  }
  return true;
}
