import 'package:flutter/material.dart';
import '../appBar_widget.dart';
import 'governrate_bank.dart';

class BloodBank extends StatefulWidget {
  @override
  _BloodBankState createState() => _BloodBankState();
}

class _BloodBankState extends State<BloodBank> {
  var cairo = "القاهرة";
  var giza = "الجيزة";
  var sharqia = "الشرقية";
  var dakahlia = "الدقهلية";
  var bhira = "البحيرة";
  var elminia = "المنيا";
  var qaliobia = "القليوبية";
  var alex = "الاسكندرية";
  var gharbia = "الغربية";
  var sohag = "سوهاج";
  var asiot = "اسيوط";
  var mnofia = "المنوفية";
  var kafrelshikh = "كفر الشيخ";
  var faiom = "الفيوم";
  var qina = "قنا";
  var bniswif = "بني سويف";
  var aswan = "اسوان";
  var dmiat = "دمياط";
  var ismaeelia = "الاسماعيلية";
  var alaksur = "الاقصر";
  var borsaid = "بور سعيد";
  var suis = "السويس";
  var matrooh = "مطروح";
  var shamalsina = "شمال سيناء";
  var wadigdid = "الوادي الجديد";
  var bahrahmar = "البحر الاحمر";
  var ganobsina = "جنوب سيناء";

  Widget governrateCard(String city) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: null,
      child: Container(
        child: ListTile(
          onTap: () {
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => new GovernrateBank(
                          city: city,
                        )));
          },
          title: Center(
            child: Text(
              city,
              style: TextStyle(
                  fontFamily: 'Tajawal',
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: WaveAppBar(
            title: "بنك الدم",
            backGroundColor: Colors.white,
            leftIcon: null,
            onPressedLeft: null,
            directionOfRightIcon: TextDirection.rtl,
            onPressedRight: () {
              showSearch(context: context, delegate: DataSearch());
            },
            rightIcon: Icons.search,
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
          body: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    governrateCard(cairo),
                    governrateCard(giza),
                    governrateCard(sharqia),
                    governrateCard(dakahlia),
                    governrateCard(bhira),
                    governrateCard(elminia),
                    governrateCard(qaliobia),
                    governrateCard(alex),
                    governrateCard(gharbia),
                    governrateCard(sohag),
                    governrateCard(asiot),
                    governrateCard(mnofia),
                    governrateCard(kafrelshikh),
                    governrateCard(faiom),
                    governrateCard(qina),
                    governrateCard(bniswif),
                    governrateCard(aswan),
                    governrateCard(dmiat),
                    governrateCard(ismaeelia),
                    governrateCard(alaksur),
                    governrateCard(borsaid),
                    governrateCard(suis),
                    governrateCard(matrooh),
                    governrateCard(shamalsina),
                    governrateCard(wadigdid),
                    governrateCard(bahrahmar),
                    governrateCard(ganobsina),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DataSearch extends SearchDelegate<String> {
  final cities = [
    "القاهرة",
    "الجيزة",
    "الشرقية",
    "الدقهلية",
    "البحيرة",
    "المنيا",
    "القليوبية",
    "الاسكندرية",
    "الغربية",
    "سوهاج",
    "اسيوط",
    "المنوفية",
    "الفيوم",
    "قنا",
    "بني سويف",
    "كفر الشيخ",
    "اسوان",
    "دمياط",
    "الاسماعيلية",
    "الاقصر",
    "بور سعيد",
    "اسيوط",
    "مطروح",
    "شمال سيناء",
    "البحر الاحمر",
    "الوادي الجديد",
    "جنوب سيناء",
  ];

  final recentCities = [
    "القاهرة",
    "الجيزة",
    "الشرقية",
    "الدقهلية",
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      Padding(
        padding: const EdgeInsets.only(top: 12),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: IconButton(
            icon: Padding(
              padding: const EdgeInsets.only(top: 12),
              child: AnimatedIcon(
//            textDirection: TextDirection.rtl,
                icon: AnimatedIcons.menu_arrow,
                progress: transitionAnimation,
                size: 25,
              ),
            ),
            onPressed: () {
              close(context, null);
            },
          ),
        ),
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      icon: Icon(Icons.clear),
      onPressed: () {
        query = "";
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    final suggestedList = query.isEmpty
        ? recentCities
        : cities.where((p) => p.startsWith(query)).toList();
    return ListView.builder(
      itemBuilder: (context, index) => Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: null,
        child: Container(
          child: ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new GovernrateBank(
                            city: suggestedList[index],
                          )));
            },
            title: Center(
              child: Text(
                suggestedList[index],
                style: TextStyle(
                    fontFamily: 'Tajawal',
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
          ),
        ),
      ),
      itemCount: suggestedList.length,
    );
  }
}
