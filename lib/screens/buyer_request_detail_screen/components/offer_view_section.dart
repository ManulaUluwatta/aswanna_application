import 'package:aswanna_application/components/default_button.dart';
import 'package:aswanna_application/models/offer.dart';
import 'package:flutter/material.dart';

import '../../../size_cofig.dart';

class RequestOfferDialog extends StatelessWidget {
  final Offer offer;
  RequestOfferDialog({
    Key key,
    @required this.offer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Center(
        child: Text(
          "Offer",
        ),
      ),
      children: [
        Center(
          child: TextFormField(
            keyboardType: TextInputType.number,
            initialValue: offer.price.toString(),
            decoration: InputDecoration(
              hintText: "Enter offer price",
              labelText: "Price",
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
            onChanged: (value) {
              offer.price = double.parse(value);
            },
          ),
        ),
        SizedBox(height: getProportionateScreenHeight(20)),
        SizedBox(width: getProportionateScreenWidth(600),),
        Center(
          child: TextFormField(
            initialValue: offer.message,
            decoration: InputDecoration(
              hintText: "Enter message",
              labelText: "Message",
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
            onChanged: (value) {
              offer.message = value;
            },
            maxLines: null,
            maxLength: 300,
          ),
        ),
        SizedBox(height: getProportionateScreenHeight(10)),
        Center(
          child: DefaultButton(
            text: "Submit",
            press: () {
              Navigator.pop(context, offer);
            },
          ),
        ),
      ],
      contentPadding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(20),
        vertical: getProportionateScreenHeight(20),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    );
  }
}