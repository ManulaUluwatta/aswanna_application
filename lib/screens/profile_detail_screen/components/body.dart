import 'package:aswanna_application/screens/profile_detail_screen/components/profile_action.dart';
import 'package:flutter/material.dart';

import '../../../size_cofig.dart';

class Body extends StatelessWidget {
  final String userID;

  const Body({
    Key key,
    @required this.userID,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(20),), 
        child: Column(
          children: [
            ProfileActionsSection(userID: userID),
          ],
        ),
        )
      ),
    );
  }
}