import 'package:aswanna_application/screens/home/home_screen.dart';
import 'package:aswanna_application/services/custom/user_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../models/user.dart' as UserModel;

import '../../../constrants.dart';
import '../../../size_cofig.dart';
import '../../../components/default_button.dart';
import '../../../components/custom_suffix_icon.dart';
import '../../../components/form_error.dart';

class CompleteProfileForm extends StatefulWidget {
  const CompleteProfileForm({Key? key}) : super(key: key);

  @override
  _CompleteProfileFormState createState() => _CompleteProfileFormState();
}

class _CompleteProfileFormState extends State<CompleteProfileForm> {
  
  final UserService _userService = UserService();
  final _formKey = GlobalKey<FormState>();
  List<String> errors = [];
  late String firstName;
  late String lastName;
  late String phoneNumber;
  late String address;
  late String role;
  late Object selectedRadio;

  @override
  void initState() {
    super.initState();
    selectedRadio = 0;
  }

  void addError({required String error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({required String error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String? uid = FirebaseAuth.instance.currentUser!.uid;
    return Form(
      key: _formKey,
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
          buildAddressFormField(),
          SizedBox(
            height: getProportionateScreenHeight(10),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Select Your User Role :",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
              ),
              Radio(
                value: "Seller",
                groupValue: selectedRadio,
                activeColor: Colors.green,
                onChanged: (value) {
                  setSelectedRadio(value);

                  // print(value);
                },
              ),
              Text(
                "Seller",
                style: TextStyle(fontSize: 18),
              ),
              Radio(
                value: "Buyer",
                groupValue: selectedRadio,
                onChanged: (value) {
                  setSelectedRadio(value);
                  // print(value);
                },
              ),
              Text(
                "Buyer",
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          SizedBox(
            height: getProportionateScreenHeight(10),
          ),
          FormError(errors: errors),
          SizedBox(
            height: getProportionateScreenHeight(10),
          ),
          DefaultButton(
              text: "Continue",
              press: () {
               if (_formKey.currentState!.validate() && errors.length == 0) {
                _formKey.currentState!.save();
                print(firstName);
                print(lastName);
                print(phoneNumber);
                print(address);
                print(uid);
                _userService.create(UserModel.User(
                  uid: uid,
                  firstName: firstName,
                   lastName: lastName ,
                   contact: phoneNumber,
                   address: address,
                   role: selectedRadio.toString(),
                   ),);
                // Navigator.pushNamed(context, HomeScreen.routeName);
                Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()),
                              (route) => false);
              }
              }),
        ],
      ),
    );
  }

  void setSelectedRadio(value) {
    setState(() {
      selectedRadio = value;
    });
  }

  TextFormField buildAddressFormField() {
    return TextFormField(
      keyboardType: TextInputType.streetAddress,
      onSaved: (newValue) => address = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(cAddressNullError)) {
          setState(() {
            errors.remove(cAddressNullError);
          });
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty && !errors.contains(cAddressNullError)) {
          setState(() {
            errors.add(cAddressNullError);
          });
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Address",
        hintText: "Enter Your address",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        //Create suffix icon as a widget and pass the icon
        suffixIcon: CustomSuffixIcon(
          icons: Icons.location_pin,
        ),
      ),
    );
  }

  TextFormField buildPhoneNumberFormField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      onSaved: (newValue) => phoneNumber = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(cPhoneNumberNullError)) {
          setState(() {
            errors.remove(cPhoneNumberNullError);
          });
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty && !errors.contains(cPhoneNumberNullError)) {
          setState(() {
            errors.add(cPhoneNumberNullError);
          });
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
    );
  }

  TextFormField buildLastNameFormField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      onSaved: (newValue) => lastName = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(cLastNameNullError)) {
          setState(() {
            errors.remove(cLastNameNullError);
          });
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty && !errors.contains(cLastNameNullError)) {
          setState(() {
            errors.add(cLastNameNullError);
          });
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
    );
  }

  TextFormField buildFirstNameFormField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      onSaved: (newValue) => firstName = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(cFristNameNullError)) {
          setState(() {
            errors.remove(cFristNameNullError);
          });
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty && !errors.contains(cFristNameNullError)) {
          setState(() {
            errors.add(cFristNameNullError);
          });
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
    );
  }
}
