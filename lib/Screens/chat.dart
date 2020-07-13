import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart' as intl;
import '../appBar_widget.dart';
import '../user_model.dart';
import 'user_profile_page.dart';
import 'package:icandoit/message_model.dart';

final _auth = FirebaseAuth.instance;
final _fireStore = Firestore.instance;
FirebaseUser loggedInUser;
String messageText;

Future<FirebaseUser> getCurrentUser() async {
  try {
    final user = await _auth.currentUser();
    if (user != null) {
      loggedInUser = user;
    }
  } catch (e) {
    print(e);
  }
}

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final messageController = TextEditingController();
  MessageModel messageModel;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: WaveAppBar(
        title: "الشات العام  ",
        backGroundColor: Colors.white,
        leftIcon: null,
        onPressedLeft: null,
        onPressedRight: () {
          Navigator.pop(context);
        },
        directionOfRightIcon: TextDirection.rtl,
        rightIcon: Icons.arrow_back_ios,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessagesStream(),
            Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[



                  Expanded(
                    child: Container(
                      height: 55,
                      margin: EdgeInsets.only(top: 7),
                      padding: EdgeInsets.only(bottom: 5, left: 3),
                      child: TextField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(top: 14, left: 16),
                          hintText: 'اكتب هنا',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                        ),
                        controller: messageController,
                        onChanged: (value) {
                          messageText = value;
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: FlatButton(
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),

                      color: Colors.red[900],
                      colorBrightness: Brightness.dark,

                      highlightColor: Colors.red,
                      padding:
                          EdgeInsets.symmetric(horizontal: 3.0, vertical: 4.0),
                      // gi

                      onPressed: () {
                        var now = new DateTime.now();
                        setState(() {
                          messageModel = MessageModel(
                            messageText: messageText,
                            sender: loggedInUser.email,
                            now: now,
                          );
                        });

                        if (messageController.text != "") {
                          _fireStore
                              .collection("messages")
                              .document(now.toString())
                              .setData(messageModel.toMap(messageModel));

                          messageController.clear();
                        }
                      },
                      child: Text(
                        "Send",
                        style: TextStyle(fontSize: 19),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MessagesStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _fireStore
            .collection("messages")
            .orderBy('date', descending: true)
            .snapshots(),
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
          final messages = snapshot.data.documents;
          List<MessageBubble> messageBubbles = [];
          for (var message in messages) {
            final messageText = message.data["text"];
            final messageSender = message.data["sender"];
            final date = message.data["date"].toDate();
            final currentUser = loggedInUser.email;

            final messageBubble = MessageBubble(
              date: date,
              sender: messageSender,
              text: messageText,
              isMe: currentUser == messageSender,
            );

            messageBubbles.add(messageBubble);
          }
          return Expanded(
            child: ListView(
              reverse: true,
              children: messageBubbles,
            ),
          );
        });
  }
}

class MessageBubble extends StatefulWidget {
  MessageBubble({this.sender, this.text, this.isMe, this.date});

  final String sender;
  final date;
  final String text;
  final bool isMe;

  @override
  _MessageBubbleState createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble> {
  User user;

  changeDateFormat() {
    String formattedDate = intl.DateFormat.yMd().add_jm().format(widget.date);
    return formattedDate;
  }

  creatAlertDialog(BuildContext context, senderName) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30.0))),
            title: Center(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new UserProfile(
                                user: user,
                              )));
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.account_circle,
                      color: Colors.blue,
                      size: 30,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Flexible(
                      child: Text(
                        senderName,
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            elevation: 10,
            content: Text(
              changeDateFormat(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          );
        });
  }

  Future<User> getSenderData() async {
    var _querySnapshot = await Firestore.instance
        .collection("users")
        .where("email", isEqualTo: widget.sender)
        .getDocuments();

    return User.fromMap(_querySnapshot.documents[0].data);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            widget.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            widget.sender,
            style: TextStyle(fontSize: 12, color: Colors.black54),
          ),
          InkWell(
            onTap: () async {
              var _user = await getSenderData();
              setState(() {
                user = _user;
              });

              creatAlertDialog(context, user.displayName);
            },
            child: Container(

              child: Material(
                borderRadius: widget.isMe
                    ? BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                        topLeft: Radius.circular(30))
                    : BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                        topRight: Radius.circular(30)),
                elevation: 5,
                color: widget.isMe ? Colors.blue : Colors.white,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Padding(
                    padding: widget.isMe ? const EdgeInsets.only(left: 10) : const EdgeInsets.only(right: 10),
                    child: Text(
                      widget.text,
                      style: TextStyle(
                          fontSize: 15,
                          color: widget.isMe ? Colors.white : Colors.black87),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
