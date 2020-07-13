import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'blazma_bank.dart';
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
import 'dart:io';
import 'package:social_share_plugin/social_share_plugin.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:icandoit/appBar_widget.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';
import 'package:share_extend/share_extend.dart';

final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

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

  static IconData backIcon(BuildContext context) {
    switch (Theme.of(context).platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        return Icons.arrow_back;
      case TargetPlatform.iOS:
        return Icons.arrow_back_ios;
    }
    assert(false);
    return null;
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.red[900]);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
//        theme: ThemeData.dark(),
      home: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            key: _key,
            resizeToAvoidBottomPadding: false,
            appBar: WaveAppBar(
              title: "طلبات التبرع",
              backGroundColor: Colors.grey[300],
              leftIcon: null,
              onPressedLeft: null,
              onPressedRight: () {
                _key.currentState.openDrawer();
              },
              directionOfRightIcon: TextDirection.ltr,
              rightIcon: Icons.dehaze,
            ),
            floatingActionButton: Padding(
                padding: const EdgeInsets.only(right: 20, top: 20),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => new TalabTabaro3()));
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
            drawer: Opacity(
              opacity: .9,
              child: Drawer(
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
                            elevation: 10,
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
                            elevation: 10,
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
                                              new BlazmaBank()));
                                },
                                title: Row(
                                  children: <Widget>[
                                    Text(
                                      "بنك البلازما",
                                      style: TextStyle(
                                          fontFamily: 'Tajawal',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    SizedBox(width: 7,),
                                    Text(
                                      "( المتعافين )",
                                      style: TextStyle(
                                          fontFamily: 'Tajawal',
//                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87.withOpacity(.5),
                                          fontSize: 14),
                                    ),
                                  ],
                                ),
                                leading: Icon(Icons.add_circle_outline,
                                    size: 30, color: Colors.red[900]),
                                trailing: null,
                              ),
                            ),
                          ),
                          Card(
                            elevation: 10,
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
                            elevation: 10,
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
                            elevation: 10,
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
                            elevation: 10,
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
                            elevation: 10,
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
            ),
            body: GestureDetector(
              onPanUpdate: (details) {
                if (details.delta.dx > 20)
                  print("Dragging in +X direction");
                else
                  _key.currentState.openDrawer();
                print("Dragging in -X direction");
              },
              child: Container(
                decoration: new BoxDecoration(
                  color: Colors.grey[300],
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding:
                          const EdgeInsets.only(top: 10, right: 10, left: 10),
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
                          return Container(
                            height: 150,
                            child: Center(
                              child: CircularProgressIndicator(
                                backgroundColor: Colors.red[900],
                              ),
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
                          final hospitalAddress = post.data["hospitalAddress"];
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
//                              height: 170.0,
                            child: ListView(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 4, vertical: 15),
                              children: postBubbles,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}

class PostBubble extends StatefulWidget {
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

  @override
  _PostBubbleState createState() => _PostBubbleState();
}

class _PostBubbleState extends State<PostBubble> {
  changeDateFormat() {
    String formattedDate = intl.DateFormat.yMMMMd('en_US').add_jm().format(widget.date);
    return formattedDate;
  }

  changeColor() {
    if (widget.postColor == true) {
      return widget.postSender == _loggedInUser.email
          ? Colors.yellow[600]
          : Colors.white;
    } else {
      return Colors.green[200];
    }
  }

  updatePostStateEnd() async {
    await _fireStore
        .collection('post')
        .document(widget.dateThatSignsThePost)
        .updateData({'postColor': false});
  }

  updatePostStateContinue() async {
    await _fireStore
        .collection('post')
        .document(widget.dateThatSignsThePost)
        .updateData({'postColor': true});
  }

  deletePost() async {
    await _fireStore
        .collection('post')
        .document(widget.dateThatSignsThePost)
        .delete();
  }

  var fasilaTwiter;

  GlobalKey _globalKey = new GlobalKey();

  Future capturePNG() async {
    try {
      if (await Permission.contacts.request().isGranted) {}

      Map<Permission, PermissionStatus> statuses = await [
        Permission.storage,
      ].request();

      RenderRepaintBoundary boundary =
          _globalKey.currentContext.findRenderObject();
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      final directory = (await getExternalStorageDirectory()).path;
      ByteData byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData.buffer.asUint8List();
      String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();
      final String dirPath = '${directory}/Pictures';
      await Directory(dirPath).create(recursive: true);
      final String filePath = '$dirPath/${timestamp()}.jpg';
      File imgFile = new File('$filePath');


      setState(() {
        imgFile.writeAsBytes(pngBytes);
      });

      shareImage(BuildContext contex) {
        return showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0))),
//                  elevation: 10,
                  actions: <Widget>[
                    Stack(
                      children: <Widget>[
                        RaisedButton(
                          child: Center(
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.share,
                                  size: 20,
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  'ساعد',
                                  style: TextStyle(
                                      fontFamily: 'Tajawal',
                                      color: Colors.white,
                                      fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                          onPressed: () async {
                            ShareExtend.share(filePath, "image");
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          color: Colors.red[900],
                        ),
                      ],
                    ),
                  ],
                  content: Image.file(imgFile));
            });
      }

      shareImage(context);


    } catch (e) {
      print("False");
      print(e);
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.fasila == "A+") {
      fasilaTwiter = "${widget.fasila}موجب";
    } else if (widget.fasila == "AB+") {
      fasilaTwiter = "${widget.fasila}موجب";
    } else if (widget.fasila == "O+") {
      fasilaTwiter = "${widget.fasila}موجب";
    } else if (widget.fasila == "B+") {
      fasilaTwiter = "${widget.fasila}موجب";
    } else {
      fasilaTwiter = widget.fasila;
    }

    return RepaintBoundary(
      key: _globalKey,
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: const Color(0x29000000),
              offset: Offset(2, 5),
              blurRadius: 6)
        ], borderRadius: BorderRadius.circular(25), color: changeColor()),
        width: double.infinity,
//      height: 159,
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
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
                                  widget.postColor == true
                                      ? widget.fasila
                                      : "طلب التبرع هذا قد تم",
                                  textDirection: TextDirection.ltr,
                                  style: TextStyle(
                                    fontFamily: 'Tajawal',
                                    color: Colors.red[900],
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 15),
                              child: Row(
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
                                    child: Text(
                                        "${widget.government} -- ${widget.city}",
                                        style: TextStyle(
                                            fontFamily: 'Tajawal',
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red[500],
                                            fontSize: 16,
                                            letterSpacing: .3)),
                                  ),
                                ],
                              ),
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
                                  child: RichText(
                                    text: TextSpan(children: <TextSpan>[
                                      TextSpan(
                                        text: 'اسم الحالة :',
                                        style: TextStyle(
                                            fontFamily: 'Tajawal',
                                            color: Colors.grey[800],
                                            fontSize: 16,
                                            letterSpacing: .3),
                                      ),
                                      TextSpan(
                                        text: ' ${widget.name}',
                                        style: TextStyle(
                                            fontFamily: 'Tajawal',
                                            color: Colors.red[500],
                                            fontSize: 16,
                                            letterSpacing: .3),
                                      ),
                                    ]),
                                  ),
                                )
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
                                          widget.postColor == true
                                              ? Row(
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
                                                      child: SelectableText(
                                                          "${widget.phone}",
                                                          onTap: () {
                                                        call();
                                                      },
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
                                                )
                                              : Row(
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
                                                      child: Text("-----------",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .lightBlueAccent,
                                                              fontSize: 16,
                                                              letterSpacing:
                                                                  .3)),
                                                    ),
                                                  ],
                                                ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Container(
                                            height: 1,
                                            color: Colors.grey[400],
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
                                                child: RichText(
                                                  text: TextSpan(children: <
                                                      TextSpan>[
                                                    TextSpan(
                                                      text: 'عدد الأكياس :',
                                                      style: TextStyle(
                                                          fontFamily: 'Tajawal',
                                                          color:
                                                              Colors.grey[800],
                                                          fontSize: 14,
                                                          letterSpacing: .3),
                                                    ),
                                                    TextSpan(
                                                      text: ' ${widget.akias}',
                                                      style: TextStyle(
                                                          fontFamily: 'Tajawal',
                                                          color:
                                                              Colors.red[500],
                                                          fontSize: 16,
                                                          letterSpacing: .3),
                                                    ),
                                                  ]),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Container(
                                            height: 1,
                                            color: Colors.grey[400],
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
                                                child: Row(
                                                  children: <Widget>[
                                                    Flexible(
                                                      child: RichText(
                                                        text:
                                                            TextSpan(children: <
                                                                TextSpan>[
                                                          TextSpan(
                                                            text:
                                                                'اسم المستشفي :',
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'Tajawal',
                                                                color: Colors
                                                                    .grey[800],
                                                                fontSize: 14,
                                                                letterSpacing:
                                                                    .3),
                                                          ),
                                                        ]),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 2,
                                                    ),
                                                    Flexible(
                                                      child: RichText(
                                                        text: TextSpan(
                                                          text:
                                                              '${widget.hospital}',
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Tajawal',
                                                              color: Colors
                                                                  .red[500],
                                                              fontSize: 16,
                                                              letterSpacing:
                                                                  .3),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Container(
                                            height: 1,
                                            color: Colors.grey[400],
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
                                                child: Row(
                                                  children: <Widget>[
                                                    RichText(
                                                      text: TextSpan(children: <
                                                          TextSpan>[
                                                        TextSpan(
                                                          text:
                                                              'عنوان المستشفي :',
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Tajawal',
                                                              color: Colors
                                                                  .grey[800],
                                                              fontSize: 14,
                                                              letterSpacing:
                                                                  .3),
                                                        ),
                                                      ]),

//
                                                    ),
                                                    SizedBox(
                                                      width: 2,
                                                    ),
                                                    Flexible(
                                                      child: RichText(
                                                        text: TextSpan(
                                                          text:
                                                              '${widget.hospitalAddress}',
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Tajawal',
                                                              color: Colors
                                                                  .red[500],
                                                              fontSize: 16,
                                                              letterSpacing:
                                                                  .3),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Container(
                                            height: 1,
                                            color: Colors.grey[400],
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
                                                child: Row(
                                                  children: <Widget>[
                                                    RichText(
                                                      text: TextSpan(children: <
                                                          TextSpan>[
                                                        TextSpan(
                                                          text: 'ملاحظة :',
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Tajawal',
                                                              color: Colors
                                                                  .grey[800],
                                                              fontSize: 14,
                                                              letterSpacing:
                                                                  .3),
                                                        ),
                                                      ]),
                                                    ),
                                                    SizedBox(
                                                      width: 2,
                                                    ),
                                                    Flexible(
                                                        child: RichText(
                                                      text: TextSpan(
                                                        text: '${widget.note}',
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Tajawal',
                                                            color:
                                                                Colors.red[500],
                                                            fontSize: 16,
                                                            letterSpacing: .3),
                                                      ),
                                                    ))
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Container(
                                            height: 1,
                                            color: Colors.grey[400],
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Column(
                                            children: <Widget>[
                                              SizedBox(
                                                height: 3,
                                              ),
                                              Text("_ شارك طلب التبرع _",
                                                  style: TextStyle(
                                                      fontFamily: 'Tajawal',
                                                      color: Colors.grey[800],
                                                      fontSize: 16,
                                                      letterSpacing: .3)),
                                              SizedBox(
                                                height: 3,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  InkWell(
                                                      onTap: () async {
                                                        await SocialSharePlugin.shareToTwitterLink(
                                                            text: "مطلوب متبرع بالدم .. \n"
                                                                "الفصيلة : + $fasilaTwiter\n"
                                                                "${widget.government} -- ${widget.city}\n"
                                                                "الاسم :   ${widget.name}\n"
                                                                "رقم المرافق :   ${widget.phone}\n"
                                                                "\nتطبيق * قطرة * للتبرع بالدم",
                                                            url: '\nhttps://play.google.com/store/apps/details?id=com.abdallahazmy.icandoit');
                                                      },
                                                      child: Tab(
                                                        icon: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                            child: Image.asset(
                                                              "assets/72.jpg",
                                                              height: 40,
                                                              width: 40,
                                                            )),
                                                      )),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      FlutterShareMe().shareToWhatsApp(
                                                          msg: "مطلوب متبرع بالدم .. \n"
                                                              "الفصيلة :  ${widget.fasila}\n"
                                                              "${widget.government} -- ${widget.city}\n"
                                                              "الاسم :   ${widget.name}\n"
                                                              "رقم المرافق :  ${widget.phone}\n"
                                                              '\nتطبيق * قطرة * للتبرع بالدم'
                                                              '\nhttps://play.google.com/store/apps/details?id=com.abdallahazmy.icandoit');
                                                    },
                                                    child: Tab(
                                                        icon: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                            child: Image.asset(
                                                              "assets/73.jpg",
                                                              height: 40,
                                                              width: 40,
                                                            ))),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      print("kkkkkkk");

                                                      capturePNG();
                                                    },
                                                    child: Tab(
                                                        icon: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.0),
                                                            child: Container(
                                                              color: Colors
                                                                  .cyan[300],
                                                              child:
                                                                  Image.asset(
                                                                "assets/ssch.png",
                                                                color: Colors
                                                                    .black,
                                                                height: 39,
                                                                width: 39,
                                                              ),
                                                            ))),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 2,
                                              ),
                                              Opacity(
                                                opacity: .9,
                                                child: Image.asset(
                                                  "assets/fainallogo.png",
                                                  height: 45,
                                                  width: 45,
                                                ),
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
                      widget.postSender == _loggedInUser.email
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
                      widget.postSender == _loggedInUser.email
                          ? Positioned(
                              left: -28,
                              top: 30,
                              child: MaterialButton(
                                  height: 27,
                                  onPressed: () {
                                    deleteTlab(context);
                                  },
                                  color: Colors.red[700],
                                  shape: CircleBorder(),
                                  child: Icon(
                                    Icons.delete,
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
      ),
    );
  }

  call() {
    String phoneNumber = "tel:" + widget.phone;
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
                      showNotification("تم اضافة حسابك بنجاح", _key);
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
                        showNotification("لا يوجد اتصال بالانترنت !", _key);
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

  deleteTlab(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30.0))),
            title: Center(
              child: Text(
                "مسح طلب التبرع",
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
                    'تراجع',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Tajawal',
                    ),
                  ),
                  onPressed: () async {
                    Navigator.pop(context);
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  color: Colors.green,
                ),
                SizedBox(
                  width: 12,
                ),
                RaisedButton(
                  child: Text(
                    'مسح',
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
                        deletePost();
                      }
                    } on SocketException catch (_) {
                      showNotification("حدث خطأ اثناء اتمام العملية", _key);
                    }

                    Navigator.pop(context);
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  color: Colors.yellow[900],
                ),
              ],
            ),
          );
        });
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
