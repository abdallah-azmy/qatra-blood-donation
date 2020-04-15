import 'package:flutter/material.dart';
import 'login_page.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.pushReplacement(context,
        new MaterialPageRoute(builder: (BuildContext context) => LoginPage()));
  }

  Widget _buildImage(String assetName) {
    return Align(
      child: ClipRRect(
          borderRadius: BorderRadius.circular(40.0),
          child: Image.asset(
            'assets/$assetName.jpg',
            width: 350.0,
          )),
      alignment: Alignment.bottomCenter,
    );
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle =
    TextStyle(fontSize: 19.0, fontFamily: "Tajawal", color: Colors.white);
    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(
          fontSize: 30.0,
          fontWeight: FontWeight.w700,
          fontFamily: "Tajawal",
          color: Colors.black87),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Color(0xFFD32F2F),
      imagePadding: EdgeInsets.zero,
    );

    return Directionality(
      textDirection: TextDirection.rtl,
      child: IntroductionScreen(
        showSkipButton: false,
        key: introKey,
        pages: [
          PageViewModel(
            title: "ساعدنا نكبر بنك الدم",
            body:
            "ادخل علي صفحة بنك الدم و ضيف حسابك في محافظتك و لو معاك معلومات عن متبرعين"
                " ضيفهم علشان نقدر نغطي كل الفصايل في كل محافظات مصر ",
            image: _buildImage('intro1'),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: "اضافة طلب تبرع",
            body:
            "لو محتاج نقل دم او حد تعرفه محتاج , تقدر تعمل طلب تبرع في الصفحة الرئيسية ",
            image: _buildImage('boardingDrop'),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: "اهلا بيك",
            bodyWidget: Text("قطرة واحدة منك .. حياة بالنسبه لغيرك",
                style: TextStyle(
                    fontSize: 18.0,
                    fontFamily: "Tajawal",
                    color: Colors.white)),
            image: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Align(
                child: Image.asset(
                  'assets/fainallogo.png',
                  color: Colors.white,
                  scale: 12,
                ),
                alignment: Alignment.bottomCenter,
              ),
            ),
            decoration: pageDecoration,
          ),
        ],
        onDone: () => _onIntroEnd(context),
        //onSkip: () => _onIntroEnd(context), // You can override onSkip callback

        skipFlex: 0,
        nextFlex: 0,

        next: const Icon(Icons.arrow_forward),
        done: const Text('تخطي',
            style: TextStyle(fontSize: 20.0, fontFamily: "Tajawal")),
        dotsDecorator: const DotsDecorator(
          size: Size(10.0, 10.0),
          color: Color(0xFFBDBDBD),
          activeSize: Size(22.0, 10.0),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
        ),
      ),
    );
  }
}
