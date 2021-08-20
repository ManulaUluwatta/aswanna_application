import 'package:aswanna_application/screens/my_products/my_products_screen.dart';
import 'package:aswanna_application/screens/product/add_product_screen.dart';
import 'package:aswanna_application/screens/profile/components/profile_menu_title.dart';
import 'package:aswanna_application/screens/sign_in/sign_in_screen.dart';
import 'package:aswanna_application/services/auth/auth_service.dart';
import 'package:aswanna_application/services/custom/user_service.dart';
import 'package:aswanna_application/services/database/user_database_service.dart';
import 'package:aswanna_application/size_cofig.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'profile_pic.dart';

class Body extends StatelessWidget {
  const Body({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userData =
        UserService().getById(FirebaseAuth.instance.currentUser.uid);
    FirebaseAuth auth = FirebaseAuth.instance;
    return SingleChildScrollView(
      child: Column(
        children: [
          ProfilePic(),
          Text("${auth.currentUser.displayName}"),
          Text("${auth.currentUser.email}"),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                // ListTile(
                //   title: Text(
                //     "My Account",
                //     style: Theme.of(context).textTheme.headline6,
                //   ),
                //   onTap: () {
                //     print("mmm");
                //   },
                //   leading: Icon(Icons.person),
                //   trailing: Icon(Icons.arrow_forward_ios),
                // ),
                ProfileMenuTile(
                  title: "My Account",
                  leading: Icons.person,
                  onTap: () {},
                ),
                buildUserRoleBasedExpansionTitle(context),
                // buildManageGigExpansionTile(context),
                ProfileMenuTile(
                  leading: Icons.notifications,
                  title: "Notifications",
                  onTap: () {},
                ),
                ProfileMenuTile(
                  title: "Settings",
                  leading: Icons.settings,
                  onTap: () {},
                ),
                ProfileMenuTile(
                  title: "Help Center",
                  leading: Icons.help_center_outlined,
                  onTap: () {},
                ),
                ProfileMenuTile(
                  title: "Log out",
                  leading: Icons.logout,
                  onTap: () {
                    AuthService().signOut();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => SignInScreen()),
                        (route) => false);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget buildUserRoleBasedExpansionTitle(BuildContext context){
    return StreamBuilder<DocumentSnapshot>(
      stream: UserDatabaseService().currentUserDataStream,
      builder: (context,snapshot){
        if(snapshot.hasError){
            final error = snapshot.error;
            Logger().w(error.toString());
        }
        String userRole;
        if(snapshot.hasData && snapshot.data != null){
          userRole = snapshot.data["role"];
        }
        if(userRole == "Buyer"){
          return buildBuyerRequestExpansionTitele(context);
        }
        return buildManageGigExpansionTile(context);
      }
      );
  }

  Widget buildBuyerRequestExpansionTitele(BuildContext context){
    return ExpansionTile(
      leading: Icon(
        Icons.business,
        color: Color(0xFF41c300),
      ),
      title: Text(
        "Manage Buyer Request",
        style: Theme.of(context).textTheme.headline6,
      ),
      trailing: Icon(Icons.keyboard_arrow_down, color: Color(0xFF41c300),
              size: getProportionateScreenWidth(50),),
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(120)),
          child: Column(
            children: [
              ListTile(
                title: Text(
                  "Add Buyer Request",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: getProportionateScreenWidth(32),
                      fontWeight: FontWeight.w500),
                ),
                onTap: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddProductScreen()));
                },
              ),
              ListTile(
                title: Text(
                  "Manage Buyer Request",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: getProportionateScreenWidth(32),
                      fontWeight: FontWeight.w500),
                ),
                onTap: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyProductsScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );

  }

  Widget buildManageGigExpansionTile(BuildContext context) {
    return ExpansionTile(
      leading: Icon(
        Icons.business,
        color: Color(0xFF41c300),
      ),
      title: Text(
        "Manage Gigs",
        style: Theme.of(context).textTheme.headline6,
      ),
      trailing: Icon(Icons.keyboard_arrow_down, color: Color(0xFF41c300),
              size: getProportionateScreenWidth(50),),
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(120)),
          child: Column(
            children: [
              ListTile(
                title: Text(
                  "Add New Product",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: getProportionateScreenWidth(32),
                      fontWeight: FontWeight.w500),
                ),
                onTap: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddProductScreen()));
                },
              ),
              ListTile(
                title: Text(
                  "Manage My Products",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: getProportionateScreenWidth(32),
                      fontWeight: FontWeight.w500),
                ),
                onTap: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyProductsScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
