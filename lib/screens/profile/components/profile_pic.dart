//import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
          CircleAvatar(
            backgroundImage: AssetImage("assets/images/profile.png"),
            backgroundColor: Colors.white,
          ),
          Positioned(
            right: -12,
            bottom: 0,
            child: SizedBox(
              height: 46,
              width: 46,
              child: IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {},
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
}
