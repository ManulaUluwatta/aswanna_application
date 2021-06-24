import 'package:aswanna_application/constrants.dart';
import 'package:aswanna_application/size_cofig.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(30.0),
          ),
          child: Column(
            children: [
              Text(
                "Welocome Back",
                style: TextStyle(
                    fontSize: getProportionateScreenWidth(60),
                    fontWeight: FontWeight.w500),
              ),
              Text(
                "Sign in with your email and password \nor continue with google",
                textAlign: TextAlign.center,
              ),
              SignForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class SignForm extends StatefulWidget {
  const SignForm({Key? key}) : super(key: key);

  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFormField(
              decoration: InputDecoration(
                labelText: "Email",
                hintText: "Enter Your Email",
                floatingLabelBehavior: FloatingLabelBehavior.always,
                suffixIcon: Icon(
                  Icons.email,
                 
                  )
          )),
        ],
      ),
    );
  }
}
