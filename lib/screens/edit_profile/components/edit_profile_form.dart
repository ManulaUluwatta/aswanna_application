import 'package:aswanna_application/components/custom_suffix_icon.dart';
import 'package:aswanna_application/components/default_button.dart';
import 'package:aswanna_application/screens/profile/profile_screen.dart';
import 'package:aswanna_application/services/auth/auth_service.dart';
import 'package:aswanna_application/services/database/user_database_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../../../constrants.dart';
import '../../../size_cofig.dart';

class EditProfileForm extends StatefulWidget {
  const EditProfileForm({
    Key key,
  }) : super(key: key);

  @override
  _EditProfileFormState createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<EditProfileForm> {
  final _formKey = GlobalKey<FormState>();
  List<String> errors = [];
  String firstName;
  String lastName;
  String phoneNumber;

  TextEditingController firstNameController;
  TextEditingController lastNameController;
  TextEditingController phoneNumberController;
  @override
  void initState() {
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    phoneNumberController = TextEditingController();

    super.initState();
  }

  void addError({String error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({String error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // buildFirstNameFormField(),
          // SizedBox(
          //   height: getProportionateScreenHeight(30),
          // ),
          // buildLastNameFormField(),
          // SizedBox(
          //   height: getProportionateScreenHeight(30),
          // ),
          // buildPhoneNumberFormField(),
          // SizedBox(
          //   height: getProportionateScreenHeight(30),
          // ),
          getSellerDetails(),
          DefaultButton(text: "Update", press: completeProfileAction),
        ],
      ),
    );
  }

  Widget getSellerDetails() {
    String userID = AuthService().currentUser.uid;
    return StreamBuilder<DocumentSnapshot>(
        stream: UserDatabaseService().getSellerDetails(userID),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            final error = snapshot.error;
            Logger().w(error.toString());
          }
          String firstName;
          String lastName;
          String contact;
          String email;
          // String address;
          if (snapshot.hasData && snapshot.data != null) {
            firstName = snapshot.data["firstName"];
            lastName = snapshot.data["lastName"];
            contact = snapshot.data["contact"];
            // address = snapshot.data["address"];
          }
          firstNameController.text = firstName;
          lastNameController.text = lastName;
          phoneNumberController.text = contact;
          return Container(
            child: Column(
              children: [
                buildFirstNameFormField(),
                SizedBox(
                  height: getProportionateScreenHeight(30),
                ),
                buildLastNameFormField(),
                SizedBox(
                  height: getProportionateScreenHeight(30),
                ),
                buildPhoneNumberFormField(),
                SizedBox(
                  height: getProportionateScreenHeight(30),
                ),
              ],
            ),
          );
        });
  }

  TextFormField buildPhoneNumberFormField() {
    return TextFormField(
      controller: phoneNumberController,
      keyboardType: TextInputType.number,
      onSaved: (newValue) => phoneNumber = newValue,
      // validator: (value) {
      //   if (value!.isEmpty) {
      //     return cPhoneNumberNullError;
      //   }
      //   return null;
      // },
      validator: (value) {
        if (phoneNumberController.text.isEmpty) {
          return cPhoneNumberNullError;
        } else if (!phoneNumberValidationRegExp
            .hasMatch(phoneNumberController.text)) {
          return "Invalid Phone Number";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Phone Number",
        hintText: "Enter Your phone number",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        //Create suffix icon as a widget and pass the icon
        suffixIcon: CustomSuffixIcon(
          icons: Icons.contact_phone,
        ),
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  TextFormField buildLastNameFormField() {
    return TextFormField(
      controller: lastNameController,
      keyboardType: TextInputType.text,
      onSaved: (newValue) => lastName = newValue,
      validator: (value) {
        if (value.isEmpty) {
          return cLastNameNullError;
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Last Name",
        hintText: "Enter Your last name",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        //Create suffix icon as a widget and pass the icon
        suffixIcon: CustomSuffixIcon(
          icons: Icons.person,
        ),
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  TextFormField buildFirstNameFormField() {
    return TextFormField(
      controller: firstNameController,
      keyboardType: TextInputType.text,
      onSaved: (newValue) => firstName = newValue,
      validator: (value) {
        if (value.isEmpty) {
          return cFristNameNullError;
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "First Name",
        hintText: "Enter Your first name",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        //Create suffix icon as a widget and pass the icon
        suffixIcon: CustomSuffixIcon(
          icons: Icons.person,
        ),
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  Future<void> completeProfileAction() async {
    

  }
}
