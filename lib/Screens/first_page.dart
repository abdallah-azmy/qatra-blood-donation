import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'blood_bank.dart';
import 'about_theApp.dart';
import 'articles.dart';
import 'chat.dart';
import 'login_page.dart';
import 'profile_page.dart';
import 'tlab_tabaro3.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart' as intl;
import 'package:url_launcher/url_launcher.dart';
import 'package:expand_widget/expand_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:io';
import 'package:social_share_plugin/social_share_plugin.dart';
import 'package:flutter_share_me/flutter_share_me.dart';


final _fireStore = Firestore.instance;
final _auth = FirebaseAuth.instance;
FirebaseUser _loggedInUser;

Future<FirebaseUser> getCurrentUser() async {
  try {
    final user = await _auth.currentUser();
    if (user != null) {
      _loggedInUser = user;
    }
  } catch (e) {
    print(e);
  }
}

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage>
    with SingleTickerProviderStateMixin {
  _FirstPageState();

  var _fasila = [
    ' - عرض كل الطلبات -  ',
    'AB+',
    "AB-",
    "A+",
    "A-",
    "B+",
    "B-",
    "O+",
    "O-",
    'اي فصيلة',
  ];
  var _currentFasilaSelected = ' - عرض كل الطلبات -  ';

  void _onDropDownItemSelected(String newValueSelected) {
    setState(() {
      _currentFasilaSelected = newValueSelected;
    });
  }

  Stream search = _fireStore
      .collection("post")
      .orderBy('date', descending: true)
      .snapshots();

  setTheSearch() {
    if (_currentFasilaSelected != ' - عرض كل الطلبات -  ') {
      setState(() {
        search = _fireStore
            .collection("post")
            .orderBy('date', descending: true)
            .where('fasila', isEqualTo: _currentFasilaSelected)
            .snapshots();
      });
    } else {
      setState(() {
        search = _fireStore
            .collection("post")
            .orderBy('date', descending: true)
            .snapshots();
      });
    }
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
          home: OrientationBuilder(builder: (context, orientation) {
            return Directionality(
              textDirection: TextDirection.rtl,
              child: Scaffold(
                  resizeToAvoidBottomPadding: false,
                  appBar: AppBar(
                    actions: <Widget>[
                      IconButton(
                        icon: Icon(null),
                      ),
                    ],
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(right: 0),
                          child: Text(
                            "طلبات التبرع",
                            style: new TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Tajawal',
                              fontSize: 20.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    centerTitle: true,
                    backgroundColor: Colors.red[900],
                  ),
                  floatingActionButton: Padding(
                      padding: const EdgeInsets.only(right: 20, top: 20),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => new TlabTabaro3()));
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
                                bottom: 15,
                                right: 21,
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 34,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                  drawer: Drawer(
                    child: ListView(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          color: Colors.white,
                          child: DrawerHeader(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                "assets/fainallogo.png",
                              )
                            ],
                          )),
                        ),
                        Container(
                          color: Colors.white,
                          child: Column(
                            children: <Widget>[
                              Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                color: null,
                                child: Container(
                                  child: ListTile(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          new MaterialPageRoute(
                                              builder: (context) =>
                                                  new BloodBank()));
                                    },
                                    title: Text(
                                      "بنك الدم",
                                      style: TextStyle(
                                          fontFamily: 'Tajawal',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    leading: Icon(Icons.local_hospital,
                                        size: 30, color: Colors.red[900]),
                                    trailing: null,
                                  ),
                                ),
                              ),
                              Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                color: null,
                                child: Container(
                                  child: ListTile(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          new MaterialPageRoute(
                                              builder: (context) =>
                                                  new ProfilePage()));
                                    },
                                    title: Text(
                                      "الصفحة الشخصية",
                                      style: TextStyle(
                                          fontFamily: 'Tajawal',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    leading: Icon(Icons.account_circle,
                                        size: 30, color: Colors.red[900]),
                                    trailing: null,
                                  ),
                                ),
                              ),
                              Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                color: null,
                                child: Container(
                                  child: ListTile(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          new MaterialPageRoute(
                                              builder: (context) => Chat()));
                                    },
                                    title: Text(
                                      "الشات العام",
                                      style: TextStyle(
                                          fontFamily: 'Tajawal',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    leading: Icon(Icons.chat,
                                        size: 30, color: Colors.red[900]),
                                    trailing: null,
                                  ),
                                ),
                              ),
                              Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                color: null,
                                child: Container(
                                  child: ListTile(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          new MaterialPageRoute(
                                              builder: (context) =>
                                                  new Articles()));
                                    },
                                    title: Text(
                                      "مقالات",
                                      style: TextStyle(
                                          fontFamily: 'Tajawal',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    leading: Icon(Icons.description,
                                        size: 30, color: Colors.red[900]),
                                    trailing: null,
                                  ),
                                ),
                              ),
                              Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                color: null,
                                child: Container(
                                  child: ListTile(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          new MaterialPageRoute(
                                              builder: (context) =>
                                                  new AboutTheApp()));
                                    },
                                    title: Text(
                                      "عن التطبيق",
                                      style: TextStyle(
                                          fontFamily: 'Tajawal',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    leading: Icon(Icons.apps,
                                        size: 30, color: Colors.red[900]),
                                    trailing: null,
                                  ),
                                ),
                              ),
                              Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                color: null,
                                child: Container(
                                  child: ListTile(
                                    onTap: () {
                                      _auth.signOut();
                                      Navigator.pushReplacement(
                                          context,
                                          new MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  LoginPage()));
                                    },
                                    title: Text(
                                      "تسجيل الخروج",
                                      style: TextStyle(
                                          fontFamily: 'Tajawal',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    leading: Icon(
                                      Icons.lock_outline,
                                      size: 30,
                                      color: Colors.red[900],
                                    ),
                                    trailing: null,
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  body: Container(
                    decoration: new BoxDecoration(
                      color: Colors.grey[300],
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.only(
                              top: 10, right: 10, left: 10),
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
                            validator: (value) => value == "حدد فصيلتك"
                                ? 'برجاء اختيار الفصيلة'
                                : null,
                            items: _fasila.map((String dropDownStringItem) {
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
                            value: _currentFasilaSelected,
                          ),
                        ),
                        StreamBuilder<QuerySnapshot>(
                          stream: search,
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Center(
                                child: CircularProgressIndicator(
                                  backgroundColor: Colors.red[900],
                                ),
                              );
                            }
                            final posts = snapshot.data.documents;
                            List<PostBubble> postBubbles = [];
                            for (var post in posts) {
                              final date = post.data["date"].toDate();
                              final dateThatSignsThePost =
                                  post.data["dateThatSignsThePost"];
                              final name = post.data["name"];
                              final fasila = post.data["fasila"];
                              final akias = post.data["akias"];
                              final government = post.data["government"];
                              final city = post.data["city"];
                              final hospital = post.data["hospital"];
                              final hospitalAddress =
                                  post.data["hospitalAddress"];
                              final phone = post.data["phone"];
                              final note = post.data["note"];
                              final postSender = post.data["postSender"];
                              final postColor = post.data["postColor"];

                              final postBubble = PostBubble(
                                name: name,
                                fasila: fasila,
                                akias: akias,
                                government: government,
                                city: city,
                                hospital: hospital,
                                hospitalAddress: hospitalAddress,
                                phone: phone,
                                note: note,
                                date: date,
                                postSender: postSender,
                                postColor: postColor,
                                dateThatSignsThePost: dateThatSignsThePost,
                              );
                              postBubbles.add(postBubble);
                            }
                            return Expanded(
                              child: SizedBox(
                                height: 170.0,
                                child: ListView(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 20),
                                  children: postBubbles,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  )),
            );
          })),
    );
  }
}

