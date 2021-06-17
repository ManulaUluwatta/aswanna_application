import 'dart:ffi';

import 'package:aswanna_application/constrants.dart';
import 'package:aswanna_application/size_cofig.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

import '../components/splash_content.dart';
import '../splash/splash_screen.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();

  getSheet() {
    return _BodyState().getBottomSheet();
  }
}

class _BodyState extends State<Body> {
  static final int numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  static int currentPage = 0;
  // PageController
  List<Map<String, String>> splashData = [
    {
      "text": "Connect people around the world",
      "image": "assets/images/slide_1.png",
      "text2":
          "Lorem ipsum dolor sit amet, adipiscing consect, yet, by long-and vitality, so that labor, and do eiusmod."
    },
    {
      "text": "Live your life smarter with us!",
      "image": "assets/images/slide_2.png",
      "text2":
          "Lorem ipsum dolor sit amet, adipiscing consect, yet, by long-and vitality, so that labor, and do eiusmod."
    },
    {
      "text": "Get a new experoence of imagination.",
      "image": "assets/images/slideNew_3.png",
      "text2":
          "Lorem ipsum dolor sit amet, adipiscing consect, yet, by long-and vitality, so that labor, and do eiusmod."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomCenter,
            stops: [0.1, 0.4, 0.7, 0.9],
            colors: [
              Color(0xFF61d800),
              Color(0xFF41c300),
              Color(0xFF09af00),
              Color(0xFF008b00),
            ],
          ),
          //   image: DecorationImage(
          //     fit: BoxFit.cover,
          //     image: AssetImage(
          //       "assets/images/farmer.jpg",
          //     ),
          //     colorFilter: ColorFilter.mode(
          //         Colors.black.withOpacity(0.2), BlendMode.dstATop),
          //   ),
        ),
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => print("Skip"),
                    child: Text(
                      'Skip',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: PageView.builder(
                    // physics: ClampingScrollPhysics(),
                    onPageChanged: (value) {
                      setState(() {
                        currentPage = value;
                      });
                    },
                    itemCount: splashData.length,
                    itemBuilder: (context, index) => SplashContent(
                      image: splashData[index]["image"],
                      text2: splashData[index]["text2"],
                      text: splashData[index]["text"],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(80)),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(splashData.length,
                              (index) => buildDot(index: index)),
                        ),
                        currentPage != numPages - 1
                            ? Expanded(
                                child: Align(
                                  alignment: FractionalOffset.bottomRight,
                                  child: TextButton(
                                    onPressed: () => print("Next"),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Text(
                                          "Next",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 22.0),
                                        ),
                                        SizedBox(
                                          width: 10.0,
                                        ),
                                        Icon(
                                          Icons.arrow_forward,
                                          color: Colors.white,
                                          size: 30.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : Text(''),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      
    );
  }

  AnimatedContainer buildDot({required int index}) {
    return AnimatedContainer(
      duration: cAnimationDuration,
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 12,
      decoration: BoxDecoration(
        color: currentPage == index ? Colors.white : Colors.white38,
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }

  Container? getBottomSheet() {
    if (_BodyState.currentPage == 2) {
      return Container(
        // child: _BodyState.currentPage == _BodyState.numPages - 1

        height: 80.0,
        width: double.infinity,
        color: Colors.white,
        child: GestureDetector(
          onTap: () => print("Get start"),
          child: Center(
            child: Text(
              "Get Started",
              style: TextStyle(
                color: Color(0xFF008b00),
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        // )
        // : Text(""),
      );
    } else {
      return null;
    }
  }
}
