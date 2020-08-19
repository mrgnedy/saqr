import 'package:flutter/material.dart';
import 'package:saqr/screens/HomePage/View.dart';
import 'package:simple_animations/simple_animations.dart';

import 'package:supercharged/supercharged.dart';

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage>
    with TickerProviderStateMixin {
  int select = 0;
  Animation _containerRadiusAnimation,
      _containerSizeAnimation,
      _containerColorAnimation;
  AnimationController _containerAnimationController;
  @override
  void initState() {
    super.initState();
    _containerAnimationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 3500));

    _containerRadiusAnimation = BorderRadiusTween(
            begin: BorderRadius.circular(100.0),
            end: BorderRadius.circular(0.0))
        .animate(CurvedAnimation(
            curve: Curves.slowMiddle, parent: _containerAnimationController));

    _containerSizeAnimation = Tween(begin: 0.0, end: 2.0).animate(
        CurvedAnimation(
            curve: Curves.ease, parent: _containerAnimationController));

    _containerColorAnimation =
        ColorTween(begin: Colors.white, end: Colors.white).animate(
            CurvedAnimation(
                curve: Curves.ease, parent: _containerAnimationController));

    _containerAnimationController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _containerAnimationController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedBuilder(
            animation: _containerAnimationController,
            builder: (context, index) {
              return Container(
                width: _containerSizeAnimation.value * height,
                height: _containerSizeAnimation.value * height,
                decoration: BoxDecoration(
                    borderRadius: _containerRadiusAnimation.value,
                    color: _containerColorAnimation.value),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      // Spacer(),
                      select == 0
                          ? cell(
                              "assets/pg1.png",
                              "تطبيق صقر يوفر لك كثير من الخدمات التي تحتاجها",
                            )
                          : select == 1
                              ? cell(
                                  "assets/pg2.png",
                                  "قم بالبحث عن الخدمة التي تريدها",
                                )
                              : cell(
                                  "assets/pg3.png",
                                  "حدد موقعك و هيصلك اقرب مقدم خدمة",
                                ),
                      // Spacer(),
                      Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * .08,
                          child: select == 0
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.arrow_back,
                                            size: 25,
                                            color: Colors.black,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                select++;
                                              });
                                            },
                                            child: Text(
                                              "التالي",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: "thin",
                                                  fontSize: 15),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: <Widget>[
                                          ClipOval(
                                            child: Container(
                                              width: 8,
                                              height: 8,
                                              color: select == 2
                                                  ? Colors.black
                                                  : Colors.grey,
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.all(8),
                                            width: 30,
                                            height: 8,
                                            color: select == 1
                                                ? Colors.black
                                                : Colors.grey,
                                          ),
                                          ClipOval(
                                            child: Container(
                                              width: 8,
                                              height: 8,
                                              color: select == 0
                                                  ? Colors.black
                                                  : Colors.grey,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              : Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.arrow_back,
                                            size: 25,
                                            color: Colors.black,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                select++;
                                                if (select == 3) {
                                                  Navigator.pushAndRemoveUntil(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) {
                                                    return HomePage();
                                                  }),
                                                      (Route<dynamic> route) =>
                                                          false);
                                                }
                                              });
                                            },
                                            child: Text(
                                              "التالي",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: "thin",
                                                  fontSize: 15),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: <Widget>[
                                        ClipOval(
                                          child: Container(
                                            width: 8,
                                            height: 8,
                                            color: select == 2
                                                ? Colors.black
                                                : Colors.grey,
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.all(8),
                                          width: 30,
                                          height: 8,
                                          color: select == 1
                                              ? Colors.black
                                              : Colors.grey,
                                        ),
                                        ClipOval(
                                          child: Container(
                                            width: 8,
                                            height: 8,
                                            color: select == 0
                                                ? Colors.black
                                                : Colors.grey,
                                          ),
                                        )
                                      ],
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          select--;
                                        });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: <Widget>[
                                            Text(
                                              "السابق",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: "thin",
                                                  fontSize: 15),
                                            ),
                                            Icon(
                                              Icons.arrow_forward,
                                              size: 25,
                                              color: Colors.black,
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ))
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }

  Widget cell(String image, String lable) {
    return Container(
      height: MediaQuery.of(context).size.height * .9,
      child: Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * .6,
            // alignment: Alignment.center,c
            // color: Colors.red,
            child: Image.asset(
              image,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * .6,
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: PlayAnimation<double>(
              duration: 400.milliseconds,
              tween: 0.0.tweenTo(80.0),
              builder: (context, child, height) {
                return PlayAnimation<double>(
                  duration: 1200.milliseconds,
                  delay: 500.milliseconds,
                  tween: 2.0.tweenTo(300.0),
                  builder: (context, child, width) {
                    return Center(
                      child: Container(
                        // decoration: boxDecoration,
                        // width: width,
                        // height: height,
                        child: isEnoughRoomForTypewriter(width)
                            ? TypewriterText(lable)
                            : Container(),
                      ),
                    );
                  },
                );
              },
            ),
          )
          // Padding(
          //   padding: const EdgeInsets.only(right: 30, left: 30),
          //   child: Text(
          //     lable,
          //     textAlign: TextAlign.center,
          //     style: TextStyle(
          //         fontFamily: "thin",
          //         fontSize: 23,
          //         color: Colors.black,
          //         fontWeight: FontWeight.bold),
          //   ),
          // ),
        ],
      ),
    );
  }

  bool isEnoughRoomForTypewriter(double width) => width > 20;
}

class TypewriterText extends StatelessWidget {
  static const TEXT_STYLE = TextStyle(
      fontFamily: "thin",
      fontSize: 23,
      color: Colors.black,
      fontWeight: FontWeight.bold);

  final String text;

  TypewriterText(this.text);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: PlayAnimation<int>(
          duration: 800.milliseconds,
          delay: 800.milliseconds,
          tween: 0.tweenTo(text.length),
          builder: (context, child, textLength) {
            return Text(text.substring(0, textLength),
                textAlign: TextAlign.center, style: TEXT_STYLE);
          }),
    );
  }
}
