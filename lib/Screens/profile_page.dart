import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../appBar_widget.dart';
import '../user_model.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:io';
import 'package:intl/intl.dart' as intl;

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User user;
  final _auth = FirebaseAuth.instance;
  final _fireStore = Firestore.instance;
  FirebaseUser loggedInUser;
  var dateOfDonation = "---";
  var _newAddress;
  var newAddress = "---";
  var newFasila = "---";
  var _newFasila;
  final _addressFormKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  var myFormat = intl.DateFormat('d-MM-yyyy');

  makeUserObject() async {
    FirebaseUser _currentUser = await getCurrentUser();
    var userdata = await retrieveUserDetails(_currentUser);
    setState(() {
      user = userdata;
    });
  }

  Future<FirebaseUser> getCurrentUser() async {
    return loggedInUser = await _auth.currentUser();
  }

  Future<User> retrieveUserDetails(FirebaseUser user) async {
    DocumentSnapshot _documentSnapshot =
        await _fireStore.collection('users').document(user.uid).get();
    if (_documentSnapshot.data != null) {
      print('there is data ');

      setState(() {
        dateOfDonation = _documentSnapshot.data["dateOfDonation"];
        newAddress = _documentSnapshot.data["address"];
        newFasila = _documentSnapshot.data["fasila"];
      });

      return User.fromMap(_documentSnapshot.data);
    } else {
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    makeUserObject();
    print(user);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: WaveAppBar(
            title: "الصفحة الشخصية",
            backGroundColor: Colors.red[800],
            leftIcon: null,
            onPressedLeft: null,
            onPressedRight: null,
            directionOfRightIcon: TextDirection.ltr,
            rightIcon: null,
          ),
          floatingActionButton: Padding(
              padding: const EdgeInsets.only(right: 20, top: 20),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Stack(
                    children: <Widget>[
                      Image.asset(
                        "assets/drop.png",
                        width: 75,
                        height: 80,
                      ),
                      Positioned(
                        bottom: 18,
                        right: 24,
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                    ],
                  ),
                ),
              )),
          body: SafeArea(
            child: ListView(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      height: 238,
                      color: Colors.red[800],
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          height: 100,
                          margin: EdgeInsets.only(top: 30),
                          child: ClipOval(
                              child: Image.asset(
                            "assets/abcd.jpg",
                            fit: BoxFit.cover,
                            width: 95.0,
                            height: 100.0,
                          )),
                        ),
                        Padding(
                          padding: EdgeInsets.all(4),
                        ),
                        user == null
                            ? Text(
                                "---",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20),
                                textAlign: TextAlign.center,
                              )
                            : Text(
                                user.displayName,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 27),
                                textAlign: TextAlign.center,
                              ),
                        Padding(
                          padding: EdgeInsets.all(2),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: <Widget>[
                              Card(
                                child: Container(
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.all(15),
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.only(left: 5),
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "معلوماتى",
                                          style: TextStyle(
                                            fontFamily: 'Tajawal',
                                            color: Colors.black87,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                      Divider(
                                        color: Colors.black38,
                                      ),
                                      Container(
                                          child: Column(
                                        children: <Widget>[
                                          ListTile(
                                            trailing: InkWell(
                                                onTap: () {
                                                  showCupertinoModalPopup(
                                                      context: context,
                                                      builder: (context) =>
                                                          CupertinoActionSheet(
                                                            title: Text(
                                                              "اختر فصيلة دمك",
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Tajawal',
                                                                fontSize: 22,
                                                                color: Colors
                                                                    .red[900],
                                                              ),
                                                            ),
                                                            actions: <Widget>[
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: <
                                                                    Widget>[
                                                                  CupertinoActionSheetAction(
                                                                    child: Text(
                                                                      "AB+",
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.blue),
                                                                    ),
                                                                    onPressed:
                                                                        () {
                                                                      setState(
                                                                          () {
                                                                        _newFasila =
                                                                            "AB+";
                                                                      });

                                                                      upFasila();

                                                                      Navigator.of(
                                                                              context)
                                                                          .pop(
                                                                              "Cancel");
                                                                    },
                                                                    isDefaultAction:
                                                                        true,
                                                                  ),
                                                                  SizedBox(
                                                                    width: 54,
                                                                  ),
                                                                  CupertinoActionSheetAction(
                                                                    child: Text(
                                                                      "AB-",
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.blue),
                                                                    ),
                                                                    onPressed:
                                                                        () {
                                                                      setState(
                                                                          () {
                                                                        _newFasila =
                                                                            "AB-";
                                                                      });

                                                                      upFasila();
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop(
                                                                              "Cancel");
                                                                    },
                                                                    isDefaultAction:
                                                                        true,
                                                                  ),
                                                                ],
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: <
                                                                    Widget>[
                                                                  CupertinoActionSheetAction(
                                                                    child: Text(
                                                                      "A+",
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.blue),
                                                                    ),
                                                                    onPressed:
                                                                        () {
                                                                      setState(
                                                                          () {
                                                                        _newFasila =
                                                                            "A+";
                                                                      });

                                                                      upFasila();

                                                                      Navigator.of(
                                                                              context)
                                                                          .pop(
                                                                              "Cancel");
                                                                    },
                                                                    isDefaultAction:
                                                                        true,
                                                                  ),
                                                                  SizedBox(
                                                                    width: 65,
                                                                  ),
                                                                  CupertinoActionSheetAction(
                                                                    child: Text(
                                                                      "A-",
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.blue),
                                                                    ),
                                                                    onPressed:
                                                                        () {
                                                                      setState(
                                                                          () {
                                                                        _newFasila =
                                                                            "A-";
                                                                      });

                                                                      upFasila();
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop(
                                                                              "Cancel");
                                                                    },
                                                                    isDefaultAction:
                                                                        true,
                                                                  ),
                                                                ],
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: <
                                                                    Widget>[
                                                                  CupertinoActionSheetAction(
                                                                    child: Text(
                                                                      "B+",
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.blue),
                                                                    ),
                                                                    onPressed:
                                                                        () {
                                                                      setState(
                                                                          () {
                                                                        _newFasila =
                                                                            "B+";
                                                                      });

                                                                      upFasila();

                                                                      Navigator.of(
                                                                              context)
                                                                          .pop(
                                                                              "Cancel");
                                                                    },
                                                                    isDefaultAction:
                                                                        true,
                                                                  ),
                                                                  SizedBox(
                                                                    width: 65,
                                                                  ),
                                                                  CupertinoActionSheetAction(
                                                                    child: Text(
                                                                      "B-",
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.blue),
                                                                    ),
                                                                    onPressed:
                                                                        () {
                                                                      setState(
                                                                          () {
                                                                        _newFasila =
                                                                            "B-";
                                                                      });

                                                                      upFasila();
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop(
                                                                              "Cancel");
                                                                    },
                                                                    isDefaultAction:
                                                                        true,
                                                                  ),
                                                                ],
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: <
                                                                    Widget>[
                                                                  CupertinoActionSheetAction(
                                                                    child: Text(
                                                                      "O+",
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.blue),
                                                                    ),
                                                                    onPressed:
                                                                        () {
                                                                      setState(
                                                                          () {
                                                                        _newFasila =
                                                                            "O+";
                                                                      });

                                                                      upFasila();

                                                                      Navigator.of(
                                                                              context)
                                                                          .pop(
                                                                              "Cancel");
                                                                    },
                                                                    isDefaultAction:
                                                                        true,
                                                                  ),
                                                                  SizedBox(
                                                                    width: 65,
                                                                  ),
                                                                  CupertinoActionSheetAction(
                                                                    child: Text(
                                                                      "O-",
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.blue),
                                                                    ),
                                                                    onPressed:
                                                                        () {
                                                                      setState(
                                                                          () {
                                                                        _newFasila =
                                                                            "O-";
                                                                      });

                                                                      upFasila();
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop(
                                                                              "Cancel");
                                                                    },
                                                                    isDefaultAction:
                                                                        true,
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                            cancelButton:
                                                                CupertinoActionSheetAction(
                                                              child: Text(
                                                                "رجوع",
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Tajawal',
                                                                  fontSize: 19,
                                                                  color: Colors
                                                                      .blue,
                                                                ),
                                                              ),
                                                              onPressed: () =>
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop(
                                                                          "Cancel"),
                                                              isDestructiveAction:
                                                                  true,
                                                            ),
                                                          ));
                                                },
                                                child: Container(
                                                  height: 50,
                                                  width: 50,
                                                  color: Colors.white,
                                                  child: Icon(
                                                    Icons.settings,
                                                    color: Colors.blue,
                                                  ),
                                                )),
                                            leading:
                                                Icon(Icons.accessibility_new),
                                            title: Text("فصيلة الدم :",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: 'Tajawal',
                                                )),
                                            subtitle: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                Text(newFasila,
                                                    textDirection:
                                                        TextDirection.ltr,
                                                    style: TextStyle(
                                                        color: Colors.red[900],
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18)),
                                              ],
                                            ),
                                          ),
                                          ListTile(
                                            leading: Icon(Icons.phone),
                                            title: Text("رقم الهاتف :",
                                                style: TextStyle(
                                                  fontFamily: 'Tajawal',
                                                )),
                                            subtitle: user == null
                                                ? Text(
                                                    "---",
                                                  )
                                                : Text(user.phone,
                                                    style: TextStyle(
                                                        color: Colors.red[900],
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18)),
                                          ),
                                          ListTile(
                                            trailing: InkWell(
                                                onTap: () {
                                                  editAddress(context);
                                                },
                                                child: Container(
                                                  height: 50,
                                                  width: 50,
                                                  color: Colors.white,
                                                  child: Icon(
                                                    Icons.settings,
                                                    color: Colors.blue,
                                                  ),
                                                )),
                                            leading: Icon(Icons.my_location),
                                            title: Text("العنوان :",
                                                style: TextStyle(
                                                  fontFamily: 'Tajawal',
                                                )),
                                            subtitle: Text(newAddress,
                                                style: TextStyle(
                                                    color: Colors.red[900],
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18)),
                                          ),
                                          ListTile(
                                            leading: Icon(Icons.email),
                                            title: Text("البريد الالكتروني :",
                                                style: TextStyle(
                                                  fontFamily: 'Tajawal',
                                                )),
                                            subtitle: user == null
                                                ? Text(
                                                    "---",
                                                  )
                                                : Text(user.email,
                                                    style: TextStyle(
                                                        color: Colors.red[900],
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18)),
                                          ),
                                          ListTile(
                                              leading: Icon(Icons.person),
                                              title: Text("موعد اخر تبرع :",
                                                  style: TextStyle(
                                                    fontFamily: 'Tajawal',
                                                  )),
                                              trailing: InkWell(
                                                  onTap: () {
                                                    editDateOfDonation(context);
                                                  },
                                                  child: Container(
                                                    height: 50,
                                                    width: 50,
                                                    color: Colors.white,
                                                    child: Icon(
                                                      Icons.settings,
                                                      color: Colors.blue,
                                                    ),
                                                  )),
                                              subtitle: Text(dateOfDonation,
                                                  style: TextStyle(
                                                      color: Colors.red[900],
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18))),
                                        ],
                                      ))
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 25,
                              )
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
          )),
    );
  }

  upFasila() async {
    print("in the fn");
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print("Connected to Mobile Network");

        uploadFasila();
      }
    } on SocketException catch (_) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        EasyLoading.showError('لا يوجد اتصال بالانترنت');
      });
    }
    retrieveUserDetails(loggedInUser);
  }

  uploadFasila() async {
    FirebaseUser firebaseUser = await _auth.currentUser();
    await _fireStore
        .collection('users')
        .document(firebaseUser.uid)
        .updateData({'fasila': _newFasila});
  }

  editAddress(BuildContext contex) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              actions: <Widget>[
                RaisedButton(
                  child: Text(
                    'حفظ',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Tajawal',
                    ),
                  ),
                  onPressed: () {
                    print("bbbbbbbbbbbbbbbbbbbbbbbb");
                    upAddress() async {
                      print("in the fn");
                      try {
                        final result =
                            await InternetAddress.lookup('google.com');
                        if (result.isNotEmpty &&
                            result[0].rawAddress.isNotEmpty) {
                          print("Connected to Mobile Network");
                          uploadAddressFB();
                        }
                      } on SocketException catch (_) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          EasyLoading.showError('لا يوجد اتصال بالانترنت');
                        });
                      }
                      print("aaaaaaaaaaaaaaaaa");

                      retrieveUserDetails(loggedInUser);
                      Navigator.pop(context);
                    }

                    _addressFormKey.currentState.validate()
                        ? upAddress()
                        : print("not valid");
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  color: Colors.green,
                ),
              ],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30.0))),
              title: Center(
                child: Text(
                  "تعديل العنوان",
                  style: TextStyle(
                    fontFamily: 'Tajawal',
                    color: Colors.red[900],
                    fontSize: 20,
                  ),
                ),
              ),
              elevation: 10,
              content: Form(
                key: _addressFormKey,
                child: TextFormField(
                  validator: (text) {
                    if (text.isEmpty) {
                      return "برجاء كتابة العنوان";
                    }
                  },
                  textAlign: TextAlign.center,
                  onChanged: (text) {
                    setState(() {
                      _newAddress = text;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: "المحافظة -- المدينة",
                    labelStyle: TextStyle(
                      fontFamily: 'Tajawal',
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
              ));
        });
  }

  uploadAddressFB() async {
    FirebaseUser firebaseUser = await _auth.currentUser();

    await _fireStore
        .collection('users')
        .document(firebaseUser.uid)
        .updateData({'address': _newAddress});
  }

  editDateOfDonation(BuildContext contex) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              actions: <Widget>[
                RaisedButton(
                  child: Text(
                    'حفظ',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Tajawal',
                    ),
                  ),
                  onPressed: () {
                    uploadeTheDate() async {
                      try {
                        final result =
                            await InternetAddress.lookup('google.com');
                        if (result.isNotEmpty &&
                            result[0].rawAddress.isNotEmpty) {
                          print("Connected to Mobile Network");
                          uploadDateOfDonation();
                        }
                      } on SocketException catch (_) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          EasyLoading.showError('لا يوجد اتصال بالانترنت');
                        });
                      }
                    }

                    uploadeTheDate();
                    retrieveUserDetails(loggedInUser);
                    Navigator.pop(context);
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  color: Colors.green,
                ),
              ],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30.0))),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      "تعديل تاريخ اخر تبرع",
                      style: TextStyle(
                        fontFamily: 'Tajawal',
                        color: Colors.red[900],
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
              elevation: 10,
              content: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Text(
                  "التاريخ",
                  style: TextStyle(
                    fontFamily: 'Tajawal',
                    color: Colors.black87,
                    fontSize: 18,
                  ),
                ),
                onPressed: () {
                  Future<Null> _selectDate(BuildContext context) async {
                    final DateTime picked = await showDatePicker(
                        context: context,
                        initialDate: selectedDate,
                        firstDate: DateTime(
                          2020,
                        ),
                        lastDate: DateTime(2101));
                    if (picked != null && picked != selectedDate)
                      setState(() {
                        selectedDate = picked;
                      });
                    uploadDateOfDonation();
                  }

                  _selectDate(context);
                },
              ));
        });
  }

  uploadDateOfDonation() async {
    FirebaseUser firebaseUser = await _auth.currentUser();
    await _fireStore
        .collection('users')
        .document(firebaseUser.uid)
        .updateData({'dateOfDonation': myFormat.format(selectedDate)});
  }
}
