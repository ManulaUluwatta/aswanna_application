import 'package:flutter/material.dart';

import '../../../size_cofig.dart';

class ProfileMenuTile extends StatelessWidget {
  const ProfileMenuTile({
    Key key,
    this.leading,
    this.title, this.onTap,
  }) : super(key: key);

  final IconData leading;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: Theme.of(context).textTheme.headline6,
      ),
      onTap: onTap,
      leading: Icon(leading,color: Color(0xFF41c300)),
      trailing: Icon(Icons.arrow_forward_ios,color: Color(0xFF41c300),
              size: getProportionateScreenWidth(30),),
    );
  }
}
