import 'package:aswanna_application/screens/complete_profile/complete_profile_screen.dart';
import 'package:flutter/material.dart';

import '../../../size_cofig.dart';

import '../../../constrants.dart';
import '../../../components/default_button.dart';
import '../../../components/custom_suffix_icon.dart';
import '../../../components/form_error.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  late String email;
  late String password;
  late String confirmPassword;
  final List<String> errors = [];
  bool chekBoxState = false;
  bool obscureTextValue = true;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailTextField(),
          SizedBox(
            height: getProportionateScreenHeight(35.0),
          ),
          buildPasswordTextField(obscureTextValue),
          SizedBox(
            height: getProportionateScreenHeight(35.0),
          ),
          buildConfirmPasswordFormField(obscureTextValue),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "Show password",
              ),
              Checkbox(
                  value: chekBoxState,
                  onChanged: (value) {
                    setState(() {
                      chekBoxState = value!;
                      cchengeObcureTextState(chekBoxState);
                    });
                  })
            ],
          ),
          FormError(errors: errors),
          SizedBox(
            height: getProportionateScreenHeight(20.0),
          ),
          DefaultButton(
            text: "Continue",
            press: () {
              if (_formKey.currentState!.validate() && errors.length == 0) {
                _formKey.currentState!.save();
                print(email);
                print(password);
                print(confirmPassword);
                Navigator.pushNamed(context, CompleteProfileScreen.routeName);
              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildConfirmPasswordFormField(bool obscureTextValue) {
    return TextFormField(
      // keyboardType: TextInputType.visiblePassword,
      obscureText: obscureTextValue,
      onSaved: (newValue) => confirmPassword = newValue!,
      onChanged: (value) {
        confirmPassword = value;
        if (value.isNotEmpty && errors.contains(cPassNullError)) {
          setState(() {
            errors.remove(cPassNullError);
          });
        } else if (password == confirmPassword &&
            errors.contains(cMatchPassError)) {
          setState(() {
            errors.remove(cMatchPassError);
          });
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty && !errors.contains(cPassNullError)) {
          setState(() {
            errors.add(cPassNullError);
          });
        } else if (password != confirmPassword &&
            !errors.contains(cMatchPassError)) {
          setState(() {
            errors.add(cMatchPassError);
          });
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Confirm Password",
        hintText: "Re-enter Your Password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        //Create suffix icon as a widget and pass the icon
        suffixIcon: CustomSuffixIcon(icons: Icons.lock_outlined),
      ),
    );
  }

  TextFormField buildPasswordTextField(bool obscureTextValue) {
    return TextFormField(
      // keyboardType: TextInputType.visiblePassword,
      obscureText: obscureTextValue,
      onSaved: (newValue) => password = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(cPassNullError)) {
          setState(() {
            errors.remove(cPassNullError);
          });
        } else if (value.length >= 8 && errors.contains(cShortPassError)) {
          setState(() {
            errors.remove(cShortPassError);
          });
        }
        password = value;
        return null;
      },
      validator: (value) {
        if (value!.isEmpty && !errors.contains(cPassNullError)) {
          setState(() {
            errors.add(cPassNullError);
          });
        } else if (value.length < 8 && !errors.contains(cShortPassError)) {
          setState(() {
            errors.add(cShortPassError);
          });
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Enter Your Password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        //Create suffix icon as a widget and pass the icon
        suffixIcon: CustomSuffixIcon(
          icons: Icons.lock_outline,
        ),
      ),
    );
  }

  TextFormField buildEmailTextField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(cEmailNullError)) {
          setState(() {
            errors.remove(cEmailNullError);
          });
        } else if (emailValidatorRegExp.hasMatch(value) &&
            errors.contains(cInvalidEmailError)) {
          setState(() {
            errors.remove(cInvalidEmailError);
          });
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty && !errors.contains(cEmailNullError)) {
          setState(() {
            errors.add(cEmailNullError);
          });
        } else if (!emailValidatorRegExp.hasMatch(value) &&
            !errors.contains(cInvalidEmailError)) {
          setState(() {
            errors.add(cInvalidEmailError);
          });
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Enter Your Email",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        //Create suffix icon as a widget and pass the icon
        suffixIcon: CustomSuffixIcon(
          icons: Icons.email_outlined,
        ),
      ),
    );
  }

  void cchengeObcureTextState(bool chekBoxState) {
    if (chekBoxState) {
      obscureTextValue = false;
    } else {
      obscureTextValue = true;
    }
  }
}
