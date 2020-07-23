import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:icandoit/wavyyy.dart';
import 'package:url_launcher/url_launcher.dart';

import '../appBar_widget.dart';

class AboutTheApp extends StatefulWidget {
  @override
  _AboutTheAppState createState() => _AboutTheAppState();
}

class _AboutTheAppState extends State<AboutTheApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(

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
                child: Stack(

                  children: <Widget>[
                    Container(
                        height: 120,
                        child: Wavyyyy(
                          title: "عن التطبيق",
                          backGroundColor: Colors.white,
                          leftIcon: null,
                          onPressedLeft: null,
                          onPressedRight: null,
                          directionOfRightIcon: TextDirection.rtl,
                          rightIcon: null,
                        )),
                    Padding(
                      padding: const EdgeInsets.only(top: 100),
                      child: Expanded(
                        child: ListView(
                          padding: EdgeInsets.all(15.0),
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.all(Radius.circular(35))),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 25, right: 23, bottom: 3),
                                        child: Text(
                                          "عايز تتبرع بدم ؟",
                                          style: TextStyle(
                                              fontFamily: 'Tajawal',
                                              fontSize: 21,
                                              color: Colors.red[900]),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 10, top: 5, left: 10),
                                    child: Text(
                                        "بنوفرلك مصدر موثوق فيه للتبرع لانك هتتبرع علي طول للحالة المحتاجه "
                                        "وما عدتش هتكون معرض ان الدم اللي بتتبرع بيه يكون مصيره مجهول او ما  "
                                        "يطلعش للخير ، معدتش هتبقي معرض ان كيس الدم اللي بتتبرع بيه يفسد "
                                        "في تلاجات المستشفيات و هنوفرلك كل المعلومات الطبيه اللي محتاج "
                                        "تعرف علشان عملية التبرع .",
                                        style: TextStyle(fontSize: 16)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 15, right: 25, left: 25),
                                    child: Container(
                                      height: 1,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 20, right: 23, bottom: 3),
                                        child: Text(
                                          "محتاج نقل دم ؟",
                                          style: TextStyle(
                                              fontFamily: 'Tajawal',
                                              fontSize: 21,
                                              color: Colors.red[900]),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      right: 10,
                                      top: 5,
                                      left: 10,
                                    ),
                                    child: Text(
                                        "ابليكيشن قطرة بيوفرلك معلومات عن ناس من نفس فصيلة دمك ومن "
                                        "الفصايل اللي ينفع تتبرعلك زي ارقام تليفوناتهم و اماكنهم بحيث انك تلاقي  "
                                        "كيس الدم في اسرع وقت ، ما تشيلش هم ارتفاع سعر الكيس .",
                                        style: TextStyle(fontSize: 16)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 15, right: 25, left: 25, bottom: 3),
                                    child: Container(
                                      height: 1,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 20, right: 23, bottom: 3),
                                        child: Text(
                                          "عايز تعمل خير ؟",
                                          style: TextStyle(
                                              fontFamily: 'Tajawal',
                                              fontSize: 21,
                                              color: Colors.red[900]),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 10, top: 5, left: 10),
                                    child: Text(
                                        "تقدر تشارك وتنشر طلبات التبرع عندك علي مواقع السوشيال ميديا "
                                            "وتتفاعل مع صفحة التطبيق وتساعد المحتاج انه يوصل للمتبرع والعكس .. ممكن تنقذ حياة انسان "
                                            "بضغطة واحدة ومن غير ما تاخد بالك ! "
                                        ,
                                        style: TextStyle(fontSize: 16)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 15, right: 25, left: 25),
                                    child: Container(
                                      height: 1,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Center(
                                      child: Text(
                                        "قطرة واحده منك حياه بالنسبه لغيرك !",
                                        style: TextStyle(
                                          fontFamily: 'Tajawal',
                                          fontSize: 16,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.all(Radius.circular(35))),
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Center(
                                        child: Text(
                                          "تواصل معنا",
                                          style: TextStyle(
                                              fontFamily: 'Tajawal',
                                              fontSize: 18,
                                              color: Colors.red[900],
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )),
                                  Linkify(
                                    onOpen: (link) async {
                                      if (await canLaunch(link.url)) {
                                        await launch(link.url);
                                      } else {
                                        throw 'Could not launch $link';
                                      }
                                    },
                                    text: "Gmail : qaatra2020@gmail.com",
//                              options: LinkifyOptions(humanize: false),
                                    style: TextStyle(color: Colors.black, fontSize: 17),
                                    linkStyle:
                                        TextStyle(color: Colors.blue, fontSize: 17),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Linkify(
                                    onOpen: (link) async {
                                      if (await canLaunch(link.url)) {
                                        await launch(link.url);
                                      } else {
                                        throw 'Could not launch $link';
                                      }
                                    },
                                    text:
                                        "FaceBook : https://www.facebook.com/qat.ra.94",
//                              options: LinkifyOptions(humanize: false),
                                    style: TextStyle(color: Colors.black, fontSize: 15),
                                    linkStyle:
                                        TextStyle(color: Colors.blue, fontSize: 15),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(35))),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      RichText(textAlign: TextAlign.center,
                                          text: TextSpan(children: <TextSpan>[
                                        TextSpan(
                                          text:
                                              "التطبيق مشروع تخرج طلبة كلية الهندسة جامعة المنصورة ",
                                          style: TextStyle(
                                              fontFamily: 'Tajawal',
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        TextSpan(
                                          text: "قسم الاتصالات و الالكترونيات",
                                          style: TextStyle(
                                              fontFamily: 'Tajawal',
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ])),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 4,left: 4,top: 15,bottom: 4),
                                        child: Text(
                                          "عبدالله عزمي احمد",
                                          style: TextStyle(
                                              fontFamily: 'Tajawal',
                                              fontSize: 16,
                                              color: Colors.red[900],
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Text(
                                          "ايمان محمود محمد",
                                          style: TextStyle(
                                              fontFamily: 'Tajawal',
                                              fontSize: 16,
                                              color: Colors.red[900],
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Text(
                                          "مى ممدوح الطنطاوى",
                                          style: TextStyle(
                                              fontFamily: 'Tajawal',
                                              fontSize: 16,
                                              color: Colors.red[900],
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Text(
                                          "ولاء عابد جابر",
                                          style: TextStyle(
                                              fontFamily: 'Tajawal',
                                              fontSize: 16,
                                              color: Colors.red[900],
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Text(
                                          "نورا محمد فرج",
                                          style: TextStyle(
                                              fontFamily: 'Tajawal',
                                              fontSize: 16,
                                              color: Colors.red[900],
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Text(
                                          "اسماء مختار القفاص",
                                          style: TextStyle(
                                              fontFamily: 'Tajawal',
                                              fontSize: 16,
                                              color: Colors.red[900],
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Text(
                                          "سهيلة ابراهيم الشيخ",
                                          style: TextStyle(
                                              fontFamily: 'Tajawal',
                                              fontSize: 16,
                                              color: Colors.red[900],
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 11,bottom: 6),
                                        child: Text(
                                          "تحت اشراف",
                                          style: TextStyle(
                                              fontFamily: 'Tajawal',
                                              fontSize: 17,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Text(
                                          "م/ باسم مصطفى حسن",
                                          style: TextStyle(
                                              fontFamily: 'Tajawal',
                                              fontSize: 16,
                                              color: Colors.red[900],
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Text(
                                          "د/ ايهاب هانى عبدالحى",
                                          style: TextStyle(
                                              fontFamily: 'Tajawal',
                                              fontSize: 16,
                                              color: Colors.red[900],
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ))),
    );
  }
}
