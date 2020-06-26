import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../appBar_widget.dart';
import '../user_model.dart';
import 'addDonorToBlazmaBank.dart';
import 'user_profile_page.dart';
import 'add_doner_to_bank.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

final _fireStore = Firestore.instance;

class BlazmaGovernrateBank extends StatefulWidget {
  final String city;

  const BlazmaGovernrateBank({Key key, this.city}) : super(key: key);

  @override
  _BlazmaGovernrateBankState createState() => _BlazmaGovernrateBankState();
}

class _BlazmaGovernrateBankState extends State<BlazmaGovernrateBank> {
  @override
  void initState() {
    super.initState();
    _readCheckIfAccAddedToBank();
  }

  GlobalKey<ScaffoldState> _scafold = new GlobalKey<ScaffoldState>();

  var name;
  var fasila;
  var phone;
  int addedToBank = 0;
  Stream search;

  final _auth = FirebaseAuth.instance;
  User _user;
  FirebaseUser loggedInUser;

  var __fasila = [
    ' - عرض كل الفصائل -  ',
    'AB+',
    "AB-",
    "A+",
    "A-",
    "B+",
    "B-",
    "O+",
    "O-",
  ];
  var __currentFasilaSelected = ' - عرض كل الفصائل -  ';

  void _onDropDownItemSelected(String newValueSelected) {
    setState(() {
      __currentFasilaSelected = newValueSelected;
      print(" $__currentFasilaSelected sellected");
    });
  }

  inetialSearch() {
    Stream _search = _fireStore
        .collection("blazmaBank")
        .document(widget.city)
        .collection('doners')
        .orderBy('date', descending: true)
        .snapshots();

    if (__currentFasilaSelected != ' - عرض كل الفصائل -  ') {
      setState(() {
        _search = _fireStore
            .collection("blazmaBank")
            .document(widget.city)
            .collection('doners')
            .orderBy('date', descending: true)
            .where('fasila', isEqualTo: __currentFasilaSelected)
            .snapshots();
      });
    }
    return _search;
  }

  setTheSearch() {}

  _readCheckIfAccAddedToBank() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'my_int_key_blazma';
    setState(() {
      addedToBank = prefs.getInt(key) ?? 0;
    });

