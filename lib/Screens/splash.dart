import 'package:flutter/material.dart';
import 'onBoarding.dart';
import 'package:shimmer/shimmer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_page.dart';
import 'first_page.dart';
import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var alertMessage = "برجاء التحقق من الاتصال بشبكة الانترنت";
  bool refreshButton = false;


  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
      checkIfLoggedIn();
    } else {
      await prefs.setBool('seen', true);
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.of(context).pushReplacement(
            new MaterialPageRoute(builder: (context) => OnBoardingPage()));
      });
    }
  }

//  checkInternetConnection() async {
//    Future.delayed(const Duration(seconds: 7), () {
//      EasyLoading.dismiss();
//      print('Helllllllllllllllllllllllllllllllllllllllllo, world');
//      creatConnectionAlert(context, alertMessage);
//      setState(() {
//        refreshButton = true;
//      });
//    });
//    var url = 'https://www.google.com/';
//    var response = await http.get(url);
//    print('Response status: ${response.statusCode}');
//
//    if (response.statusCode == 200) {
//      checkIfLoggedIn();
//    } else {
//      creatConnectionAlert(context, alertMessage);
//      print(alertMessage);
//    }
//  }

  checkIfLoggedIn() async {
    Future.delayed(const Duration(seconds: 2, milliseconds: 200), () {
      loggedCheck() async {
        await FirebaseAuth.instance.currentUser() != null
            ? Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => FirstPage()))
            : Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => LoginPage()));
      }

      loggedCheck();
    });
  }


  @override
  void initState() {
    super.initState();
    checkFirstSeen();
  }

  @override
  Widget build(BuildContext context) {
    return FlutterEasyLoading(
      child: Scaffold(
        body: Container(
          color: Colors.white,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Center(
                child: Container(
                  child: Opacity(
                    opacity: 1,
                    child: Shimmer.fromColors(
                      baseColor: Colors.red,
                      highlightColor: Colors.red[900],
                      child: Image.asset(
                        "assets/fainallogo.png",
                        height: 140,
                        width: 150,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 60,
                child: TextLiquidFill(
                  text: 'قطرة دم = حياة',
                  waveColor: Colors.red[900],
                  boxBackgroundColor: Colors.white,
                  textStyle: TextStyle(
                    fontFamily: 'Tajawal',
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                  ),
                  loadDuration: Duration(seconds: 1, milliseconds: 750),
                ),
              ),
              refreshButton == false
                  ? Container()
                  : Positioned(
                bottom: 50,
                child: RaisedButton(
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.refresh,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      Text(
                        'اعادة المحاولة',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  onPressed: () async {
                    EasyLoading.show(status: 'loading...');

//                          checkInternetConnection();
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  color: Colors.red[900],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
