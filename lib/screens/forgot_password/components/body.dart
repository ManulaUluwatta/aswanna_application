import 'package:aswanna_application/components/default_button.dart';
import 'package:aswanna_application/components/form_error.dart';
import 'package:aswanna_application/components/no_account_text.dart';
import 'package:aswanna_application/screens/sign_in/sign_in_screen.dart';
import 'package:aswanna_application/services/auth/auth_service.dart';
import 'package:aswanna_application/size_cofig.dart';
import 'package:flutter/material.dart';

import '../../../constrants.dart';
import '../../../components/custom_suffix_icon.dart';

class Body extends StatelessWidget {
  const Body({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(30)),
          child: Column(
            children: [
              SizedBox(
                height: SizeConfig.screenHeight * 0.04,
              ),
              Text(
                "Forgot Password",
                style: TextStyle(
                    fontSize: getProportionateScreenWidth(60),
                    fontWeight: FontWeight.w500),
              ),
              Text(
                "Please enter your email and we will send \nyou a link to return to your account ",
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 0.1,
              ),
              ForgotPasswordForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({Key key}) : super(key: key);

  @override
  _ForgotPasswordFormState createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  TextEditingController emailController;
  final _formKey = GlobalKey<FormState>();
  List<String> errors = [];
  String email;

  bool isLoading = false;
  @override
  void initState() {
    emailController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: isLoading == false
            ? Column(
                children: [
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    onSaved: (newValue) => email = newValue,
                    onChanged: (value) {
                      if (value.isNotEmpty &&
                          errors.contains(cEmailNullError)) {
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
                      if (value.isEmpty && !errors.contains(cEmailNullError)) {
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
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(30),
                  ),
                  FormError(errors: errors),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.1,
                  ),
                  DefaultButton(
                      text: "Continue",
                      press: () {
                        if (_formKey.currentState.validate() &&
                            errors.length == 0) {
                          _formKey.currentState.save();
                          print(email);
                          setState(() {
                            isLoading = true;
                          });
                          AuthService()
                              .restPassword(
                            email: emailController.text.trim(),
                          )
                              .then((value) {
                            if (value == 'Email Send') {
                              setState(() {
                                isLoading = false;
                              });
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignInScreen()),
                                  (route) => false);
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(
                                  value,
                                  style: TextStyle(fontSize: 18),
                                  textAlign: TextAlign.center,
                                ),
                                backgroundColor: Colors.green[200],
                              ));
                            } else {
                              setState(() {
                                isLoading = false;
                              });
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(
                                  value,
                                  style: TextStyle(fontSize: 18),
                                  textAlign: TextAlign.center,
                                ),
                                backgroundColor: Colors.red[300],
                              ));
                            }
                          });
                        }
                      }),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.1,
                  ),
                  NoAccountText(),
                ],
              )
            : Center(child: CircularProgressIndicator()));
  }
}