    print('read: $addedToBank');
  }

  _saveCheckIfAccAddedToBank() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'my_int_key_blazma';
    addedToBank = 1;
    prefs.setInt(key, addedToBank);
    print('saved $addedToBank');
  }

  addMyAccToBank() async {
    var now = new DateTime.now();

    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print("Connected to Mobile Network");
        FirebaseUser firebaseUser = await _auth.currentUser();
        uploadUserToGovernrateBank() async {
          await _fireStore
              .collection('users')
              .document(firebaseUser.uid)
              .updateData({'blazmaBank': widget.city});
        }

        ;

        uploadUserToGovernrateBank();

        await _fireStore
            .collection('blazmaBank')
            .document(widget.city)
            .collection('doners')
            .document(firebaseUser.uid)
            .setData(_user.toMap(_user));

        _saveCheckIfAccAddedToBank();
        showNotification("تم اضافة حسابك بنجاح", _scafold);
      }
    } on SocketException catch (_) {
      String invalid = "Unable to connect. Please Check Internet Connection";
      print(invalid);

      showNotification("لا يوجد اتصال بالانترنت", _scafold);
    }
    _readCheckIfAccAddedToBank();
  }

  Future<User> retrieveUserDetails(FirebaseUser user) async {
    DocumentSnapshot _documentSnapshot =
    await _fireStore.collection('users').document(user.uid).get();
    print(user.uid);
    if (_documentSnapshot.data != null) {
      print('there is data ');
      return User.fromMap(_documentSnapshot.data);
    } else {
      return null;
    }
  }

  Future<FirebaseUser> getCurrentUser() async {
    return loggedInUser = await _auth.currentUser();
  }

  makeUserObject() async {
    FirebaseUser _currentUser = await getCurrentUser();

    var userdata = await retrieveUserDetails(_currentUser);
    var now = new DateTime.now();
    setState(() {
      _user = userdata;
      _user.date = now;
    });
    addMyAccToBank();
  }

  creatAlertDialog(BuildContext context, city) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: Center(
              child: Text(
                "سيتم اضافتك كمتبرع في محافظة $city",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                    fontFamily: "Tajawal",
                    height: 1.5),
              ),
            ),
            elevation: 10,
            content: Container(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                      color: Colors.red[700],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Center(
                        child: Text("تراجع",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: "Tajawal")),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                      color: Colors.green[700],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      onPressed: () {
                        makeUserObject();
                        Navigator.pop(context);
                      },
                      child: Center(
                        child: Text("موافق",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: "Tajawal")),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
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
          appBar: WaveAppBar(
            title: widget.city,
            backGroundColor: Colors.white,
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
          body: Column(
//              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 5,
                  ),
                  addedToBank == 0
                      ? FlatButton(
                    child: Text(
                      'اضف حسابك الي بنك البلازما',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Tajawal',
                      ),
                    ),
                    onPressed: () {
                      creatAlertDialog(context, widget.city);
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    color: Colors.red,
                  )
                      : SizedBox(
                    height: 0,
                  ),
                  FlatButton(
                    child: Text(
                      'أضف متبرع الي بنك البلازما',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Tajawal',
                          fontSize: 16),
                    ),
                    onPressed: () {

                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) =>
                                  AddDonerToBlazmaBank(widget.city, _scafold)));
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    color: Colors.green,
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 7, right: 10, left: 10),
                    child: DropdownButtonFormField<String>(
                      isDense: true,
                      decoration: InputDecoration(
                          isDense: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          prefixIcon: Icon(
                            Icons.local_hospital,
                            color: Colors.red[900],
                            size: 24,
                          )),
                      validator: (value) =>
                      value == "حدد فصيلتك" ? 'برجاء اختيار الفصيلة' : null,
                      items: __fasila.map((String dropDownStringItem) {
                        return DropdownMenuItem<String>(
                          value: dropDownStringItem,
                          child: Center(
                              child: Text(
                                dropDownStringItem,
                                textDirection: TextDirection.ltr,
                                style: TextStyle(
                                  color: Colors.red[900],
                                  fontSize: 18,
                                  fontFamily: 'Tajawal',
                                ),
                              )),
                        );
                      }).toList(),
                      onChanged: (String newValueSelected) {
                        // Your code to execute, when a menu item is selected from drop down
                        _onDropDownItemSelected(newValueSelected);
                        setTheSearch();
                      },
                      value: __currentFasilaSelected,
                    ),
                  ),
                ],
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: inetialSearch(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            height: 150,
                            child: Center(
                              child: CircularProgressIndicator(
                                backgroundColor: Colors.red[900],
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                    final usersData = snapshot.data.documents;
                    List<Doner> messageBubbles = [];
                    for (var user in usersData) {
                      final displayName = user.data["displayName"];
                      final address = user.data["address"];
                      final fasila = user.data["fasila"];
                      final phone = user.data["phone"];
                      final email = user.data["email"];
                      final imageUrl = user.data["imageUrl"];
                      final dateOfDonation = user.data["dateOfDonation"];

                      final messageBubble = Doner(
                        fasila: fasila,
                        address: address,
                        displayName: displayName,
                        phone: phone,
                        email: email,
                        imageUrl: imageUrl,
                        dateOfDonation: dateOfDonation,
                      );

                      messageBubbles.add(messageBubble);
                    }
                    return Expanded(
                      child: messageBubbles.length ==0 ? Padding(
                        padding: const EdgeInsets.only(bottom: 80),
                        child: Center(
                          child: Text("لا يوجد متبرعين حتي الان",style: TextStyle(
                            fontSize: 20,
                            fontFamily: "Tajawal"
                          ),),
                        ),
                      ): ListView(
//                  reverse: true,
                        children: messageBubbles,
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class Doner extends StatefulWidget {
  Doner(
      {this.fasila,
        this.address,
        this.displayName,
        this.phone,
        this.email,
        this.imageUrl,
        this.dateOfDonation});

  final String fasila;
  final String address;
  final String displayName;
  final String phone;
  final String email;
  final String imageUrl;
  final String dateOfDonation;

  @override
  _DonerState createState() => _DonerState();
}

class _DonerState extends State<Doner> {
  User _user;

  makeMapForUserInfo() {
    Map<String, dynamic> userMap = {
      'displayName': widget.displayName,
      'email': widget.email,
//    'uid': user.uid,
      'phone': widget.phone,
      'fasila': widget.fasila,
      'address': widget.address,
      'imageUrl': widget.imageUrl,
      'dateOfDonation': widget.dateOfDonation
    };
    return User.fromMap(userMap);
  }

  updateInternData() {
    makeMapForUserInfo();
    setState(() {
      var userInfo = makeMapForUserInfo();
      _user = userInfo;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    updateInternData();
    print("builllllllllllllllld");
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: null,
        child: Container(
          child: ListTile(
            leading: Text(
              widget.fasila,
              textDirection: TextDirection.ltr,
              style: TextStyle(
                  color: Colors.red[900],
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new UserProfile(
                        user: _user,
                      )));
            },
            title: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    widget.address,
                    style: TextStyle(
                        fontFamily: 'Tajawal',
//                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  Text(
                    widget.displayName,
                    style: TextStyle(
                        fontFamily: 'Tajawal',
                        color: Colors.grey[700],
                        fontSize: 15),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
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
