import 'package:aswanna_application/screens/complete_profile/complete_profile_screen.dart';
import 'package:aswanna_application/screens/home/home_screen.dart';
import 'package:aswanna_application/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  final _formKey = GlobalKey<FormState>();
  late String email;
  late String password;
  late String confirmPassword;
  final List<String> errors = [];
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
      child: isLoading == false ? Column(
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
          FormError(errors: errors),
          SizedBox(
            height: getProportionateScreenHeight(20.0),
          ),
          DefaultButton(
            text: "Continue",
            press: () async {
              if (_formKey.currentState!.validate() && errors.length == 0) {
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
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()),
                              (route) => false);
                        }else{
                          setState(() {
                            isLoading = false;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value!)));
                        }
                      });
                // context.read<AuthService>().signUp(
                //   email: emailController.text.trim(), 
                //   password: passwordController.text.trim(), 
                //   context: context,
                //   );
                  // dispose();
                // await loginProvider.signUp(
                //     email: emailController.text.trim(),
                //     password: passwordController.text.trim());
                // Navigator.pushNamed(context, CompleteProfileScreen.routeName);
              }
            },
          ),
        ],
      ) : Center(child: CircularProgressIndicator()),
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
      controller: passwordController,
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
      controller: emailController,
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
