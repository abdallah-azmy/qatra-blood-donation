import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../appBar_widget.dart';
import '../user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:io';

creatAlertDialog(BuildContext context, text) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text(
            "Warning",
            style: TextStyle(color: Colors.red[900], fontSize: 24),
          ),
          elevation: 10,
          content: Text("$text"),
        );
      });
}

class AddDonerToBank extends StatefulWidget {
  final city;

  const AddDonerToBank({Key key, this.city}) : super(key: key);

  @override
  _AddDonerToBankState createState() => _AddDonerToBankState();
}

class _AddDonerToBankState extends State<AddDonerToBank> {
  final _fireStore = Firestore.instance;
  User _user;
  var name;
  var fasila;
  var city;
  var phone;
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  var _currentFasilaSelected = 'حدد الفصيلة';
  var _fasila = [
    'حدد الفصيلة',
    'AB+',
    "AB-",
    "A+",
    "A-",
    "B+",
    "B-",
    "O+",
    "O-"
  ];

  void _onDropDownItemSelected(String newValueSelected) {
    setState(() {
      _currentFasilaSelected = newValueSelected;
    });
  }

  validation() {
    _formKey.currentState.validate() ? updataDataOfUser() : print("not valid");
  }

  updataDataOfUser() async {
    setState(() {
      isLoading = true;
    });

    var now = new DateTime.now();

    setState(() {
      _user = User(
          uid: "----",
          email: "----",
          displayName: name,
          phone: phone,
          fasila: _currentFasilaSelected,
          address: city,
          date: now,
          dateOfDonation: "----");
    });

    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print("Connected to Mobile Network");

        Navigator.pop(context);

        setState(() {
          isLoading = false;
        });

        await _fireStore
            .collection('bank')
            .document(widget.city)
            .collection('doners')
            .document(now.toString())
            .setData(_user.toMap(_user));
      }
    } on SocketException catch (_) {
      String invalid = "Unable to connect. Please Check Internet Connection";
      print(invalid);
      setState(() {
        isLoading = true;
      });

      WidgetsBinding.instance.addPostFrameCallback((_) {
        EasyLoading.showError('لا يوجد اتصال بالانترنت');
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterEasyLoading(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            appBar: WaveAppBar(
              title: "أضف متبرع الي بنك الدم",
              backGroundColor: Colors.white,
              leftIcon: null,
              onPressedLeft: null,
              directionOfRightIcon: TextDirection.rtl,
              onPressedRight: null,
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
            body: Center(
              child: Form(
                key: _formKey,
                child: ListView(
                  padding: EdgeInsets.all(15),
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: DropdownButtonFormField<String>(
                        validator: (value) => value == "حدد الفصيلة"
                            ? 'برجاء اختيار الفصيلة'
                            : null,
                        elevation: 10,
                        isDense: true,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            prefixIcon: Icon(
                              Icons.local_hospital,
                              size: 22,
                            )),
                        items: _fasila.map((String dropDownStringItem) {
                          return DropdownMenuItem<String>(
                            value: dropDownStringItem,
                            child: Center(
                              child: Text(
                                dropDownStringItem,
                                textDirection: TextDirection.ltr,
                                style: TextStyle(
                                  fontFamily: 'Tajawal',
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (String newValueSelected) {
                          // Your code to execute, when a menu item is selected from drop down
                          _onDropDownItemSelected(newValueSelected);
                        },
                        value: _currentFasilaSelected,
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Container(
                      child: new TextFormField(
                        validator: (text) {
                          if (text.isEmpty) {
                            return "برجاء كتابة الاسم";
                          }
                          if (text.length > 40) {
                            return "الاسم طويل جدا";
                          }
                          if (text.length < 2) {
                            return "الاسم قصير جدا";
                          }
                        },
                        textAlign: TextAlign.center,
                        controller: null,
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
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            prefixIcon: Icon(Icons.account_circle)),
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10),
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
                            phone = text;
                          });
                        },
                        decoration: InputDecoration(
                            labelText: 'رقم التليفون',
                            labelStyle: TextStyle(
                              fontFamily: 'Tajawal',
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            prefixIcon: Icon(Icons.phone_android)),
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Container(
                        padding: EdgeInsets.only(top: 10),
                        child: TextFormField(
                          controller: null,
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
                              city = text;
                            });
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.add_location),
                            labelText: 'المدينة',
                            labelStyle: TextStyle(
                              fontFamily: 'Tajawal',
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        )),
                    SizedBox(
                      height: 8,
                    ),
                    RaisedButton(
                      child: Text(
                        'حفظ',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Tajawal',
                            fontSize: 20),
                      ),
                      onPressed: isLoading
                          ? null
                          : () {
                              validation();
                            },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      color: Colors.green,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
