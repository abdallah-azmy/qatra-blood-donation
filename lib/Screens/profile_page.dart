import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../user.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:io';

final _auth = FirebaseAuth.instance;
final _fireStore = Firestore.instance;
FirebaseUser loggedInUser;
var _dateOfDonation = "---";
var dateOfDonation = "---";

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User user;

  Future<User> retrieveUserDetails(FirebaseUser user) async {
    DocumentSnapshot _documentSnapshot =
        await _fireStore.collection('users').document(user.uid).get();
    if (_documentSnapshot.data != null) {
      print('there is data ');
      setState(() {
        dateOfDonation = _documentSnapshot.data["dateOfDonation"];
      });
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
    setState(() {
      user = userdata;
    });
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
          appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            backgroundColor: Colors.red[900],
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "الصفحة الشخصية",
                  style: new TextStyle(
                    fontFamily: 'Tajawal',
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
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

                        child: Icon(
                          Icons.arrow_back, color: Colors.white, size: 28,),),
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
                      color: Colors.red[900],
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
                                                leading:
                                                Icon(Icons.accessibility_new),
                                                title: Text("فصيلة الدم",
                                                    style: TextStyle(
                                                      fontFamily: 'Tajawal',
                                                    )),
                                                subtitle: user == null
                                                    ? Text(
                                                  "---",
                                                )
                                                    : Text(user.fasila,
                                                    style: TextStyle(
                                                        fontWeight:
                                                        FontWeight.bold,
                                                        fontSize: 18)),
                                              ),
                                              ListTile(
                                                leading: Icon(Icons.phone),
                                                title: Text("رقم الهاتف",
                                                    style: TextStyle(
                                                      fontFamily: 'Tajawal',
                                                    )),
                                                subtitle: user == null
                                                    ? Text(
                                                  "---",
                                                )
                                                    : Text(user.phone,
                                                    style: TextStyle(
                                                        fontWeight:
                                                        FontWeight.bold,
                                                        fontSize: 18)),
                                              ),
                                              ListTile(
                                                leading: Icon(
                                                    Icons.my_location),
                                                title: Text("العنوان",
                                                    style: TextStyle(
                                                      fontFamily: 'Tajawal',
                                                    )),
                                                subtitle: user == null
                                                    ? Text(
                                                  "---",
                                                )
                                                    : Text(user.address,
                                                    style: TextStyle(
                                                        fontWeight:
                                                        FontWeight.bold,
                                                        fontSize: 18)),
                                              ),
                                              ListTile(
                                                leading: Icon(Icons.email),
                                                title: Text("البريد الالكترونى",
                                                    style: TextStyle(
                                                      fontFamily: 'Tajawal',
                                                    )),
                                                subtitle: user == null
                                                    ? Text(
                                                  "---",
                                                )
                                                    : Text(user.email,
                                                    style: TextStyle(
                                                        fontWeight:
                                                        FontWeight.bold,
                                                        fontSize: 18)),
                                              ),
                                              ListTile(
                                                  leading: Icon(Icons.person),
                                                  title: Text("موعد أخر تبرع",
                                                      style: TextStyle(
                                                        fontFamily: 'Tajawal',
                                                      )),
                                                  trailing: InkWell(
                                                      onTap: () {
                                                        editDateOfDonation(
                                                            context);
                                                      },
                                                      child: Icon(
                                                        Icons.border_color,
                                                        color: Colors.blue,
                                                      )),
                                                  subtitle: Text(dateOfDonation,
                                                      style: TextStyle(
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

  final _loginFormKey = GlobalKey<FormState>();

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

                      retrieveUserDetails(loggedInUser);
                      Navigator.pop(context);
                    }

                    _loginFormKey.currentState.validate()
                        ? uploadeTheDate()
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
                  "تعديل موعد أخر تبرع",
                  style: TextStyle(
                    fontFamily: 'Tajawal',
                    color: Colors.red[900],
                    fontSize: 20,
                  ),
                ),
              ),
              elevation: 10,
              content: Form(
                key: _loginFormKey,
                child: TextFormField(
                  validator: (text) {
                    if (text.isEmpty) {
                      return "برجاء كتابة التاريخ";
                    }
                  },
                  keyboardType: TextInputType.numberWithOptions(),
                  textAlign: TextAlign.center,
                  onChanged: (text) {
                    setState(() {
                      _dateOfDonation = text;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: "اليوم/الشهر/السنة",
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

  uploadDateOfDonation() async {
    FirebaseUser firebaseUser = await _auth.currentUser();

    await _fireStore
        .collection('users')
        .document(firebaseUser.uid)
        .updateData({'dateOfDonation': _dateOfDonation});
  }

  Future<List<DocumentSnapshot>> retrieveUserFavPosts(FirebaseUser user) async {
    print('inside retrieveUserFavPosts function ');
    QuerySnapshot querySnapshot = await _fireStore
        .collection('UserData')
        .document(user.uid)
        .collection('email')
        .getDocuments();
    print(querySnapshot.documents);
    return querySnapshot.documents;
  }
}
