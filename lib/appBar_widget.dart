import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

//// Curvy AppBar
class WaveAppBar extends StatelessWidget implements PreferredSizeWidget {
  WaveAppBar(
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

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size(
        null,
        100,
      ),
      child: SafeArea(
          child: Container(
            color: Colors.red[900],
            width: MediaQuery.of(context).size.width,
            // Set Appbar wave height
            child: Container(
              height: 80,
              color: Colors.red[900],
              child: Container(
                  color: backGroundColor,
                  child: Stack(
                    children: <Widget>[
                      RotatedBox(
                          quarterTurns: 2,
                          child: WaveWidget(
                            config: CustomConfig(
                              colors: [Colors.red[900]],
                              durations: [10000],
                              heightPercentages: [-0.1],
                            ),
                            size: Size(double.infinity, double.infinity),
                            waveAmplitude: 1,
                          )),
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
                          padding: const EdgeInsets.only(bottom: 2),
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
                  )),
            ),
          )),
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(kToolbarHeight);
}