class PostBubble extends StatelessWidget {
  PostBubble({
    this.name,
    this.fasila,
    this.akias,
    this.government,
    this.city,
    this.phone,
    this.hospital,
    this.date,
    this.hospitalAddress,
    this.note,
    this.postSender,
    this.postColor,
    this.dateThatSignsThePost,
  });

  var name;
  var fasila;
  var akias;
  var government;
  var city;
  var phone;
  var hospital;
  var hospitalAddress;
  var note;
  var date;
  var postSender;
  var postColor;
  var dateThatSignsThePost;

  changeDateFormat() {
    String formattedDate = intl.DateFormat.yMd().add_jm().format(date);
    return formattedDate;
  }

  changeColor() {
    if (postColor == true) {
      return postSender == _loggedInUser.email
          ? Colors.yellow[600]
          : Colors.white;
    } else {
      return Colors.green[200];
    }
  }

  updatePostStateEnd() async {
    await _fireStore
        .collection('post')
        .document(dateThatSignsThePost)
        .updateData({'postColor': false});
  }

  updatePostStateContinue() async {
    await _fireStore
        .collection('post')
        .document(dateThatSignsThePost)
        .updateData({'postColor': true});
  }

  var fasilaTwiter;

  @override
  Widget build(BuildContext context) {
    if (fasila == "A+") {
      fasilaTwiter = "$fasilaموجب";
    } else if (fasila == "AB+") {
      fasilaTwiter = "$fasilaموجب";
    } else if (fasila == "O+") {
      fasilaTwiter = "$fasilaموجب";
    } else if (fasila == "B+") {
      fasilaTwiter = "$fasilaموجب";
    }else{
      fasilaTwiter = fasila ;
    }
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25), color: changeColor()),
      width: double.infinity,
