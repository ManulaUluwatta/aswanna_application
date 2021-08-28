import 'package:aswanna_application/components/confirm_dialog.dart';
import 'package:aswanna_application/models/address.dart';
import 'package:aswanna_application/screens/home/home_screen.dart';
import 'package:aswanna_application/services/auth/auth_service.dart';
import 'package:aswanna_application/services/custom/user_service.dart';
import 'package:aswanna_application/services/database/user_database_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:logger/logger.dart';
import '../../../models/user.dart' as UserModel;

import '../../../constrants.dart';
import '../../../size_cofig.dart';
import '../../../components/default_button.dart';
import '../../../components/custom_suffix_icon.dart';
import '../../../components/form_error.dart';

class CompleteProfileForm extends StatefulWidget {
  const CompleteProfileForm({Key key,}) : super(key: key);

  @override
  _CompleteProfileFormState createState() => _CompleteProfileFormState();
}

class _CompleteProfileFormState extends State<CompleteProfileForm> {
  final UserService _userService = UserService();
  final _formKey = GlobalKey<FormState>();
  final _addressDetailFormKey = GlobalKey<FormState>();
  List<String> errors = [];
  String firstName;
  String lastName;
  String phoneNumber;
  String address;
  String role;
  Object selectedRadio;
  String status = "active";

  String adderssLine1;
  String adderssLine2;
  String city;
  String district;
  String provice;
  TextEditingController firstNameController;
  TextEditingController lastNameController;
  TextEditingController phoneNumberController;
  TextEditingController addressController;

  TextEditingController addressLine1Controller;
  TextEditingController addressLine2Controller;
  TextEditingController cityController;
  TextEditingController districtController;
  TextEditingController proviceController;
  @override
  void initState() {
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    phoneNumberController = TextEditingController();
    addressController = TextEditingController();
    addressLine1Controller = TextEditingController();
    addressLine2Controller = TextEditingController();
    cityController = TextEditingController();
    districtController = TextEditingController();
    proviceController = TextEditingController();
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
          // buildAddressFormField(),
          buildAddressDetailsTile(context),
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

  Widget buildAddressDetailsTile(BuildContext context) {
    return Form(
      key: _addressDetailFormKey,
      child: ExpansionTile(
        maintainState: true,
        title: Text(
          "Address Details",
          style: Theme.of(context).textTheme.headline6,
        ),
        leading: Icon(
          Icons.home,
        ),
        childrenPadding:
            EdgeInsets.symmetric(vertical: getProportionateScreenHeight(20)),
        children: [
          buildAddressLine1Field(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildAddressLine2Field(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildCityField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildDistrictField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildProviceField(),
          SizedBox(height: getProportionateScreenHeight(20)),
        ],
      ),
    );
  }

  bool validateAddressDetailForm() {
    if (_addressDetailFormKey.currentState.validate()) {
      _addressDetailFormKey.currentState.save();
      adderssLine1 = addressLine1Controller.text;
      adderssLine2 = addressLine2Controller.text;
      city = cityController.text;
      district = districtController.text;
      provice = proviceController.text;
      return true;
    }
    return false;
  }

  Widget buildAddressLine1Field() {
    return TextFormField(
      controller: addressLine1Controller,
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        hintText: "Enter address line 1",
        labelText: "Address Line 1",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      validator: (_) {
        if (addressLine1Controller.text.isEmpty) {
          return cRequirdError;
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  Widget buildAddressLine2Field() {
    return TextFormField(
      controller: addressLine2Controller,
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        hintText: "Enter address line 2",
        labelText: "Address Line 2",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      validator: (_) {
        if (addressLine2Controller.text.isEmpty) {
          return cRequirdError;
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  Widget buildCityField() {
    return TextFormField(
      controller: cityController,
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        hintText: "Enter city",
        labelText: "City",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      validator: (_) {
        if (cityController.text.isEmpty) {
          return cRequirdError;
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  Widget buildDistrictField() {
    return TextFormField(
      controller: districtController,
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        hintText: "Enter district",
        labelText: "District",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      validator: (_) {
        if (districtController.text.isEmpty) {
          return cRequirdError;
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  Widget buildProviceField() {
    return TextFormField(
      controller: proviceController,
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        hintText: "Enter provice",
        labelText: "Provice",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      validator: (_) {
        if (proviceController.text.isEmpty) {
          return cRequirdError;
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
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
    String uid = FirebaseAuth.instance.currentUser.uid;
    AuthService authService = AuthService();
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    User user = firebaseAuth.currentUser;
    if (validateAddressDetailForm() == false) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Fill Address Details Form",
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.red[300],
        ),
      );
      return;
    }
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
            // address: addressController.text,
            role: selectedRadio.toString(),
            status: status,
            email: authService.currentUser.email,
          ),
        );
        print("test test email ${authService.currentUser.email}");
        final Address newAddress = generateAddressObject();
        bool snackbarStatus = false;
        String snackbarMessage;
        try {
          snackbarStatus =
              await UserDatabaseService().addAddressForCurrentUser(newAddress);
          if (snackbarStatus == true) {
            snackbarMessage = "User saved successfully";
          } else {
            throw "Coundn't Save";
          }
        } on FirebaseException catch (e) {
          Logger().w("Firebase Exception: $e");
          snackbarMessage = "Something went wrong";
        } catch (e) {
          Logger().w("Unknown Exception: $e");
          snackbarMessage = "Something went wrong";
        } finally {
          Logger().i(snackbarMessage);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(snackbarMessage),
            ),
          );
        }

        await authService.updateCurrentUserDisplayName(
            "${firstNameController.text} ${lastNameController.text}");
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

  Address generateAddressObject({String id}) {
    return Address(
        id: id,
        addresLine1: adderssLine1,
        addresLine2: adderssLine2,
        city: city,
        district: district,
        province: provice);
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
