import 'package:flutter/material.dart';
import '../../../constrants.dart';
import '../../../size_cofig.dart';

class IconBtnWithCounter extends StatelessWidget {
  const IconBtnWithCounter({
    Key key,
    this.iconSrc,
    this.numOfItems = 0,
    this.press,
  }) : super(key: key);

  final IconData iconSrc;
  final int numOfItems;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      borderRadius: BorderRadius.circular(50),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: EdgeInsets.all(
              getProportionateScreenWidth(0),
            ),
            height: getProportionateScreenWidth(80),
            width: getProportionateScreenWidth(80),
            decoration: BoxDecoration(
              color: cSecondaryColor.withOpacity(0.9),
              shape: BoxShape.circle,
            ),
            child: Icon(
              iconSrc,
              color: Colors.grey,
            ),
          ),
          if (numOfItems != 0)
            Positioned(
              top: -3,
              right: 0,
              child: Container(
                height: getProportionateScreenWidth(35),
                width: getProportionateScreenWidth(35),
                decoration: BoxDecoration(
                  color: Color(0xFF09af00),
                  shape: BoxShape.circle,
                  border: Border.all(width: 0, color: Colors.white),
                ),
                child: Center(
                  child: Text(
                    "$numOfItems",
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(23),
                      height: 1,
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
