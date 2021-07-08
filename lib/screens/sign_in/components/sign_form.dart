import 'package:aswanna_application/screens/home/home_screen.dart';
import 'package:aswanna_application/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';

import '../../../constrants.dart';
import '../../../size_cofig.dart';
import '../../../components/default_button.dart';
import '../../../components/custom_suffix_icon.dart';
import '../../../components/form_error.dart';
import '../../forgot_password/forgot_password_screen.dart';

class SignForm extends StatefulWidget {
  const SignForm({Key? key}) : super(key: key);

  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  // final AuthService authService = AuthService();
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  final _formKey = GlobalKey<FormState>();
  late String email;
  late String password;
  bool remember = false;

  bool isLoading = false;

  // bool chekBoxState = false;
  late bool _passwordVisible;

  @override
  void initState() {
    _passwordVisible = false;
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

  _resetTextField() {
    passwordController.clear();
    emailController.clear();
  }

  @override
  Widget build(BuildContext context) {
    // final loginProvider = Provider.of<AuthService>(context);
    return Form(
      key: _formKey,
      child: isLoading == false
          ? Column(
              children: [
                buildEmailFormField(),
                SizedBox(
                  height: getProportionateScreenHeight(30.0),
                ),
                buildPasswordFormField(),
                SizedBox(
                  height: getProportionateScreenHeight(10.0),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 10, 10),
                  child: Row(
                    children: [
                      Checkbox(
                        value: remember,
                        // fillColor: MaterialStateProperty.all(Color(0xFF09af00)),
                        activeColor: Color(0xFF09af00),
                        onChanged: (value) {
                          setState(() {
                            remember = value!;
                          });
                        },
                      ),
                      Text(
                        "Remember me",
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(30),
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        // onTap: () => Navigator.pushNamed(
                        //     context, FogotPasswodScreen.routeName),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FogotPasswodScreen()));
                        },
                        child: Text(
                          "Forgot Password",
                          style: TextStyle(
                              fontSize: getProportionateScreenWidth(30),
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ),
                // FormError(errors: errors),
                SizedBox(
                  height: getProportionateScreenHeight(20.0),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "To View, ",
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(35),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // dynamic result = authService.signInAnonymously();
                        // dynamic result =
                        //     context.read<AuthService>().signInAnonymously();
                        // if (result == null) {
                        //   print("error signing in");
                        // } else {
                        //   Navigator.pushNamed(context, HomeScreen.routeName);
                        //   print("sign in");
                        //   print(result);
                        // }
                      },
                      child: Text(
                        "Anonymous Sign In",
                        style: TextStyle(
                            fontSize: getProportionateScreenWidth(35),
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF09af00)),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: getProportionateScreenHeight(10.0),
                ),
                DefaultButton(
                  text: "Continue",
                  press: signInUser,
                ),
              ],
            )
          : Center(child: CircularProgressIndicator()),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      controller: passwordController,
      // keyboardType: TextInputType.visiblePassword,
      obscureText: _passwordVisible,
      onSaved: (newValue) => password = newValue!,
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
        prefixIcon: IconButton(
          onPressed: () {
            setState(() {
              _passwordVisible = !_passwordVisible;
            });
          },
          icon: Icon(
            _passwordVisible
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
            color: Theme.of(context).primaryColorDark,
          ),
        ),
      ),

      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  TextFormField buildEmailFormField() {
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

  Future<void> signInUser() async {
    if (_formKey.currentState!.validate()) {
      //  && errors.length == 0
      _formKey.currentState!.save();
      print(email);
      print(password);
      setState(() {
        isLoading = true;
      });
      AuthService()
          .signIn(
              email: emailController.text.trim(),
              password: passwordController.text.trim())
          .then((value) {
        if (value == 'welcome') {
          setState(() {
            isLoading = false;
          });
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
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
          _resetTextField();
        }
      });
    }
  }
}
