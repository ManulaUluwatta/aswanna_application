//import 'dart:html';

import 'package:aswanna_application/screens/change_display_picture%20copy/change_display_picture_screen.dart';
import 'package:aswanna_application/services/database/user_database_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../../../constrants.dart';
import '../../../size_cofig.dart';

class ProfilePic extends StatelessWidget {
  const ProfilePic({
    Key key,
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
          Positioned(
            right: -12,
            bottom: 0,
            child: SizedBox(
              height: 46,
              width: 46,
              child: IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChangeDisplayPictureScreen(),
                      ));
                },
                icon: Icon(
                  Icons.camera_alt_rounded,
                  color: Colors.grey,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildDisplayPictureAvatar(BuildContext context) {
    return StreamBuilder(
      stream: UserDatabaseService().currentUserDataStream,
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
