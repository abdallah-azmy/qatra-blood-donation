import 'package:flutter/material.dart';
import '../appBar_widget.dart';
import 'blazma_governrate_bank.dart';
import 'governrate_bank.dart';

class BlazmaBank extends StatefulWidget {
  @override
  _BlazmaBankState createState() => _BlazmaBankState();
}

class _BlazmaBankState extends State<BlazmaBank> {
  TextEditingController _search=new TextEditingController();

  var _cities = [
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
    "كفر الشيخ",
    "الفيوم",
    "قنا",
    "بني سويف",
    "اسوان",
    "دمياط",
    "الاسماعيلية",
    "الاقصر",
    "بور سعيد",
    "السويس",
    "مطروح",
    "شمال سيناء",
    "الوادي الجديد",
    "البحر الاحمر",
    "جنوب سيناء",
  ];

  var _searchShops = [
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
    "كفر الشيخ",
    "الفيوم",
    "قنا",
    "بني سويف",
    "اسوان",
    "دمياط",
    "الاسماعيلية",
    "الاقصر",
    "بور سعيد",
    "السويس",
    "مطروح",
    "شمال سيناء",
    "الوادي الجديد",
    "البحر الاحمر",
    "جنوب سيناء",
  ];

  _setSearchFilter(val){
    _cities=_searchShops.where((x)=>x.toString().contains("$val")).toList();
    setState(() {

    });
  }

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
                    builder: (context) => new BlazmaGovernrateBank(
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
            title: "بنك البلازما",
            backGroundColor: Colors.white,
            leftIcon: null,
            onPressedLeft: null,
            directionOfRightIcon: TextDirection.rtl,
            onPressedRight: () {
//              showSearch(context: context, delegate: DataSearch());
            },
//            rightIcon: Icons.search,
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
          body: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width-100,
                      child: TextFormField(
                        controller: _search,
                        onChanged: (val)=>_setSearchFilter(val),
                        decoration: InputDecoration(
                            labelText: 'ابحث',
                            labelStyle: TextStyle(
                              fontFamily: 'Tajawal',
                            ),
                            border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.circular(20.0),
                            ),
                            suffixIcon:  InkWell(
                              onTap: (){
                                setState(() {
                                  _search.text="";
                                });
                                _setSearchFilter("");
                              },
                              child: Icon(Icons.cancel,size: 25,color: Colors.black87,),),
                            prefixIcon: Icon(Icons.search)),

                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 70),
                child: ListView(
                  children: List.generate(_cities.length, (index){
                    return governrateCard(_cities[index]);
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
