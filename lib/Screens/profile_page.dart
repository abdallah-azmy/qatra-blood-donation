import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

import '../appBar_widget.dart';
import '../user_model.dart';
import 'dart:io';
import 'package:path/path.dart' as path;
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
  var newPhone = "---";
  var _newPhone;
  var _newName;
  var newName = "---";
  var _newAddress;
  var newAddress = "---";
  var newFasila = "---";
  var _newFasila;
  final _addressFormKey = GlobalKey<FormState>();
  final _phoneFormKey = GlobalKey<FormState>();
  final _nameFormKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  var myFormat = intl.DateFormat('d-MM-yyyy');
  GlobalKey<ScaffoldState> _scafold = new GlobalKey<ScaffoldState>();

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
        newPhone = _documentSnapshot.data["phone"];
        newName = _documentSnapshot.data["displayName"];
        imageUrl = _documentSnapshot.data["imageUrl"];
      });

      return User.fromMap(_documentSnapshot.data);
    } else {
      return null;
    }
  }

  File _image;
  var imageUrl;
  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
    print("bbbbbbbbbbbbbbbbbbbbbbbbbbb");
    uploadPic(context);
  }

  var loading = false;

  Future uploadPic(BuildContext context) async {
    setState(() {
      loading = true;
    });

    String fileName = path.basename(_image.path);

    StorageReference fireBaseStorageRefrence =
        FirebaseStorage.instance.ref().child(fileName);

    StorageUploadTask uploadTask = fireBaseStorageRefrence.putFile(_image);

    var dowurl = await (await uploadTask.onComplete).ref.getDownloadURL();

    setState(() {
      imageUrl = dowurl.toString();
    });

    await _fireStore.collection('users').document(loggedInUser.uid).updateData({
      "imageUrl": imageUrl,
//      'displayName': name,
    });
    print("dataaa uploaaaaaaaaded  image");

//    setState(() {
//      print("profile pic uploaded");
//      Scaffold.of(context).showSnackBar(SnackBar(
//        content: Text("Done !"),
//      ));
//    });
    showNotification("تمت العملية بنجاح !", _scafold);

    setState(() {
      loading = false;
    });
  }

  imageConditions() {
    if (_image != null) {
      return Image.file(
        _image,
        fit: BoxFit.cover,
      );
    } else if (imageUrl != null) {
      return CachedNetworkImage(
        imageUrl: "$imageUrl",
        placeholder: (context, url) => new Container(
          child: CircularProgressIndicator(),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/abcd.jpg"), fit: BoxFit.cover))),
        errorWidget: (context, url, error) => new Icon(Icons.error),
      );
    } else {
      return Image.asset(
        "assets/abcd.jpg",
        fit: BoxFit.cover,
      );
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
          key: _scafold,
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
                      height: 275,
                      color: Colors.red[800],
                    ),
                    Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            InkWell(
                              onTap: () {
                                print("aaaaaaaaaaaaaaa");
                                getImage();
                              },
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 90),
                                  child: loading == false
                                      ? Icon(
                                          Icons.add_a_photo,
                                          color: Colors.black87,
                                          size: 25,
                                        )
                                      : Image.asset(
                                          "assets/loading.gif",
                                          height: 25.0,
                                          width: 25.0,
                                        ),
                                ),
                              ),
                            ),
                            Container(
                              height: 125,
                              width: 125,
                              margin: EdgeInsets.only(top: 12),
                              child: ClipOval(child: imageConditions()),
                            ),
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 90),
                                child: Icon(
                                  null,
                                  color: Colors.black87,
                                  size: 25,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.all(4),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              height: 40,
                              width: 40,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: new BorderRadius.circular(10.0),
                                color: Colors.black87.withOpacity(.4),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  newName,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            InkWell(
                              onTap: () {
                                print("aa");
                                editName(context);
                              },
                              child: Container(
                                height: 40,
                                width: 40,
                                child: Icon(
                                  Icons.settings,
                                  color: Colors.blue,
                                ),
                              ),
                            )
                          ],
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
                                            trailing: InkWell(
                                              onTap: () {
                                                editPhone(context);
                                              },
                                              child: Container(
                                                height: 50,
                                                width: 50,
                                                color: Colors.white,
                                                child: Icon(
                                                  Icons.settings,
                                                  color: Colors.blue,
                                                ),
                                              ),
                                            ),
                                            leading: Icon(Icons.phone),
                                            title: Text("رقم الهاتف :",
                                                style: TextStyle(
                                                  fontFamily: 'Tajawal',
                                                )),
                                            subtitle: Text(newPhone,
                                                style: TextStyle(
                                                    color: Colors.red[900],
                                                    fontWeight: FontWeight.bold,
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
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          )),
    );
  }

  editName(BuildContext contex) {
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
                    upName() async {
                      print("in the fn");
                      try {
                        final result =
                            await InternetAddress.lookup('google.com');
                        if (result.isNotEmpty &&
                            result[0].rawAddress.isNotEmpty) {
                          print("Connected to Mobile Network");
                          uploadName();
                        }
                      } on SocketException catch (_) {
                        showNotification("لا يوجد اتصال بالانترنت !", _scafold);
                      }
                      print("aaaaaaaaaaaaaaaaa");

                      retrieveUserDetails(loggedInUser);
                      Navigator.pop(context);
                    }

                    _nameFormKey.currentState.validate()
                        ? upName()
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
                  "تعديل الاسم",
                  style: TextStyle(
                    fontFamily: 'Tajawal',
                    color: Colors.red[900],
                    fontSize: 20,
                  ),
                ),
              ),
              elevation: 10,
              content: Form(
                key: _nameFormKey,
                child: TextFormField(
                  validator: (text) {
                    if (text.trim() == "") {
                      return "لا يجب ان يكون الاسم كله مسافات";
                    }
                  },
                  textAlign: TextAlign.center,
                  onChanged: (text) {
                    setState(() {
                      _newName = text;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: "الاسم",
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

  uploadName() async {
    FirebaseUser firebaseUser = await _auth.currentUser();

    await _fireStore
        .collection('users')
        .document(firebaseUser.uid)
        .updateData({'displayName': _newName});
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
      showNotification("لا يوجد اتصال بالانترنت !", _scafold);
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

  editPhone(BuildContext contex) {
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
                    upPhone() async {
                      print("in the fn");
                      try {
                        final result =
                            await InternetAddress.lookup('google.com');
                        if (result.isNotEmpty &&
                            result[0].rawAddress.isNotEmpty) {
                          print("Connected to Mobile Network");
                          uploadPhone();
                        }
                      } on SocketException catch (_) {
                        showNotification("لا يوجد اتصال بالانترنت !", _scafold);
                      }
                      print("aaaaaaaaaaaaaaaaa");

                      retrieveUserDetails(loggedInUser);
                      Navigator.pop(context);
                    }

                    _phoneFormKey.currentState.validate()
                        ? upPhone()
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
                  "تعديل رقم الموبايل",
                  style: TextStyle(
                    fontFamily: 'Tajawal',
                    color: Colors.red[900],
                    fontSize: 20,
                  ),
                ),
              ),
              elevation: 10,
              content: Form(
                key: _phoneFormKey,
                child: TextFormField(
                  textDirection: TextDirection.rtl,
                  validator: (text) {
                    if (text.isEmpty) {
                      return "برجاء كتابة الرقم";
                    } else if (text.length != 11) {
                      return "الرقم خاطيء";
                    }
                  },
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  onChanged: (text) {
                    setState(() {
                      _newPhone = text;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: "رقم الموبايل",
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

  uploadPhone() async {
    FirebaseUser firebaseUser = await _auth.currentUser();

    var _governerate;

    DocumentSnapshot _documentSnapshot =
        await _fireStore.collection('users').document(user.uid).get();

    if (_documentSnapshot.data != null) {
      print('there is data ');

      setState(() {
        _governerate = _documentSnapshot.data["governrateBank"];
      });

      print("$_governerate");

      if (_governerate != null) {
        await _fireStore
            .collection('bank')
            .document(_governerate)
            .collection('doners')
            .document(firebaseUser.uid)
            .updateData({'phone': _newPhone});
      }
    }

    await _fireStore
        .collection('users')
        .document(firebaseUser.uid)
        .updateData({'phone': _newPhone});
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
                        showNotification("لا يوجد اتصال بالانترنت !", _scafold);
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
                  textDirection: TextDirection.rtl,
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
                          uploadDateOfDonation();
                        }
                      } on SocketException catch (_) {
                        showNotification("لا يوجد اتصال بالانترنت !", _scafold);
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
//                    uploadDateOfDonation();
                  }

                  _selectDate(context);
                },
              ));
        });
  }

  uploadDateOfDonation() async {
    FirebaseUser firebaseUser = await _auth.currentUser();

    var _governerate;
    var blazmaBank;

    DocumentSnapshot _documentSnapshot =
        await _fireStore.collection('users').document(user.uid).get();

    if (_documentSnapshot.data != null) {
      print('there is data ');

      setState(() {
        _governerate = _documentSnapshot.data["governrateBank"];
        blazmaBank = _documentSnapshot.data["blazmaBank"];
      });

      print("$_governerate");

      if (_governerate != null) {
        await _fireStore
            .collection('bank')
            .document(_governerate)
            .collection('doners')
            .document(firebaseUser.uid)
            .updateData({'dateOfDonation': myFormat.format(selectedDate)});
      }
      if (_governerate != null) {
        await _fireStore
            .collection('blazmaBank')
            .document(blazmaBank)
            .collection('doners')
            .document(firebaseUser.uid)
            .updateData({'dateOfDonation': myFormat.format(selectedDate)});
      }
    }

    await _fireStore
        .collection('users')
        .document(firebaseUser.uid)
        .updateData({'dateOfDonation': myFormat.format(selectedDate)});

    print("888888888888888888");
    retrieveUserDetails(firebaseUser);
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
