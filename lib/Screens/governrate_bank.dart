import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../appBar_widget.dart';
import '../user_model.dart';
import 'user_profile_page.dart';
import 'add_doner_to_bank.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:io';

class GovernrateBank extends StatefulWidget {
  final String city;

  const GovernrateBank({Key key, this.city}) : super(key: key);

  @override
  _GovernrateBankState createState() => _GovernrateBankState();
}

class _GovernrateBankState extends State<GovernrateBank> {
  var name;
  var fasila;
  var city;
  var phone;
  int addedToBank = 0;

  final _fireStore = Firestore.instance;
  final _auth = FirebaseAuth.instance;
  User _user;
  FirebaseUser loggedInUser;

  _readCheckIfAccAddedToBank() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'my_int_key';
    setState(() {
      addedToBank = prefs.getInt(key) ?? 0;
    });

    print('read: $addedToBank');
  }

  _saveCheckIfAccAddedToBank() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'my_int_key';
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

        setState(() {
          _isLoading = false;
        });

        WidgetsBinding.instance.addPostFrameCallback((_) {
          EasyLoading.showSuccess('تم اضافة حسابك بنجاح');
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
        _isLoading = false;
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        EasyLoading.showError('لا يوجد اتصال بالانترنت');
      });
    }
    _readCheckIfAccAddedToBank();
    setState(() {
      _isLoading = false;
    });
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

  bool _isLoading = false;

  makeUserObject() async {
    setState(() {
      _isLoading = true;
    });
    _saveCheckIfAccAddedToBank();
    FirebaseUser _currentUser = await getCurrentUser();

    var userdata = await retrieveUserDetails(_currentUser);
    setState(() {
      _user = userdata;
    });
    addMyAccToBank();
  }

  @override
  void initState() {
    super.initState();
    _readCheckIfAccAddedToBank();
  }

  @override
  Widget build(BuildContext context) {
    return FlutterEasyLoading(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 7,
                    ),
                    addedToBank == 0
                        ? RaisedButton(
                            child: Text(
                              'اضف حسابك الي بنك الدم',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Tajawal',
                              ),
                            ),
                            onPressed: _isLoading
                                ? null
                                : () {
                                    makeUserObject();
                                  },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            color: Colors.red,
                          )
                        : SizedBox(
                            height: 1,
                          ),
                    RaisedButton(
                      child: Text(
                        'أضف متبرع الي بنك الدم',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Tajawal',
                            fontSize: 17),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => AddDonerToBank(
                                      city: widget.city,
                                    )));
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      color: Colors.green,
                    ),
                  ],
                ),
                StreamBuilder<QuerySnapshot>(
                    stream: _fireStore
                        .collection("bank")
                        .document(widget.city)
                        .collection('doners')
                        .orderBy('fasila', descending: false)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Center(
                              child: CircularProgressIndicator(
                                backgroundColor: Colors.red[900],
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
                        final dateOfDonation = user.data["dateOfDonation"];

                        final messageBubble = Doner(
                          fasila: fasila,
                          address: address,
                          displayName: displayName,
                          phone: phone,
                          email: email,
                          dateOfDonation: dateOfDonation,
                        );

                        messageBubbles.add(messageBubble);
                      }
                      return Expanded(
                        child: ListView(
//                  reverse: true,
                          children: messageBubbles,
                        ),
                      );
                    }),
              ],
            ),
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
      this.dateOfDonation});

  final String fasila;
  final String address;
  final String displayName;
  final String phone;
  final String email;
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
      'dateOfDonation': widget.dateOfDonation
    };

    return User.fromMap(userMap);
  }

  @override
  void initState() {
    super.initState();

    var userInfo = makeMapForUserInfo();
    setState(() {
      _user = userInfo;
    });
  }

  @override
  Widget build(BuildContext context) {
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
