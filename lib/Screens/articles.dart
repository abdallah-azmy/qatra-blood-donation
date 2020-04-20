import 'package:flutter/material.dart';
import '../appBar_widget.dart';
import 'donation_article.dart';
import 'package:url_launcher/url_launcher.dart';

class Articles extends StatefulWidget {
  _ArticlesState createState() => _ArticlesState();
}

class _ArticlesState extends State<Articles> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: WaveAppBar(
            title: "مقالات",
            backGroundColor: Colors.grey[300],
            leftIcon: null,
            onPressedLeft: null,
            directionOfRightIcon: TextDirection.rtl,
            onPressedRight: null,
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
          body: Container(
            color: Colors.grey[300],
            child: SingleChildScrollView(
                child: Column(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => DonationArticle()));
                  },
                  child: Container(
                    margin: EdgeInsets.all(15.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Image.asset(
                            'assets/88.jpg',
                            height: 250,
                            fit: BoxFit.fitWidth,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "التبرع بالدم .. حقائق و إرشادات",
                                style: TextStyle(
                                    fontFamily: 'Tajawal',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 3),
                                child: Container(
                                  height: 35,
                                  width: 35,
                                  decoration: new BoxDecoration(
                                    color: Colors.grey[200],
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Text(
                                      "مهم",
                                      style: TextStyle(
                                          fontFamily: 'Tajawal',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: Colors.red[900]),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    _launchURL() async {
                      const url =
                          'https://www.moh.gov.sa/HealthAwareness/EducationalContent/Diseases/Hematology/Pages/009.aspx';
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
                        throw 'Could not launch $url';
                      }
                    }

                    _launchURL();
                  },
                  child: Container(
                    margin: EdgeInsets.all(15.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Image.asset(
                            'assets/33.jpg',
                            height: 250,
                            fit: BoxFit.fitWidth,
                          ),
                          Text(
                            "لماذا التبرع بالدم ؟",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'Tajawal',
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    _launchURL() async {
                      const url =
                          'https://www.emaratalyoum.com/local-section/health/2013-12-13-1.631357';
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
                        throw 'Could not launch $url';
                      }
                    }

                    _launchURL();
                  },
                  child: Container(
                    margin: EdgeInsets.all(15.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Image.asset(
                            'assets/44.jpg',
                            height: 250,
                            fit: BoxFit.fitWidth,
                          ),
                          Text(
                            "تعويض الدم المتبرع به",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'Tajawal',
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    _launchURL() async {
                      const url =
                          'https://arabic.rt.com/news/828610-%D8%AD%D9%82%D8%A7%D8%A6%D9%82-%D9%85%D9%87%D9%85%D8%A9-%D8%A7%D9%84%D8%AF%D9%85-%D8%A7%D9%84%D8%A8%D8%B4%D8%B1%D9%8A/';
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
                        throw 'Could not launch $url';
                      }
                    }

                    _launchURL();
                  },
                  child: Container(
                    margin: EdgeInsets.all(15.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Image.asset(
                            'assets/11.jpg',
                            height: 250,
                            fit: BoxFit.fitWidth,
                          ),
                          Text(
                            "حقائق مهمة غير معروفة عن الدم البشري",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'Tajawal',
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    _launchURL() async {
                      const url =
                          'https://www.webteb.com/articles/%D8%A7%D8%B4%D9%8A%D8%A7%D8%A1-%D9%8A%D8%AC%D8%A8-%D8%A7%D9%84%D8%A7%D9%86%D8%AA%D8%A8%D8%A7%D9%87-%D9%84%D9%87%D8%A7-%D9%82%D8%A8%D9%84-%D8%A7%D9%84%D8%AA%D8%A8%D8%B1%D8%B9-%D8%A8%D8%A7%D9%84%D8%AF%D9%85_20550';
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
                        throw 'Could not launch $url';
                      }
                    }

                    _launchURL();
                  },
                  child: Container(
                    margin: EdgeInsets.all(15.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Image.asset(
                            'assets/22.jpg',
                            height: 250,
                            fit: BoxFit.fitWidth,
                          ),
                          Text(
                            "أشياء يجب الإنتباه لها قبل التبرع بالدم",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'Tajawal',
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                )
              ],
            )),
          ),
        ),
      ),
    );
  }
}
