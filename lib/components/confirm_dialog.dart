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
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        actions: [
          Row(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
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
                  padding: const EdgeInsets.all(8.0),
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
