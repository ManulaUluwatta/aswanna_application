import 'package:aswanna_application/components/confirm_dialog.dart';
import 'package:aswanna_application/screens/home/home_screen.dart';
import 'package:aswanna_application/services/auth/auth_service.dart';
import 'package:aswanna_application/services/custom/user_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import '../../../models/user.dart' as UserModel;

import '../../../constrants.dart';
import '../../../size_cofig.dart';
import '../../../components/default_button.dart';
import '../../../components/custom_suffix_icon.dart';
import '../../../components/form_error.dart';

class CompleteProfileForm extends StatefulWidget {
  const CompleteProfileForm({Key key}) : super(key: key);

  @override
  _CompleteProfileFormState createState() => _CompleteProfileFormState();
}

class _CompleteProfileFormState extends State<CompleteProfileForm> {
  final UserService _userService = UserService();
  final _formKey = GlobalKey<FormState>();
  List<String> errors = [];
  String firstName;
  String lastName;
  String phoneNumber;
  String address;
  String role;
  Object selectedRadio;
  TextEditingController firstNameController;
  TextEditingController lastNameController;
  TextEditingController phoneNumberController;
  TextEditingController addressController;

  @override
  void initState() {
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    phoneNumberController = TextEditingController();
    addressController = TextEditingController();
    super.initState();
    selectedRadio = 0;
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
          DefaultButton(text: "Continue", press: completeProfileAction),
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
      controller: addressController,
      keyboardType: TextInputType.streetAddress,
      onSaved: (newValue) => address = newValue,
      validator: (value) {
        if (value.isEmpty) {
          return cAddressNullError;
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
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
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
        } else if (!phoneNumberValidationRegExp.hasMatch(phoneNumberController.text)) {
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
    String uid = FirebaseAuth.instance.currentUser.uid;
    AuthService authService = AuthService();
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    User user = await firebaseAuth.currentUser;
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      bool allowed = authService.currentUserVerified;
      if (!allowed) {
        final reverify = await showConfirmationDialog(context,
            "You haven't verified your email address.You have to verifiy your account first",
            positiveResponse: "Resend verification email",
            negativeResponse: "Go Back");
        if (reverify) {
          final future = await authService.sendEmailVerificationToUser();
          await showDialog(
            context: context,
            builder: (context) {
              return FutureProgressDialog(
                future,
                message: Text("Resending verification email"),
              );
            },
          );
        }
      } else {
        _userService.create(
          UserModel.User(
            uid: uid,
            firstName: firstNameController.text,
            lastName: lastNameController.text,
            contact: phoneNumberController.text,
            address: addressController.text,
            role: selectedRadio.toString(),
          ),
        );
        await authService.updateCurrentUserDisplayName("${firstNameController.text} ${lastNameController.text}");
        // user.updateDisplayName(firstNameController.text);
        print("User Name : ${user.displayName}");
        // Navigator.pushNamed(context, HomeScreen.routeName);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
            (route) => false);
      }
    }
  }
}

//   Future<void> completeProfileAction() async {
//     String? uid = FirebaseAuth.instance.currentUser!.uid;
//     AuthService authService = AuthService();
//     if (_formKey.currentState!.validate() && errors.length == 0) {
//       _formKey.currentState!.save();
//       print(firstName);
//       print(lastName);
//       print(phoneNumber);
//       print(address);
//       print(uid);
//       bool allowed = authService.currentUserVerified;
//       if (!allowed) {
//         final reverify = await showConfirmationDialog(context,
//             "You haven't verified your email address.You have to verifiy your account first",
//             positiveResponse: "Resend verification email",
//             negativeResponse: "Go Back");
//         if (reverify) {
//           final future = await authService.sendEmailVerificationToUser();
//           await showDialog(
//             context: context,
//             builder: (context) {
//               return FutureProgressDialog(
//                 future,
//                 message: Text("Resending verification email"),
//               );
//             },
//           );
//         }
//       } else {
//         _userService.create(
//           UserModel.User(
//             uid: uid,
//             firstName: firstName,
//             lastName: lastName,
//             contact: phoneNumber,
//             address: address,
//             role: selectedRadio.toString(),
//           ),
//         );
//         // Navigator.pushNamed(context, HomeScreen.routeName);
//         Navigator.pushAndRemoveUntil(
//             context,
//             MaterialPageRoute(builder: (context) => HomeScreen()),
//             (route) => false);
//       }
//     }
//   }
// }
