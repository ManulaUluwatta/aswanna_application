import 'package:aswanna_application/size_cofig.dart';
import 'package:flutter/material.dart';

Future<bool> showConfirmationDialog(
  BuildContext context,
  String messege, {
  String positiveResponse = "Yes",
  String negativeResponse = "No",
}) async {
  var result = await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Text(
          messege,
          style: TextStyle(fontSize: getProportionateScreenWidth(30), fontWeight: FontWeight.w400),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Center(
                child: Padding(
                  padding: EdgeInsets.all(getProportionateScreenWidth(8)),
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: Text(
                      positiveResponse,
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.all(getProportionateScreenWidth(8)),
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: Text(
                      negativeResponse,
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
  if (result == null) result = false;
  return result;
}
