import 'package:aswanna_application/screens/home/home_screen.dart';
import 'package:aswanna_application/services/auth_service.dart';
import 'package:flutter/material.dart';

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
  final AuthService authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  late String email;
  late String password;
  bool remember = false;
  final List<String> errors = [];


  // bool chekBoxState = false;
  late bool _passwordVisible;

  @override
  void initState() {
    _passwordVisible = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
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
                  onTap: () => Navigator.pushNamed(
                      context, FogotPasswodScreen.routeName),
                  child: Text(
                    "Forgot Password",
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(30),
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.w500
                      ),
                  ),
                ),
              ],
            ),
          ),
          FormError(errors: errors),
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
                  dynamic result = authService.signInAnonymously();
                  if (result == null) {
                    print("error signing in");
                  }else{
                    Navigator.pushNamed(context, HomeScreen.routeName);
                    print("sign in");
                    print(result);
                  }
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
            press: () {
              if (_formKey.currentState!.validate() && errors.length == 0) {
                _formKey.currentState!.save();
                print(email);
                print(password);
                Navigator.pushNamed(context, HomeScreen.routeName);
              }
            },
          ),
         
        ],
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      // keyboardType: TextInputType.visiblePassword,
      obscureText: _passwordVisible,
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
    );
  }

  TextFormField buildEmailFormField() {
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
}
