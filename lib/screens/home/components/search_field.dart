import 'package:flutter/material.dart';
import '../../../constrants.dart';
import '../../../size_cofig.dart';

class SearchField extends StatelessWidget {
  final Function onSubmit;
  const SearchField({
    Key key, this.onSubmit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //width : SizeConfig.screenWidth! * 0.60,//60% of our width
      width: MediaQuery.of(context).size.width * 0.70,
      decoration: BoxDecoration(
        color: cSecondaryColor.withOpacity(1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        onChanged: (value) {
          //search value
        },
        decoration: InputDecoration(
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          hintText: "Search Products",
          prefixIcon: Icon(Icons.search),//
          contentPadding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(5),
            vertical: getProportionateScreenWidth(30),
          ),
        ),
        onSubmitted: onSubmit,
      ),
    );
  }
}
