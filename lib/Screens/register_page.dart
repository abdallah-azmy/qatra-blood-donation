import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'first_page.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../user_model.dart';
import 'add_doner_to_bank.dart';

import 'dart:io';
import 'package:location/location.dart' as lo;

GlobalKey<ScaffoldState> _scafold = new GlobalKey<ScaffoldState>();

final _fireStore = Firestore.instance;
final _auth = FirebaseAuth.instance;
User _user;

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _confirmController = new TextEditingController();
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();
  final TextEditingController _nameController = new TextEditingController();
  final TextEditingController _addressController = new TextEditingController();

  bool _locationLoading = false;

  String name;
  String email;
  String password;
  String confirmPassword;
  String phoneNumber;
  String address;

  var _fasila = [
    'حدد فصيلتك',
    'AB+',
    "AB-",
    "A+",
    "A-",
    "B+",
    "B-",
    "O+",
    "O-",
    "لا اعرف"
  ];
  var _currentFasilaSelected = 'حدد فصيلتك';

  bool showSpinner = false;

  final _formKey = GlobalKey<FormState>();

//  double longitude;
//  double latitude;
//  var city;
//  var government;

  var _myLocation;

//  Future haa() async {
//
//    Location location = new Location();
//    LocationData myLocation = await location.getLocation();
//    bool _serviceEnabled;
//    PermissionStatus _permissionGranted;
//    setState(() {
//      _myLocation = myLocation ;
//    });
//
//  }
//  Future<Map<String, double>> _getLocation() async {
////var currentLocation = <String, double>{};
//    LocationData myLocation
//    Map<String,double> currentLocation;
//    try {
//      currentLocation = await location.getLocation();
//    } catch (e) {
//      currentLocation = null;
//    }
//    setState(() {
//      userLocation = currentLocation;
//    });
//    return currentLocation;
//
//
//
//  }

  @override
  void initState() {
//    haa();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            key: _scafold,
              backgroundColor: Colors.white,
              body: ModalProgressHUD(
                inAsyncCall: showSpinner,
                child: Center(
                    child: Form(
                  key: _formKey,
                  child: ListView(
                      shrinkWrap: true,
                      padding: EdgeInsets.all(15.0),
                      children: <Widget>[
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                            padding: EdgeInsets.only(
                                top: 5.0, right: 20.0, left: 20.0, bottom: 10),
                            child: new Column(children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(bottom: 20.00),
                                child: Image.asset("assets/blood.jpg"),
                              ),
                              Container(
                                child: new Column(
                                  children: <Widget>[
                                    Container(
                                      child: new TextFormField(
                                        validator: (text) {
                                          if (text.isEmpty) {
                                            return "برجاء كتابة الاسم";
                                          }
                                          if (text.length > 40) {
                                            return "الاسم طويل جدا";
                                          }
                                          if (text.trim() == "") {
                                            return "لا يجب ان يكون الاسم كله مسافات";
                                          }

                                          if (text.length < 2) {
                                            return "الاسم قصير جدا";
                                          }
                                        },
                                        textAlign: TextAlign.center,
                                        controller: _nameController,
                                        onChanged: (text) {
                                          setState(() {
                                            name = text;
                                          });
                                        },
                                        decoration: InputDecoration(
                                            labelText: 'الاسم',
                                            labelStyle: TextStyle(
                                              fontFamily: 'Tajawal',
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            ),
                                            prefixIcon:
                                                Icon(Icons.account_circle)),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(top: 17),
                                      child: new TextFormField(
                                        validator: (text) {
                                          if (text.isEmpty) {
                                            return "برجاء كتابة البريد الالكتروني";
                                          }
                                          if (text.length > 50) {
                                            return "البريد الالكتروني طويل جدا";
                                          }
                                          if (text.contains(" ")) {
                                            return "لا يجب ان توجد مسافات في البريد الالكتروني";
                                          }
                                          if (!text.contains("@")) {
                                            return "البريد الالكتروني غير صحيح";
                                          }
                                          if (!text.contains(".")) {
                                            return "البريد الالكتروني غير صحيح";
                                          }
                                          if (text.length < 2) {
                                            return "البريد الالكتروني قصير جدا";
                                          }
                                        },
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        textAlign: TextAlign.center,
                                        controller: _emailController,
                                        onChanged: (text) {
                                          setState(() {
                                            email = text;
                                          });
                                        },
                                        decoration: InputDecoration(
                                            labelText: 'البريد الالكتروني',
                                            labelStyle: TextStyle(
                                              fontFamily: 'Tajawal',
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
                                          if (text.contains(" ")) {
                                            return "لا يجب ان توجد مسافات في كلمة المرور";
                                          }

                                          if (text.length <= 5) {
                                            return "كلمة المرور يجب ان لا تقل عن 6 حروف";
                                          }
                                        },
                                        textAlign: TextAlign.center,
                                        controller: _passwordController,
                                        onChanged: (text) {
                                          setState(() {
                                            password = text;
                                          });
                                        },
                                        decoration: new InputDecoration(
                                          prefixIcon: Icon(Icons.lock_outline),
                                          labelText: 'كلمة المرور',
                                          labelStyle: TextStyle(
                                            fontFamily: 'Tajawal',
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                        ),
                                        obscureText: true,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                child: new Column(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.only(top: 17),
                                      child: new TextFormField(
                                        validator: (text) {
                                          if (text.isEmpty) {
                                            return "برجاء كتابة تاكيد كلمة المرور";
                                          }
                                          if (text != password) {
                                            return "كلمة المرور و تأكيد كلمة المرور غير متطابقان";
                                          }
                                        },
                                        textAlign: TextAlign.center,
                                        controller: _confirmController,
                                        onChanged: (text) {
                                          setState(() {
                                            confirmPassword = text;
                                          });
                                        },
                                        decoration: InputDecoration(
                                            labelText: 'تأكيد كلمة المرور',
                                            labelStyle: TextStyle(
                                              fontFamily: 'Tajawal',
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            ),
                                            prefixIcon: Icon(Icons.lock)),
                                        obscureText: true,
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(top: 17),
                                      child: new TextFormField(
                                        validator: (text) {
                                          if (text.contains(" ")) {
                                            return "لا يجب ان توجد مسافات في رقم التليفون";
                                          }
                                          if (text.isEmpty) {
                                            return "برجاء كتابة رقم التليفون";
                                          }
                                          if (text.length != 11) {
                                            return "رقم التليفون غير صحيح";
                                          }
                                        },
                                        textAlign: TextAlign.center,
                                        keyboardType: TextInputType.number,
                                        controller: null,
                                        onChanged: (text) {
                                          setState(() {
                                            phoneNumber = text;
                                          });
                                        },
                                        decoration: InputDecoration(
                                            labelText: 'رقم التليفون',
                                            labelStyle: TextStyle(
                                              fontFamily: 'Tajawal',
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            ),
                                            prefixIcon:
                                                Icon(Icons.phone_android)),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(top: 17),
                                      child: DropdownButtonFormField<String>(
                                        validator: (value) =>
                                            value == "حدد فصيلتك"
                                                ? 'برجاء اختيار الفصيلة'
                                                : null,
                                        elevation: 10,
                                        isDense: true,
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        20.0)),
                                            prefixIcon: Icon(
                                              Icons.local_hospital,
                                              size: 22,
                                            )),
                                        items: _fasila
                                            .map((String dropDownStringItem) {
                                          return DropdownMenuItem<String>(
                                            value: dropDownStringItem,
                                            child: Center(
                                              child: Text(
                                                dropDownStringItem,
                                                textDirection:
                                                    TextDirection.ltr,
                                                style: TextStyle(
                                                  fontFamily: 'Tajawal',
                                                ),
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (String newValueSelected) {
                                          // Your code to execute, when a menu item is selected from drop down
                                          _onDropDownItemSelected(
                                              newValueSelected);
                                        },
                                        value: _currentFasilaSelected,
                                      ),
                                    ),
                                    Container(
                                        padding: EdgeInsets.only(top: 17),
                                        child: TextFormField(
                                          controller: _addressController,
                                          validator: (text) {
                                            if (text.isEmpty) {
                                              return "برجاء تحديد العنوان";
                                            }
                                            if (text.length > 60) {
                                              return "العنوان طويل جدا";
                                            }
                                            if (text.length < 2) {
                                              return "العنوان قصير جدا";
                                            }
                                          },
                                          textAlign: TextAlign.center,
                                          onChanged: (text) {
                                            setState(() {
                                              address = text;
                                            });
                                          },
                                          decoration: InputDecoration(
                                              labelText: 'العنوان',
                                              labelStyle: TextStyle(
                                                fontFamily: 'Tajawal',
                                              ),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                              ),
                                              icon: _locationLoading
                                                  ? Image.asset(
                                                      "assets/loading.gif",
                                                      height: 47.0,
                                                      width: 47.0,
                                                    )
                                                  : InkWell(
                                                      onTap: () {
                                                        getLocation();

//
                                                      },
                                                      child: Column(
                                                        children: <Widget>[
                                                          Icon(
                                                            Icons.location_on,
                                                            size: 40,
                                                            color: Colors.blue,
                                                          ),
                                                          SizedBox(
                                                            height: 2,
                                                          ),
                                                          Text(
                                                            "لتحديد المكان",
                                                            style: TextStyle(
                                                              fontSize: 10,
                                                              color:
                                                                  Colors.blue,
                                                              fontFamily:
                                                                  'Tajawal',
                                                            ),
                                                          )
                                                        ],
                                                      ))),
                                        )),
                                    Container(
                                      padding: EdgeInsets.only(top: 13),
                                      child: SizedBox(
                                        width: 300,
                                        height: 37,
                                        child: RaisedButton(
                                          child: new Text(
                                            'إنشاء حساب',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Tajawal',
                                            ),
                                          ),
                                          onPressed: () async {
                                            _formKey.currentState.validate()
                                                ? creatUser()
                                                : print("not valid");
                                          },
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          color: Colors.red[900],
                                        ),
                                      ),
                                    ),
                                    new FlatButton(
                                      child: new Text(
                                        'لديك حساب ؟ سجل دخولك من هنا .',
                                        style: TextStyle(
                                          fontFamily: 'Tajawal',
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                ),
                              )
                            ]))
                      ]),
                )),
              )),
        ),
      )
    ;
  }

  getLocationPermission() async {
    final lo.Location location = lo.Location();
    bool _serviceEnabled;
    lo.PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == lo.PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != lo.PermissionStatus.granted) {
        return;
      }
    }
  }

  void getLocation() async {
    getLocationPermission();
    setState(() {
      _locationLoading = true;
    });

    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.lowest);

    List<Placemark> p = await geolocator.placemarkFromCoordinates(
        position.latitude, position.longitude);
    Placemark place = p[0];
    print("${place.locality}, ${place.administrativeArea}, ${place.country}");

    _addressController.text = "${place.administrativeArea}--${place.locality}";

    setState(() {
      address = _addressController.text;
    });

    setState(() {
      _locationLoading = false;
    });
  }

  userData() async {
    _fireStore.collection("UserData").add({
      'name': name,
      'email': email,
      'phone': phoneNumber,
      'fasila': _currentFasilaSelected,
    });
  }

  creatUser() async {
    setState(() {
      showSpinner = true;
    });
    FirebaseUser firebaseUser;

    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print("Connected to Mobile Network");

        try {
          final newUser = await _auth.createUserWithEmailAndPassword(
              email: email, password: password);

          firebaseUser = await _auth.currentUser();

          var now = new DateTime.now();
          _user = User(
              uid: firebaseUser.uid,
              email: firebaseUser.email,
              displayName: name,
              phone: phoneNumber,
              fasila: _currentFasilaSelected,
              address: address,
              date: now,
              dateOfDonation: "----");
          await _fireStore
              .collection('users')
              .document(firebaseUser.uid)
              .setData(_user.toMap(_user));

          if (newUser != null) {
            setState(() {
              showSpinner = false;
            });
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => FirstPage()),
                (Route<dynamic> route) => route is FirstPage);
          } else {
            var error = "حدث خطأ اثناء العملية !";
            creatAlertDialog(context, error);
          }
        } catch (e) {
          setState(() {
            showSpinner = false;
          });
          var errorSigningIn;
          if (Platform.isAndroid) {
            switch (e.message) {
              case 'There is no user record corresponding to this identifier. The user may have been deleted.':
                errorSigningIn =
                    "لا يوجد مستخدم بهذه المعلومات , قد يكون هناك خطأ في البريد الالكتروني او كلمة المرور .";
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
                errorSigningIn =
                '${e.message}';
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
                errorSigningIn =
                '${e.message}';
            }
          }

          showNotification(errorSigningIn, _scafold);

          print(e);
        }
        setState(() {
          showSpinner = false;
        });
      }
    } on SocketException catch (_) {
      String invalid = "لا يوجد اتصال بشبكة الانترنت !";
      print(invalid);
      setState(() {
        showSpinner = false;
      });
      showNotification(invalid, _scafold);

    }
  }

  void _onDropDownItemSelected(String newValueSelected) {
    setState(() {
      _currentFasilaSelected = newValueSelected;
    });
  }
}
showNotification(msg, _scafold) {
  _scafold.currentState.showSnackBar(
    SnackBar(
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          "$msg",textAlign: TextAlign.center,
          style: TextStyle(fontFamily: "Tajawal", fontSize: 18),
        ),
      ),
      backgroundColor: Colors.black87.withOpacity(.8),
      duration: Duration(seconds: 4),
    ),
  );
}