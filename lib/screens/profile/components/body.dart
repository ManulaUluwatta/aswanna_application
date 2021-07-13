import 'package:aswanna_application/screens/complete_profile/complete_profile_screen.dart';
import 'package:aswanna_application/screens/product/add_product_screen.dart';
import 'package:aswanna_application/screens/sign_in/sign_in_screen.dart';
import 'package:aswanna_application/services/auth/auth_service.dart';
import 'package:aswanna_application/services/custom/user_service.dart';
import 'package:aswanna_application/size_cofig.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userData =
        UserService().getById(FirebaseAuth.instance.currentUser!.uid);
        FirebaseAuth auth = FirebaseAuth.instance;
    return SingleChildScrollView(
      child: Column(
        children: [
          ProfilePic(),
          Text("${auth.currentUser!.email}"),
          SizedBox(
            height: 20,
          ),
          ProfileMenu(
            pic: Icons.person_rounded,
            text: "My Account",
            press: () {},
          ),
          buildManageGigExpansionTile(context),
          ProfileMenu(
            pic: Icons.notifications,
            text: "Notifications",
            press: () {},
          ),
          ProfileMenu(
            pic: Icons.settings,
            text: "Settings",
            press: () {},
          ),
          ProfileMenu(
            pic: Icons.help_center_outlined,
            text: "Help Center",
            press: () {},
          ),
          ProfileMenu(
            pic: Icons.logout,
            text: "Log out",
            press: () {
              AuthService().signOut();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => SignInScreen()),
                  (route) => false);
            },
          ),
        ],
      ),
    );
  }

  Widget buildManageGigExpansionTile(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: ExpansionTile(
        leading: Icon(
          Icons.business,
          color: Color(0xFF41c300),
          ),
        title: Text(
          "Manage Gigs",
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
        children: [
          ListTile(
            title: Text(
              "Add New Product",
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),
            ),
            onTap: () async {
              // bool allowed = AuthentificationService().currentUserVerified;
              // if (!allowed) {
              //   final reverify = await showConfirmationDialog(context,
              //       "You haven't verified your email address. This action is only allowed for verified users.",
              //       positiveResponse: "Resend verification email",
              //       negativeResponse: "Go back");
              //   if (reverify) {
              //     final future = AuthentificationService()
              //         .sendVerificationEmailToCurrentUser();
              //     await showDialog(
              //       context: context,
              //       builder: (context) {
              //         return FutureProgressDialog(
              //           future,
              //           message: Text("Resending verification email"),
              //         );
              //       },
              //     );
              //   }
              //   return;
              // }
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddProductScreen()));
            },
          ),
          ListTile(
            title: Text(
              "Manage My Products",
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),
            ),
            onTap: () async {
              // bool allowed = AuthentificationService().currentUserVerified;
              // if (!allowed) {
              //   final reverify = await showConfirmationDialog(context,
              //       "You haven't verified your email address. This action is only allowed for verified users.",
              //       positiveResponse: "Resend verification email",
              //       negativeResponse: "Go back");
              //   if (reverify) {
              //     final future = AuthentificationService()
              //         .sendVerificationEmailToCurrentUser();
              //     await showDialog(
              //       context: context,
              //       builder: (context) {
              //         return FutureProgressDialog(
              //           future,
              //           message: Text("Resending verification email"),
              //         );
              //       },
              //     );
              //   }
              //   return;
              // }
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => MyProductsScreen(),
              //   ),
              // );
            },
          ),
        ],
      ),
    );
  }
}