//      height: 159,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 13),
      child: Stack(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Stack(
                  children: <Widget>[
                    SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                postColor == true
                                    ? fasila
                                    : "طلب التبرع هذا قد تم",
                                textDirection: TextDirection.ltr,
                                style: TextStyle(
                                  fontFamily: 'Tajawal',
                                  color: Colors.red[900],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.location_on,
                                color: Colors.red[700],
                                size: 20,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Flexible(
                                child: Text("$government -- $city",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red[500],
                                        fontSize: 16,
                                        letterSpacing: .3)),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.account_circle,
                                color: Colors.red[700],
                                size: 20,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Flexible(
                                child: Text("اسم الحالة : $name",
                                    style: TextStyle(
                                        fontFamily: 'Tajawal',
                                        color: Colors.red[500],
                                        fontSize: 16,
                                        letterSpacing: .3)),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(top: 1),
                                child: Text(
                                  changeDateFormat(),
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                          ExpandChild(
                            child: Column(
                              children: <Widget>[
                                Container(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      children: <Widget>[
                                        postColor == true
                                            ? InkWell(
                                                onTap: () {
                                                  call();
                                                },
                                                child: Row(
                                                  children: <Widget>[
                                                    Icon(
                                                      Icons.phone,
                                                      color: Colors
                                                          .lightBlueAccent,
                                                      size: 20,
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Flexible(
                                                      child: Text("$phone",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Colors
                                                                  .lightBlueAccent,
                                                              fontSize: 16,
                                                              letterSpacing:
                                                                  .3)),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : Row(
                                                children: <Widget>[
                                                  Icon(
                                                    Icons.phone,
                                                    color:
                                                        Colors.lightBlueAccent,
                                                    size: 20,
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Flexible(
                                                    child: Text("-----------",
                                                        style: TextStyle(
                                                            color: Colors
                                                                .lightBlueAccent,
                                                            fontSize: 16,
                                                            letterSpacing: .3)),
                                                  ),
                                                ],
                                              ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Icon(
                                              Icons.accessibility_new,
                                              color: Colors.red[700],
                                              size: 20,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Flexible(
                                              child: Text(
                                                  "عدد الأكياس : $akias",
                                                  style: TextStyle(
                                                      fontFamily: 'Tajawal',
                                                      color: Colors.red[500],
                                                      fontSize: 16,
                                                      letterSpacing: .3)),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Icon(
                                              Icons.local_hospital,
                                              color: Colors.red[700],
                                              size: 20,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Flexible(
                                              child: Text(
                                                  "اسم المستشفي : $hospital",
                                                  style: TextStyle(
                                                      fontFamily: 'Tajawal',
                                                      color: Colors.red[500],
                                                      fontSize: 16,
                                                      letterSpacing: .3)),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Icon(
                                              Icons.home,
                                              color: Colors.red[700],
                                              size: 20,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Flexible(
                                              child: Text(
                                                  "عنوان المستشفي : $hospitalAddress",
                                                  style: TextStyle(
                                                      fontFamily: 'Tajawal',
                                                      color: Colors.red[500],
                                                      fontSize: 16,
                                                      letterSpacing: .3)),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Icon(
                                              Icons.content_paste,
                                              color: Colors.red[700],
                                              size: 20,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Flexible(
                                              child: Text("ملاحظة : $note",
                                                  style: TextStyle(
                                                      fontFamily: 'Tajawal',
                                                      color: Colors.red[500],
                                                      fontSize: 16,
                                                      letterSpacing: .3)),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Text("_ شارك طلب التبرع :",
                                        style: TextStyle(
                                            fontFamily: 'Tajawal',
                                            color: Colors.red[500],
                                            fontSize: 16,
                                            letterSpacing: .3)
                                            ),
                                            SizedBox(width: 5,),
                                            InkWell(
                                                onTap: () async {
                                                  await SocialSharePlugin.shareToTwitterLink(
                                                      text: "مطلوب متبرع بالدم .. \n"
                                                          " الفصيلة : + $fasilaTwiter\n"
                                                          "$government -- $city\n"
                                                          "$name\n"
                                                          " رقم المرافق :   $phone\n",
                                                      url: '\nتطبيق * قطرة * للتبرع بالدم');
                                                },
                                                child: Tab(
                                                  icon:
                                                  ClipRRect(

                                                      borderRadius: BorderRadius.circular(10.0),
                                                      child: Image.asset("assets/72.jpg",height: 40,width: 40,)),
                                                )),
                                            SizedBox(width: 5,),

                                            InkWell(onTap: (){
                                              FlutterShareMe()
                                                  .shareToWhatsApp( msg:
                                              "مطلوب متبرع بالدم .. \n"
                                                  " الفصيلة :  $fasila\n"
                                                  "$government -- $city\n"
                                                  "$name\n"
                                                  " رقم المرافق :  $phone\n"
                                                  '\nتطبيق * قطرة * للتبرع بالدم'
                                              );
                                            },
                                              child: Tab(
                                                icon:
                                                ClipRRect(
                                                    borderRadius: BorderRadius.circular(10.0),
                                                    child: Image.asset("assets/73.jpg",height: 40,width: 40,))),
                                            ),


                                          ],
                                        ),
                                      ],
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    postSender == _loggedInUser.email
                        ? Positioned(
                            left: -28,
                            top: -8,
                            child: MaterialButton(
                                height: 27,
                                onPressed: () {
                                  editTlabState(context);
                                },
                                color: Colors.red[700],
                                shape: CircleBorder(),
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                  size: 20,
                                )),
                          )
                        : Container(),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }



  call() {
    String phoneNumber = "tel:" + phone;
    launch(phoneNumber);
  }

  editTlabState(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30.0))),
            title: Center(
              child: Text(
                "تعديل حالة طلب التبرع",
                style: TextStyle(
                  fontFamily: 'Tajawal',
                  color: Colors.red[900],
                  fontSize: 20,
                ),
              ),
            ),
            elevation: 10,
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  child: Text(
                    'مستمر',
                    style: TextStyle(
                      fontFamily: 'Tajawal',
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () async {
                    try {
                      final result = await InternetAddress.lookup('google.com');
                      if (result.isNotEmpty &&
                          result[0].rawAddress.isNotEmpty) {
                        print("Connected to Mobile Network");
                        updatePostStateContinue();
                      }
                    } on SocketException catch (_) {
                      String invalid =
                          "Unable to connect. Please Check Internet Connection";

                      print(invalid);
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        EasyLoading.showError('لا يوجد اتصال بالانترنت');
                      });
                    }

                    Navigator.pop(context);
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  color: Colors.yellow[900],
                ),
                SizedBox(
                  width: 12,
                ),
                RaisedButton(
                  child: Text(
                    'انتهي',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Tajawal',
                    ),
                  ),
                  onPressed: () async {
                    try {
                      final result = await InternetAddress.lookup('google.com');
                      if (result.isNotEmpty &&
                          result[0].rawAddress.isNotEmpty) {
                        print("Connected to Mobile Network");
                        updatePostStateEnd();
                      }
                    } on SocketException catch (_) {
                      String invalid =
                          "Unable to connect. Please Check Internet Connection";

                      print(invalid);
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        EasyLoading.showError('لا يوجد اتصال بالانترنت');
                      });
                    }

                    Navigator.pop(context);
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  color: Colors.green,
                ),
              ],
            ),
          );
        });
  }
}
