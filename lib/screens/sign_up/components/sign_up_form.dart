import 'package:aswanna_application/screens/complete_profile/complete_profile_screen.dart';
import 'package:aswanna_application/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

import '../../../size_cofig.dart';

import '../../../constrants.dart';
import '../../../components/default_button.dart';
import '../../../components/custom_suffix_icon.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  final _formKey = GlobalKey<FormState>();
  late String email;
  late String password;
  late String confirmPassword;
  bool chekBoxState = false;
  bool obscureTextValue = true;

  bool isLoading = false;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final loginProvider = Provider.of<AuthService>(context);
    return Form(
      key: _formKey,
      child: isLoading == false
          ? Column(
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
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(30),
                      ),
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
                SizedBox(
                  height: getProportionateScreenHeight(20.0),
                ),
                DefaultButton(
                  text: "Continue",
                  press: signUpUser,
                ),
              ],
            )
          : Center(child: CircularProgressIndicator()),
    );
  }

  TextFormField buildConfirmPasswordFormField(bool obscureTextValue) {
    return TextFormField(
      // keyboardType: TextInputType.visiblePassword,
      obscureText: obscureTextValue,
      onSaved: (newValue) => confirmPassword = newValue!,
      onChanged: (value) {
        confirmPassword = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return cPassNullError;
        } else if (password != confirmPassword) {
          return cMatchPassError;
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

      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  TextFormField buildPasswordTextField(bool obscureTextValue) {
    return TextFormField(
      controller: passwordController,
      keyboardType: TextInputType.visiblePassword,
      obscureText: obscureTextValue,
      onSaved: (newValue) => password = newValue!,
      onChanged: (value) {
        password = value;
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return cPassNullError;
        } else if (value.length < 8) {
          return cShortPassError;
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
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  TextFormField buildEmailTextField() {
    return TextFormField(
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue!,
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Enter Your Email",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        //Create suffix icon as a widget and pass the icon
        suffixIcon: CustomSuffixIcon(
          icons: Icons.email_outlined,
        ),
      ),
      validator: (value) {
        if (emailController.text.isEmpty) {
          return cEmailNullError;
        } else if (!emailValidatorRegExp.hasMatch(emailController.text)) {
          return cInvalidEmailError;
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  Future<void> signUpUser() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      print(email);
      print(password);
      print(confirmPassword);
      setState(() {
        isLoading = true;
      });
      AuthService()
          .signUp(
              email: emailController.text.trim(),
              password: passwordController.text.trim())
          .then((value) {
        if (value == 'SignUp') {
          setState(() {
            isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              value!,
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            backgroundColor: Colors.green[300],
          ));
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => CompleteProfileScreen()),
              (route) => false);
        } else {
          setState(() {
            isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              value!,
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            backgroundColor: Colors.red[300],
          ));
        }
      });
    }
  }

  void cchengeObcureTextState(bool chekBoxState) {
    if (chekBoxState) {
      obscureTextValue = false;
    } else {
      obscureTextValue = true;
    }
  }
}
