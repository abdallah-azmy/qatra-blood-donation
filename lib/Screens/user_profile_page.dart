import 'package:flutter/material.dart';
import '../appBar_widget.dart';
import '../user_model.dart';
import 'package:url_launcher/url_launcher.dart';

class UserProfile extends StatefulWidget {
  final User user;

  const UserProfile({Key key, this.user}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
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
                            ))),
                        Padding(
                          padding: EdgeInsets.all(4),
                        ),
                        widget.user == null
                            ? Text(
                                "---",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20),
                                textAlign: TextAlign.center,
                              )
                            : Center(
                                child: Text(
                                  widget.user.displayName,
                                  style: TextStyle(
                                      fontFamily: 'Tajawal',
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 27),
//                          textAlign: TextAlign.center,
                                ),
                              ),
                        Padding(
                          padding: EdgeInsets.all(2),
                        ),
                        UserInfo(
                          user: widget.user,
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
}

class UserInfo extends StatefulWidget {
  final User user;

  const UserInfo({Key key, this.user}) : super(key: key);

  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  call() {
    String phoneNumber = "tel:" + widget.user.phone;
    launch(phoneNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                        leading: Icon(Icons.accessibility_new),
                        title: Text("فصيلة الدم :",
                            style: TextStyle(
                              fontFamily: 'Tajawal',
                            )),
                        subtitle: widget.user == null
                            ? Text(
                                "---",
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text(widget.user.fasila,
                                      textDirection: TextDirection.ltr,
                                      style: TextStyle(
                                          color: Colors.red[900],
                                          fontWeight: FontWeight.bold,
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
                        subtitle: widget.user == null
                            ? Text(
                                "---",
                              )
                            : SelectableText(widget.user.phone, onTap: () {
                                call();
                              },
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                    fontSize: 18)),
                      ),
                      ListTile(
                        leading: Icon(Icons.my_location),
                        title: Text("العنوان :",
                            style: TextStyle(
                              fontFamily: 'Tajawal',
                            )),
                        subtitle: widget.user == null
                            ? Text(
                                "---",
                              )
                            : Text(widget.user.address,
                                style: TextStyle(
                                    fontFamily: 'Tajawal',
                                    color: Colors.red[900],
                                    fontWeight: FontWeight.bold,
                                    fontSize: 19)),
                      ),
                      ListTile(
                        leading: Icon(Icons.email),
                        title: Text("البريد الالكتروني :",
                            style: TextStyle(
                              fontFamily: 'Tajawal',
                            )),
                        subtitle: widget.user == null
                            ? Text(
                                "---",
                              )
                            : Text(widget.user.email,
                                style: TextStyle(
                                    color: Colors.red[900],
                                    fontWeight: FontWeight.bold, fontSize: 18)),
                      ),
                      ListTile(
                          leading: Icon(Icons.person),
                          title: Text("موعد اخر تبرع :",
                              style: TextStyle(
                                fontFamily: 'Tajawal',
                              )),
                          subtitle: widget.user == null
                              ? Text("---")
                              : Text(widget.user.dateOfDonation,
                                  style: TextStyle(
                                      color: Colors.red[900],
                                      fontWeight: FontWeight.bold,
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
    );
  }
}
