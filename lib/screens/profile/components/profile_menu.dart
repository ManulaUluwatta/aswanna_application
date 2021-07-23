import 'package:aswanna_application/size_cofig.dart';
import 'package:flutter/material.dart';


class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key key,
    this.text,
    this.pic,
    this.press,
  }) : super(key: key);

  final String text;
  final IconData pic;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextButton(
        style: TextButton.styleFrom(
            primary: Color(0xFF61d800),
            // shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.circular(15))
                ),
        onPressed: press,
        child: Row(
          children: [
            Icon(
              pic,
              color: Color(0xFF41c300),
            ),
            SizedBox(
              width: 32,
            ),
            Expanded(
              child: Text(
                text,
                // style: TextStyle(
                //   color:Color(0xFF455A64),
                //   fontSize: 16
                // ),
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Color(0xFF41c300),
              size: getProportionateScreenWidth(30),
            ),
          ],
        ),
      ),
    );
  }
}
