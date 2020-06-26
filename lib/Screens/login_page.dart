import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icandoit/Screens/profile_page.dart';
import '../user_model.dart';
import 'register_page.dart';
import 'first_page.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'add_doner_to_bank.dart';
import 'dart:io';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _fireStore = Firestore.instance;
  String email;
  String password;
  bool _showPassword = false;
  bool showSpinner = false;
  final _loginFormKey = GlobalKey<FormState>();
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();
  GlobalKey<ScaffoldState> _scafold = new GlobalKey<ScaffoldState>();


  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future _signIn() async {
    try {
      GoogleSignIn googleSignIn = GoogleSignIn();
      GoogleSignInAccount account = await googleSignIn.signIn();
      if (account == null) return false;
      AuthResult res = await _auth.signInWithCredential(
          GoogleAuthProvider.getCredential(
              idToken: (await account.authentication).idToken,
              accessToken: (await account.authentication).accessToken));
      print("${res.user} aaaaaaaaaaaaaaaaaaaaaaaaaaaa");

      if (res.additionalUserInfo.isNewUser) {
        setState(() {
          showSpinner = true;
        });
        try {
          final result = await InternetAddress.lookup('google.com');

          if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
            print("Connected to Mobile Network");
            FirebaseUser firebaseUser = await _auth.currentUser();

            var _user = User(
                uid: firebaseUser.uid,
                email: firebaseUser.email,
                displayName: "---",
                phone: "---",
                fasila: "---",
                address: "---",
                date: null,
                dateOfDonation: "---");
            await _fireStore
                .collection('users')
                .document(firebaseUser.uid)
                .setData(_user.toMap(_user));

            setState(() {
              showSpinner = false;
            });
          }
        } on SocketException catch (_) {
          String invalid = "حدث خطأ أثناء اتمام العملية !";
          print(invalid);
          setState(() {
            showSpinner = false;
          });
          showNotification("حدث خطأ أثناء اتمام العملية ", _scafold);
        }

        Navigator.pushReplacement(
            context,
            new MaterialPageRoute(
                builder: (BuildContext context) => FirstPage()));
        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (BuildContext context) => ProfilePage()));

        setState(() {
          showSpinner = false;
        });
      } else {
        Navigator.pushReplacement(
            context,
            new MaterialPageRoute(
                builder: (BuildContext context) => FirstPage()));
      }
    } catch (e) {
      print("${e.toString()}");
      showNotification("${e.toString()}", _scafold);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          key: _scafold,
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
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Divider(
                                        height: 3,
                                        color: Colors.grey,
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(top: 10),
                                        child: SizedBox(
                                          width: 300,
                                          height: 37,
                                          child: RaisedButton(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 5),
                                                  child: Text(
                                                    'Sign in with Google',
                                                    style: TextStyle(
                                                      fontFamily: 'Tajawal',
                                                      fontSize: 20,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 14,
                                                ),
                                                Image.asset(
                                                  "assets/google.png",
                                                  height: 20,
                                                  width: 20,
                                                )
                                              ],
                                            ),
                                            onPressed: () async {
                                              _signIn();
//                                              bool res = await _signIn();
//                                              if (!res) {
//                                                print("not sucess");
//                                              } else {
//                                               ;
//                                              }
                                            },
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            color: Colors.blue,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Divider(
                                        height: 3,
                                        color: Colors.grey,
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
      showNotification("لا يوجد اتصال بالانترنت !", _scafold);
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

          var errorSigningIn = "لقد حدث خطأ في اتمام العملية !";
          if (Platform.isAndroid) {
            switch (e.message) {
              case 'There is no user record corresponding to this identifier. The user may have been deleted.':
                errorSigningIn =
                    "لا يوجد مستخدم بهذه المعلومات , قد يكون هناك خطأ في البريد الالكتروني .";
                break;
              case 'The password is invalid or the user does not have a password.':
                errorSigningIn = "كلمة مرور خاطئة .";
                break;
              case 'A network error (such as timeout, interrupted connection or unreachable host) has occurred.':
                errorSigningIn =
                    "خطأ في الاتصال بشبكة الانترنت , تحقق من اتصالك و حاول مرة اخري .";
                break;
              // ...
              default:
                print('Case ${e.message} is not yet implemented');
            }
          } else if (Platform.isIOS) {
            switch (e.code) {
              case 'Error 17011':
                errorSigningIn =
                    "لا يوجد مستخدم بهذه المعلومات , قد يكون هناك خطأ في البريد الالكتروني او كلمة المرور .";
                break;
              case 'Error 17009':
                errorSigningIn = "كلمة مرور خاطئة .";
                break;
              case 'Error 17020':
                errorSigningIn =
                    "خطأ في الاتصال بشبكة الانترنت , تحقق من اتصالك و حاول مرة اخري .";
                break;
              // ...
              default:
                print('Case ${e.message} is not yet implemented');
            }
          }

          showNotification(errorSigningIn, _scafold);

          print(e);
        }
      }
    } on SocketException catch (_) {
      String invalid = "لا يوجد اتصال بشبكة الانترنت !";
      print(invalid);
      setState(() {
        showSpinner = false;
      });
      showNotification("لا يوجد اتصال بالانترنت !", _scafold);
    }
  }
}

showNotification(msg, _scafold) {
  _scafold.currentState.showSnackBar(
    SnackBar(
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          "$msg",
          textAlign: TextAlign.center,
          style: TextStyle(fontFamily: "Tajawal", fontSize: 18),
        ),
      ),
      backgroundColor: Colors.black87.withOpacity(.8),
      duration: Duration(seconds: 4),
    ),
  );
}
