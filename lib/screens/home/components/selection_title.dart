import 'package:flutter/material.dart';
import '../../../size_cofig.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    Key key, 
    this.text, 
    this.press,
  }) : super(key: key);
  final String text;
  final GestureTapCallback press;



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: (getProportionateScreenWidth(20)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: getProportionateScreenWidth(35),
              color: Colors.black,
            ),
          ),
          GestureDetector(
            onTap: press,
            child: Text("See More")),
        ],
      ),
    );
  }
}