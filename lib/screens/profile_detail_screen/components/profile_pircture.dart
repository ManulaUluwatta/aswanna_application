
import 'package:aswanna_application/services/database/user_database_service.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../../../constrants.dart';
import '../../../size_cofig.dart';

class ProfilePicture extends StatelessWidget {
  final String userID;
  const ProfilePicture({
    Key key,
    @required this.userID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          // CircleAvatar(
          //   backgroundImage: AssetImage(
          //     "assets/images/profile.png"
          //   ),
          //   backgroundColor: Colors.white,
          // ),
          buildDisplayPictureAvatar(context),
        ],
      ),
    );
  }

  Widget buildDisplayPictureAvatar(BuildContext context) {
    return StreamBuilder(
      stream: UserDatabaseService().getSellerDetails(userID),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          final error = snapshot.error;
          Logger().w(error.toString());
        }
        ImageProvider backImage;
        if (snapshot.hasData && snapshot.data != null) {
          final String url = snapshot.data.data()[UserDatabaseService.DP_KEY];
          if (url != null) backImage = NetworkImage(url);
        }
        return CircleAvatar(
          radius: SizeConfig.screenWidth * 0.3,
          backgroundColor: cTextColor.withOpacity(0.5),
          backgroundImage: backImage ?? AssetImage("assets/images/profile.png"),
        );
      },
    );
  }
}
