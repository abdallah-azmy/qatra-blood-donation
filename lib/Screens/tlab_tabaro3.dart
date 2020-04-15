import 'package:flutter/material.dart';
import 'first_page.dart';
import '../location.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geocoder/geocoder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:io';

class TlabTabaro3 extends StatefulWidget {
  @override
  _TalabTabaro3State createState() => _TalabTabaro3State();
}

class _TalabTabaro3State extends State<TlabTabaro3> {
  final _fireStore = Firestore.instance;
  final _auth = FirebaseAuth.instance;

  var _madinaController = TextEditingController();
  var _governmentController = TextEditingController();

  double longitude;
  double latitude;
  var city;
  var government;

  void getLocation() async {
    EasyLoading.show(status: 'loading...');
    Location location = Location();
    await location.getCurrentLocation();
    longitude = location.longitude;
    latitude = location.latitude;

    final coordinates = new Coordinates(latitude, longitude);
    var addresses =
    await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    print(" ${first.locality}");
    print(" ${first.adminArea}");
    city = first.locality;
    government = first.adminArea;

    EasyLoading.dismiss();

    _madinaController.text = city;
    _governmentController.text = government;
  }

  String name;
  String akias;
  String hospital;
  String hospitalAddress;
  String phone;
  String note;

  TextEditingController textFieldController = new TextEditingController();
  final TextEditingController _akias = TextEditingController();

  var _fasilaDropDown = [
    'اي فصيلة',
    'AB+',
    "AB-",
    "A+",
    "A-",
    "B+",
    "B-",
    "O+",
    "O-"
  ];
  String fasila = 'اي فصيلة';

  final _formTlabKey = GlobalKey<FormState>();

