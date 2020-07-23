import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icandoit/wavyyy.dart';

import '../appBar_widget.dart';

class DonationArticle extends StatefulWidget {
  @override
  _DonationArticleState createState() => _DonationArticleState();
}

class _DonationArticleState extends State<DonationArticle> {
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
              body: SafeArea(
                child: Center(
                  child: Stack(
                    children: <Widget>[
                      Container(
                          height: 120,
                          color: Colors.transparent,
                          child: Wavyyyy(
                            title: "التبرع بالدم",
                            backGroundColor: Colors.white,
                            leftIcon: null,
                            onPressedLeft: null,
                            onPressedRight: null,
                            directionOfRightIcon: TextDirection.ltr,
                            rightIcon: null,
                          )),
                      Padding(
                        padding: const EdgeInsets.only(top: 90),
                        child: Expanded(
                          child: ListView(
                            padding: EdgeInsets.only(
                                right: 15, bottom: 15, left: 15, top: 20),
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(35))),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 25, right: 23, bottom: 3),
                                          child: Text(
                                            "فوائد التبرع بالدم :",
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
                                          "- زيادة نشاط نخاع العظم لإنتاج خلايا دم جديدة (كريات حمراء وكريات بيضاء وصفائح دموية) .",
                                          style: TextStyle(fontSize: 16)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 10, top: 5, left: 10),
                                      child: Text("- زيادة نشاط الدورة الدموية . ",
                                          style: TextStyle(fontSize: 16)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 10, top: 5, left: 10),
                                      child: Text(
                                          "-  التبرع بالدم يساعد علي تقليل نسبة الحديد في الدم لأنه يعتبر أحد أسباب الإصابة بأمراض  القلب وانسداد الشرايين . ",
                                          style: TextStyle(fontSize: 16)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 10, top: 5, left: 10),
                                      child: Text(
                                          "- اثبتت الدراسات أن الذين يتبرعون بدمهم مرة واحدة على الأقل كل سنة هم أقل عرضة للإصابة بأمراض  الدورة الدموية وسرطان الدم .",
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
                                              top: 25, right: 23, bottom: 3),
                                          child: Text(
                                            "شروط التبرع بالدم :",
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
                                          "- أن يكون المتبرع بصحة جيدة ولا يعاني أي أمراض معدية .",
                                          style: TextStyle(fontSize: 16)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 10, top: 5, left: 10),
                                      child: Text(
                                          "- أن يكون عمر المتبرع من 18-65 سنة . ",
                                          style: TextStyle(fontSize: 16)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 10, top: 5, left: 10),
                                      child: Text(
                                          "- يجب أن لا يقل وزن المتبرع عن 50 كجم .",
                                          style: TextStyle(fontSize: 16)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 10, top: 5, left: 10),
                                      child: Text(
                                          "- أن تكون نسبة الهيموجلوبين للرجال من 14- 17 جم وللنساء من 12-14 جم .",
                                          style: TextStyle(fontSize: 16)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 10, top: 5, left: 10),
                                      child: Text(
                                          "- أن يكون النبض بين 50-100 في الدقيقة .",
                                          style: TextStyle(fontSize: 16)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 10, top: 5, left: 10),
                                      child: Text(
                                          "- أن لا تزيد درجة الحرارة عن 37 درجة مئوية .",
                                          style: TextStyle(fontSize: 16)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 10, top: 5, left: 10),
                                      child: Text(
                                          "- أن يكون معدل ضغط الدم أقل من120/80 ملم زئبق .",
                                          style: TextStyle(fontSize: 16)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 10, top: 5, left: 10),
                                      child: Text(
                                          "- أن لا يكون المتبرع مصاب بالأمراض مزمنة ، مثل السكري ، ارتفاع ضغط الدم ، السرطان .",
                                          style: TextStyle(fontSize: 16)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 10, top: 5, left: 10),
                                      child: Text(
                                          "- أن لا يكون المتبرع مصاب بفقر الدم الحاد او بأمراض الدم الوراثية .",
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
                                              top: 25, right: 23, bottom: 3),
                                          child: Text(
                                            "أهمية التبرع بالدم :",
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
                                          "عملية نقل الدم من العمليات التي تسهم في إنقاذ الأرواح ؛ فيُعطى في مثل هذه الحالات :",
                                          style: TextStyle(fontSize: 17)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 10, top: 5, left: 10),
                                      child: Text(
                                          "- عند حدوث مضاعفات للسيدات الحوامل، مثل حالات النزف قبل الولادة أو خلالها أو بعدها . ",
                                          style: TextStyle(fontSize: 16)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 10, top: 5, left: 10),
                                      child: Text(
                                          "- للمرضى أثناء العمليات الجراحية مثل عمليات القلب، الأوعية الدموية، جراحة زراعة الأعضاء وغيرها . ",
                                          style: TextStyle(fontSize: 16)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 10, top: 5, left: 10),
                                      child: Text("- للمصابين بأمراض  الدم . ",
                                          style: TextStyle(fontSize: 16)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 10, top: 5, left: 10),
                                      child: Text("- للمصابين في الحوادث .",
                                          style: TextStyle(fontSize: 16)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 10, top: 5, left: 10),
                                      child: Text("- مرضى السرطان .",
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
                                              top: 25, right: 23, bottom: 3),
                                          child: Text(
                                            "نصائح بعد التبرع بالدم :",
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
                                          "- بعد التبرع تأخذ قسطًا من الراحة  وتتناول وجبة خفيفة وبعد 10 -15 دقيقة يمكنك مغادرة مكان التبرع .",
                                          style: TextStyle(fontSize: 16)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 10, top: 5, left: 10),
                                      child: Text(
                                          "- تجنب النشاط البدني الشاق أو رفع الأحمال الثقيلة لمدة 5 ساعات بعد التبرع . ",
                                          style: TextStyle(fontSize: 16)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 10, top: 5, left: 10),
                                      child: Text(
                                          "- عند الشعور بـالدوخة ينصح بالاستلقاء علي الظهر مع رفع القدمين .",
                                          style: TextStyle(fontSize: 16)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 10, top: 5, left: 10),
                                      child: Text("- الإكثار من شرب السوائل .",
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
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Center(
                                        child: Text(
                                          "قطرة واحده منك حياه بالنسبه لغيرك !",
                                          style: TextStyle(
                                              fontFamily: 'Tajawal',
                                              fontSize: 16,
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 40,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ))),
    );
  }
}