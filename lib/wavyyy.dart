import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';



class Wavyyyy extends StatelessWidget  {

  Wavyyyy(
      {this.leftIcon,
        this.onPressedLeft,
        this.rightIcon,
        this.onPressedRight,
        this.title,
        this.backGroundColor,
        this.directionOfRightIcon});
  var leftIcon;
  var onPressedLeft;
  var rightIcon;
  var onPressedRight;
  var title;
  var backGroundColor;
  var directionOfRightIcon;



  MaskFilter _blur;
  final List<MaskFilter> _blurs = [
    null,
    MaskFilter.blur(BlurStyle.normal, 10.0),
    MaskFilter.blur(BlurStyle.inner, 10.0),
    MaskFilter.blur(BlurStyle.outer, 10.0),
    MaskFilter.blur(BlurStyle.solid, 16.0),
  ];
  int _blurIndex = 0;
  MaskFilter _nextBlur() {
    if (_blurIndex == _blurs.length - 1) {
      _blurIndex = 0;
    } else {
      _blurIndex = _blurIndex + 1;
    }
    _blur = _blurs[_blurIndex];
    return _blurs[_blurIndex];
  }
  @override
  Widget build(BuildContext context) {
    _buildCard({Config config, Color backgroundColor = Colors.transparent}) {
      return RotatedBox(
        quarterTurns: 2,
        child: WaveWidget(
          config: config,
          backgroundColor: backgroundColor,
          size: Size(MediaQuery.of(context).size.width, 120),
          waveAmplitude: 1,
        ),
      );
    }

    return SafeArea(
      child: Center(
        child: Stack(
          children: <Widget>[

            _buildCard(
              config: CustomConfig(
                gradients: [
                  [Colors.red, Colors.red[100]],
                  [Colors.red[300], Colors.red[500]],
                  [Colors.red[700], Colors.red[800]],
                  [Colors.red[900], Colors.red[900]]
                ],
                durations: [35000, 19440, 10800, 6000],
                heightPercentages: [0.20, 0.23, 0.25, 0.30],
                blur: _blur,
                gradientBegin: Alignment.bottomLeft,
                gradientEnd: Alignment.topRight,
              ),
            ),

            Positioned(
              left: 5,
              top: 0,
              child: IconButton(
                onPressed: onPressedLeft,
                icon: Icon(
                  leftIcon,
                  size: 25,
                  color: Colors.white,
                  textDirection: TextDirection.ltr,
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 45),
                child: Text(
                  "$title",
                  style: TextStyle(
                      fontFamily: 'Tajawal',
                      fontSize: 20,
                      color: Colors.white),
                ),
              ),
            ),
            Positioned(
              right: 5,
              top: 0,
              child: IconButton(
                onPressed: onPressedRight,
                icon: Directionality(
                  textDirection: directionOfRightIcon,
                  child: Icon(
                    rightIcon,
                    size: 25,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
//  @override
//  Size get preferredSize => new Size.fromHeight(kToolbarHeight);
}