  FirebaseUser loggedInUser;
  Future<FirebaseUser> getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        setState(() {
          loggedInUser = user;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  void _onDropDownItemSelected(String newValueSelected) {
    setState(() {
      fasila = newValueSelected;
    });
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return FlutterEasyLoading(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                "طلب تبرع",
                style: TextStyle(fontFamily: 'Tajawal', fontSize: 20),
              ),
              centerTitle: true,
              backgroundColor: Colors.red[900],
            ),
            floatingActionButton: Padding(
                padding: const EdgeInsets.only(right: 20, top: 20),
                child: GestureDetector(onTap: () {
                  Navigator.pop(context);
                },
                  child: Align(alignment: Alignment.bottomRight,
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

                          child: Icon(Icons.arrow_back, color: Colors.white,
                            size: 28,),),
                      ],
                    ),
                  ),
                )),
            body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(top: 20, right: 7, left: 7),
                child: Form(
                  key: _formTlabKey,
                  child: new Column(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.only(
                          top: 14,
                        ),
                        child: DropdownButtonFormField<String>(
                          isDense: true,
                          decoration: InputDecoration(

                              isDense: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                              labelText: "الفصيلة",
                              labelStyle: TextStyle(
                                fontFamily: 'Tajawal',
                              )),
                          iconSize: 32,
                          isExpanded: true,
                          items:
                          _fasilaDropDown.map((String dropDownStringItem) {
                            return DropdownMenuItem<String>(
                              value: dropDownStringItem,
                              child: Center(
                                child: Text(
                                  dropDownStringItem,
                                  style: TextStyle(
                                    fontSize: 18,
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
                          value: fasila,
                        ),
                      ),
                      new Container(
                        padding: EdgeInsets.only(top: 17),
                        child: new TextFormField(
                          validator: (text) {
                            if (text.isEmpty) {
                              return "ادخل اسم الحالة";
                            }
                          },
                          textAlign: TextAlign.center,
                          controller: textFieldController,
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
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 16.0,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 17),
                        child: new TextFormField(
                          validator: (text) {
                            if (text.isEmpty) {
                              akias = "---";
                            }
                          },
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          controller: _akias,
                          onChanged: (text) {
                            setState(() {
                              akias = text;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'عدد الأكياس',
                            labelStyle: TextStyle(
                              fontFamily: 'Tajawal',
                            ),
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 16.0,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Container(
                        padding: EdgeInsets.all(7),
//                      decoration: BoxDecoration(
//                          border: Border.all(width: 2),
//                          borderRadius: BorderRadius.all(Radius.circular(35))),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding:
                              const EdgeInsets.only(top: 10, bottom: 10),
                              child: Container(
                                height: 2,
                                color: Colors.grey,
                              ),
                            ),
                            MaterialButton(
                              onPressed: () {
                                getLocation();

                                SpinKitDoubleBounce(
                                  color: Colors.white,
                                  size: 50.0,
                                );
                              },
                              color: Colors.blue,
                              textColor: Colors.white,
                              child: Icon(
                                Icons.location_on,
                                size: 20,
                              ),
                              padding: EdgeInsets.all(14),
                              shape: CircleBorder(),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              "لتحديد المكان",
                              style: TextStyle(
                                fontSize: 10,
                                fontFamily: 'Tajawal',
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 14),
                              child: new TextFormField(
                                validator: (text) {
                                  if (text.isEmpty) {
                                    return "ادخل اسم المحافظة";
                                  }
                                },
                                textAlign: TextAlign.center,
                                controller: _governmentController,
                                onChanged: (text) {
                                  setState(() {
                                    government = text;
                                  });
                                },
                                decoration: InputDecoration(
                                  labelText: 'المحافظة',
                                  labelStyle: TextStyle(
                                    fontFamily: 'Tajawal',
                                  ),
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16.0,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 17),
                              child: new TextFormField(
                                validator: (text) {
                                  if (text.isEmpty) {
                                    return "ادخل اسم المدينة";
                                  }
                                },
                                textAlign: TextAlign.center,
                                controller: _madinaController,
                                onChanged: (text) {
                                  setState(() {
                                    city = text;
                                  });
                                },
                                decoration: InputDecoration(
                                  labelText: 'المدينة',
                                  labelStyle: TextStyle(
                                    fontFamily: 'Tajawal',
                                  ),
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16.0,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Container(
                          height: 2,
                          color: Colors.grey,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 17),
                        child: new TextFormField(
                          validator: (text) {
                            if (text.isEmpty) {
                              return "ادخل اسم مكان التبرع";
                            }
                          },
                          textAlign: TextAlign.center,
                          controller: null,
                          onChanged: (text) {
                            setState(() {
                              hospital = text;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'اسم المستشفي',
                            labelStyle: TextStyle(
                              fontFamily: 'Tajawal',
                            ),
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 16.0,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 17),
                        child: new TextFormField(
                          validator: (text) {
                            if (text.isEmpty) {
                              hospitalAddress = "---";
                            }
                          },
                          textAlign: TextAlign.center,
                          controller: null,
                          onChanged: (text) {
                            setState(() {
                              hospitalAddress = text;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'عنوان المستشفي',
                            labelStyle: TextStyle(
                              fontFamily: 'Tajawal',
                            ),
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 16.0,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 17),
                        child: new TextFormField(
                          validator: (text) {
                            if (text.isEmpty) {
                              return "ادخل رقم تليفون المرافق";
                            }
                            if (text.length != 11) {
                              return "هذا الرقم غير صحيح";
                            }
                          },
                          keyboardType: TextInputType.numberWithOptions(),
                          textAlign: TextAlign.center,
                          controller: null,
                          onChanged: (text) {
                            setState(() {
                              phone = text;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'رقم المرافق',
                            labelStyle: TextStyle(
                              fontFamily: 'Tajawal',
                            ),
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 16.0,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 17),
                        child: new TextFormField(
                          validator: (text) {
                            if (text.isEmpty) {
                              note = "---";
                            }
                          },
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.multiline,
                          minLines: 3,
                          maxLines: null,
                          controller: null,
                          onChanged: (text) {
                            setState(() {
                              note = text;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'ملاحظات',
                            labelStyle: TextStyle(
                              fontFamily: 'Tajawal',
                            ),
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 16.0,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      RaisedButton(
                        elevation: 5,
                        child: Text(
                          "طلب تبرع جديد",
                          style: TextStyle(
                              fontFamily: 'Tajawal',
                              fontWeight: FontWeight.bold,
                              color: Colors.red[900],
                              fontSize: 17),
                        ),
                        onPressed: _isLoading
                            ? null
                            : () {
                          validation();
                        },
                      ),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool _isLoading = false;

  validation() {
    _formTlabKey.currentState.validate() ? addPost() : print("not valid");
  }

  addPost() async {
    setState(() {
      _isLoading = true;
    });
    getCurrentUser();
    var now = new DateTime.now();
    bool postColor = true;

    Map<String, dynamic> postMap() =>
        {
          'name': name,
          'fasila': fasila,
          'akias': akias,
          'government': government,
          'city': city,
          'hospital': hospital,
          'hospitalAddress': hospitalAddress,
          'phone': phone,
          'note': note,
          'date': now,
          'dateThatSignsThePost': now.toString(),
          'postSender': loggedInUser.email,
          'postColor': postColor
        };

    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print("Connected to Mobile Network");

        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => FirstPage()));

        setState(() {
          _isLoading = false;
        });

        await _fireStore
            .collection("post")
            .document(now.toString())
            .setData(postMap());
      }
    } on SocketException catch (_) {
      String invalid = "Unable to connect. Please Check Internet Connection";
      setState(() {
        _isLoading = false;
      });

      print(invalid);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        EasyLoading.showError('لا يوجد اتصال بالانترنت');
      });
    }
  }


}
