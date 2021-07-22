// import 'dart:ffi';

import 'package:aswanna_application/constrants.dart';
import 'package:aswanna_application/screens/sign_in/sign_in_screen.dart';
import 'package:aswanna_application/size_cofig.dart';
import 'package:flutter/material.dart';
import '../components/splash_content.dart';

class Body extends StatefulWidget {
  // final int currentPageSplash;
  // final Function(int i) updateCurrentPage;
  const Body({Key key})
      : super(key: key);
  @override
  _BodyState createState() => _BodyState();
  getSheet() {
    _BodyState().getBottomSheet();
  }
}

class _BodyState extends State<Body> {
// Function(int i) up = updateCurrentPage;

  static final int numPages = 3;
  // final PageController _pageController = PageController(initialPage: 0);
  static int currentPage = 0;
  // PageController
  List<Map<String, String>> splashData = [
    {
      "text": "Originators at door step..",
      "image": "assets/images/doorStop.png",
      "text2":
          "We hook you up with hundreds of convenient rated sellers, so you’re never ended up with dissapointment. Search by product,\nplace and amount to have fresh inspiration at your fingertips. Finding all your crops is a fraction of the time."
          // "Lorem ipsum dolor sit amet, adipiscing consect, yet, by long-and vitality, so that labor, and do eiusmod."
    },
    {
      "text": "Why pay extra ?",
      "image": "assets/images/whyPayExtra.png",
      "text2":
          "Gone are the days of having to loose \nso much money in every single market.\nOnce you’ve landed on the gig you like, you can directly contact seller and talk to the price. No extortion, No bribes,No frauds, No halfway rupees at all. Just Place the order and  will take care of the rest. "
    },
    {
      "text": "Why take risks ?",
      "image": "assets/images/whyTake.png",
      "text2":
          "Safty applied when you are on the couch.\nWith your loved once. \nWe keep you out from  market clusters. Nothing is important than the life."
    },
  ];

  // static Function(int i) get updateCurrentPage => updateCurrentPage;

  
  @override
  Widget build(BuildContext context) {
    // print(context);
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
            padding: const EdgeInsets.symmetric(vertical: 2.0),
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
                    physics: ClampingScrollPhysics(),
                    onPageChanged: (value) {
                      setState(() {
                        currentPage = value;
                        // widget.updateCurrentPage(currentPage);
                        // Container(
                        //   child: getBottomSheet(),
                        // );
                      });
                      
                      if (currentPage == numPages - 1) {
                        showBottomSheet(
                            context: context,
                            builder: (context) => Container(
                                  height: 80.0,
                                  width: double.infinity,
                                  color: Colors.white,
                                  child: GestureDetector(
                                    onTap: () => Navigator.pushNamed(context, SignInScreen.routeName),
                                    child: Center(
                                      child: Text(
                                        "Get Started",
                                        style: TextStyle(
                                          color: Color(0xFF008b00),
                                          fontSize: 25.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ));
                      } else {
                        showBottomSheet(
                            context: context,
                            builder: (context) => Container(
                                  height: 0,
                                ));
                      }
                    },
                    itemCount: splashData.length,
                    itemBuilder: (context, index) => SplashContent(
                      image: splashData[index]["image"],
                      text2: splashData[index]["text2"],
                      text: splashData[index]["text"],
                    ),
                  ),
                ),
                // PageView.builder(
                //   onPageChanged: (value),
                //   itemBuilder: (context,index
                //   )
                //   ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(80),
                      vertical: getProportionateScreenHeight(10),
                    ),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Text(
                                          "Next",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 21.0),
                                        ),
                                        SizedBox(
                                          width: 10.0,
                                        ),
                                        Icon(
                                          Icons.arrow_forward,
                                          color: Colors.white,
                                          size: 25.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : Text(''),
                        //   currentPage == numPages - 1
                        //       ? Expanded(
                        //           child: SizedBox(
                        //             width: double.infinity,
                        //             height: getProportionateScreenHeight(50),
                        //             child: OutlinedButton(
                        //               onPressed: () {
                        //                 Navigator.pushNamed(context, SignInScreen.routeName);
                        //               },
                        //               style: ButtonStyle(
                        //                 shape: MaterialStateProperty.all(
                        //                   RoundedRectangleBorder(
                        //                     borderRadius:
                        //                         BorderRadius.circular(30.0),
                        //                   ),
                        //                 ),
                        //                 side:
                        //                     MaterialStateProperty.all(BorderSide(
                        //                   color: Colors.white,
                        //                   width: 2,
                        //                 )),
                        //               ),
                        //               child: const Text(
                        //                 "Get Started",
                        //                 style: TextStyle(
                        //                   fontSize: 22.0,
                        //                   color: Colors.white,
                        //                   fontWeight: FontWeight.w100,
                        //                 ),
                        //               ),
                        //             ),
                        //           ),
                        //         )
                        //       : Text(""),
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

  AnimatedContainer buildDot({int index}) {
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

  Container getBottomSheet() {
    // if (_BodyState.currentPage == 2) {
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
    // } else {
    //   return null;
    // }
  }
}
