import 'package:aswanna_application/components/top_rounded_container.dart';
import 'package:aswanna_application/screens/profile_detail_screen/components/profile_details.dart';
import 'package:aswanna_application/screens/profile_detail_screen/components/profile_pircture.dart';
import 'package:flutter/material.dart';

class ProfileActionsSection extends StatelessWidget {
  final String userID;
  const ProfileActionsSection({
    Key key,
    @required this.userID
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    final column = Column(
      children: [
        Stack(
          children: [
            TopRoundedContainer(
              child: ProfileDetail(userID: userID),
            ),
            Align(
              alignment: Alignment.topRight,
              child: ProfilePicture(userID: userID),
            ),
          ],
        ),
      ],
    ); return column;
  }

}