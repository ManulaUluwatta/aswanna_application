import 'package:aswanna_application/constrants.dart';
import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    Key key,
    this.title,
    this.press,
  }) : super(key: key);
  final String title;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    // return Padding(
    //   padding: EdgeInsets.symmetric(
    //     horizontal: (getProportionateScreenWidth(20)),
    //   ),
    //   child: Row(
    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //     children: [
    //       Text(
    //         title,
    //         style: TextStyle(
    //           fontSize: getProportionateScreenWidth(35),
    //           color: Colors.black,
    //         ),
    //       ),
    //       GestureDetector(
    //         onTap: press,
    //         child: Text("See More")),
    //     ],
    //   ),
    // );
    return SizedBox(
      width: double.infinity,
      child: Text(
        title,
        style: TextStyle(
            color: cTextColor, fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
