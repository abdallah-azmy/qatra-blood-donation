import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'register_page.dart';
import 'first_page.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'add_doner_to_bank.dart';
import 'dart:io';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  bool _showPassword = false;
  bool showSpinner = false;
  final _loginFormKey = GlobalKey<FormState>();
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: ModalProgressHUD(
            inAsyncCall: showSpinner,
            child: Center(
              child: ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.all(23.0),
                  children: <Widget>[
                    SizedBox(
                      height: 28,
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: 5.0, right: 20.0, left: 20.0, bottom: 30),
                      child: new Column(
                        children: <Widget>[
                          Form(
                            key: _loginFormKey,
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(bottom: 20.00),
                                  child: Image.asset(
                                    "assets/fainallogo.png",
                                    height: 140,
                                    width: 150,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 17),
                                  child: new TextFormField(
                                    validator: (text) {
                                      if (text.isEmpty) {
                                        return "برجاء كتابة البريد الالكتروني";
                                      }
                                      if (text.length < 2) {
                                        return "البريد الالكتروني قصير جدا";
                                      }
                                    },
                                    onChanged: (text) {
                                      setState(() {
                                        email = text;
                                      });
                                    },
                                    keyboardType: TextInputType.emailAddress,
                                    textAlign: TextAlign.center,
                                    controller: _emailController,
                                    decoration: InputDecoration(
                                        labelText: 'البريد الالكتروني',
                                        labelStyle: TextStyle(
                                          fontFamily: 'Tajawal',
                                        ),
                                        hintStyle: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 16.0,
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        prefixIcon: Icon(Icons.email)),
                                  ),
                                ),
                                new Container(
                                  padding: EdgeInsets.only(top: 17),
                                  child: new TextFormField(
                                    validator: (text) {
                                      if (text.isEmpty) {
                                        return "برجاء كتابة كلمة المرور";
                                      }
                                      if (text.length <= 5) {
                                        return "كلمة المرور يجب ان لا تقل عن 6 حروف";
                                      }
                                    },
                                    onChanged: (text) {
                                      setState(() {
                                        password = text;
                                      });
                                    },
                                    textAlign: TextAlign.center,
                                    controller: _passwordController,
                                    obscureText: !this._showPassword,
                                    decoration: new InputDecoration(
                                      prefixIcon: Icon(Icons.lock_outline),
                                      labelText: 'كلمة المرور',
                                      labelStyle: TextStyle(
                                        fontFamily: 'Tajawal',
                                      ),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          Icons.remove_red_eye,
                                          color: this._showPassword
                                              ? Colors.blue
                                              : Colors.grey,
                                        ),
                                        onPressed: () {
                                          setState(() => this._showPassword =
                                              !this._showPassword);
                                        },
                                      ),
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 16.0,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 15),
                                  child: new Column(
                                    children: <Widget>[
                                      SizedBox(height: 10.0),
                                      Container(
                                        padding:
                                            EdgeInsets.only(top: 2, bottom: 15),
                                        child: SizedBox(
                                          width: 300,
                                          height: 37,
                                          child: RaisedButton(
                                            child: Text(
                                              'تسجيل الدخول',
                                              style: TextStyle(
                                                fontFamily: 'Tajawal',
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            onPressed: () async {
                                              _loginFormKey.currentState
                                                      .validate()
                                                  ? signIn()
                                                  : print("not valid");
                                            },
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            color: Colors.red[900],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(top: 2),
                                        child: SizedBox(
                                          width: 300,
                                          height: 37,
                                          child: RaisedButton(
                                            child: Text(
                                              'إنشاء حساب',
                                              style: TextStyle(
                                                fontFamily: 'Tajawal',
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  new MaterialPageRoute(
                                                      builder: (context) =>
                                                          new RegisterPage()));
                                            },
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            color: Colors.green,
                                          ),
                                        ),
                                      ),
                                      new FlatButton(
                                        child: new Text(
                                          'نسيت كلمة المرور ؟',
                                          style: TextStyle(
                                            fontFamily: 'Tajawal',
                                          ),
                                        ),
                                        onPressed: () {
                                          forgotPassword(context);
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  var forgottenEmail;

  forgotPassword(BuildContext contex) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30.0))),
            title: Center(
              child: Text(
                "ارسال كلمة المرور لبريدك الالكتروني",
                style: TextStyle(
                  fontFamily: 'Tajawal',
                  color: Colors.red[900],
                  fontSize: 15,
                ),
              ),
            ),
            elevation: 10,
            content: TextField(
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              onChanged: (text) {
                forgottenEmail = text;
              },
              decoration: InputDecoration(
                labelText: "البريد الالكتروني",
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 16.0,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
            actions: <Widget>[
              RaisedButton(
                child: Text(
                  'ارسال',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat'),
                ),
                onPressed: () {
                  sendPassReset(forgottenEmail);

                  Navigator.pop(context);
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: Colors.green,
              ),
            ],
          );
        });
  }

  Future sendPassReset(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return null;
    } catch (e) {
      return e;
    }
  }

  signIn() async {
    setState(() {
      showSpinner = true;
    });

    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print("Connected to Mobile Network");

        try {
          final user = await _auth.signInWithEmailAndPassword(
              email: email, password: password);
          if (user != null) {
            Navigator.pushReplacement(
                context,
                new MaterialPageRoute(
                    builder: (BuildContext context) => FirstPage()));
          }
          setState(() {
            showSpinner = false;
          });
        } catch (e) {
          setState(() {
            showSpinner = false;
          });

          creatAlertDialog(context, e);
          print(e);
        }
      }
    } on SocketException catch (_) {
      String invalid = "لا يوجد اتصال بشبكة الانترنت !";
      print(invalid);
      setState(() {
        showSpinner = false;
      });
      creatAlertDialog(context, invalid);
    }
  }
}
