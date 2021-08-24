import 'package:flutter/material.dart';
import 'components/body.dart';

class ChangeDisplayPictureScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Profile Picture"),),
      body: Body(),
    );
  }
}
