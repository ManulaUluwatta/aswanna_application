import 'package:aswanna_application/components/default_button.dart';
import 'package:aswanna_application/models/address.dart';
import 'package:aswanna_application/services/database/user_database_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../../../constrants.dart';
import '../../../size_cofig.dart';

class AddressDetailsForm extends StatefulWidget {
  final Address addressToEdit;
  AddressDetailsForm({
    Key key,
    this.addressToEdit,
  }) : super(key: key);

  @override
  _AddressDetailsFormState createState() => _AddressDetailsFormState();
}

class _AddressDetailsFormState extends State<AddressDetailsForm> {
  final _formKey = GlobalKey<FormState>();


  TextEditingController addressLine1Controller;
  TextEditingController addressLine2Controller;
  TextEditingController cityController;
  TextEditingController districtController;
  TextEditingController proviceController;
  TextEditingController postalCodeController;

  @override
  void initState() {
    addressLine1Controller = TextEditingController();
    addressLine2Controller = TextEditingController();
    cityController = TextEditingController();
    districtController = TextEditingController();
    proviceController = TextEditingController();
    postalCodeController = TextEditingController();
    super.initState();
  }
  @override
  void dispose() {
    addressLine1Controller.dispose();
    addressLine2Controller.dispose();
    cityController.dispose();
    districtController.dispose();
    proviceController.dispose();
    postalCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final form = Form(
      key: _formKey,
      child: Column(
        children: [
          buildAddressLine1Field(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildAddressLine2Field(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildCityField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildPostalCodeField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildDistrictField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildProviceField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          DefaultButton(
            text: "Update Address",
            press: widget.addressToEdit == null
                ? saveNewAddressButtonCallback
                : saveEditedAddressButtonCallback,
          ),
        ],
      ),
    );
    if (widget.addressToEdit != null) {
      addressLine1Controller.text = widget.addressToEdit.addresLine1;
      addressLine2Controller.text = widget.addressToEdit.addresLine2;
      cityController.text = widget.addressToEdit.city;
      districtController.text = widget.addressToEdit.district;
      proviceController.text = widget.addressToEdit.province;
      postalCodeController.text = widget.addressToEdit.postalCode;
    }
    return form;
  }

  bool validateAddressDetailForm() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      // adderssLine1 = addressLine1Controller.text;
      // adderssLine2 = addressLine2Controller.text;
      // city = cityController.text;
      // district = districtController.text;
      // provice = proviceController.text;
      // postalCode = postalCodeController.text;
      return true;
    }
    return false;
  }
 Widget buildAddressLine1Field() {
    return TextFormField(
      controller: addressLine1Controller,
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        hintText: "Enter address line 1",
        labelText: "Address Line 1",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      validator: (_) {
        if (addressLine1Controller.text.isEmpty) {
          return cRequirdError;
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  Widget buildAddressLine2Field() {
    return TextFormField(
      controller: addressLine2Controller,
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        hintText: "Enter address line 2",
        labelText: "Address Line 2",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      validator: (_) {
        if (addressLine2Controller.text.isEmpty) {
          return cRequirdError;
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  Widget buildCityField() {
    return TextFormField(
      controller: cityController,
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        hintText: "Enter city",
        labelText: "City",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      validator: (_) {
        if (cityController.text.isEmpty) {
          return cRequirdError;
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  Widget buildPostalCodeField() {
    return TextFormField(
      controller: postalCodeController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: "Enter postal code",
        labelText: "Postal Code",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      validator: (_) {
        if (postalCodeController.text.isEmpty) {
          return cRequirdError;
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  Widget buildDistrictField() {
    return TextFormField(
      controller: districtController,
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        hintText: "Enter district",
        labelText: "District",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      validator: (_) {
        if (districtController.text.isEmpty) {
          return cRequirdError;
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  Widget buildProviceField() {
    return TextFormField(
      controller: proviceController,
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        hintText: "Enter provice",
        labelText: "Provice",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      validator: (_) {
        if (proviceController.text.isEmpty) {
          return cRequirdError;
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

 
  
  Future<void> saveNewAddressButtonCallback() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      final Address newAddress = generateAddressObject();
      bool status = false;
      String snackbarMessage;
      try {
        status =
            await UserDatabaseService().addAddressForCurrentUser(newAddress);
        if (status == true) {
          snackbarMessage = "Address saved successfully";
        } else {
          throw "Coundn't save the address due to unknown reason";
        }
      } on FirebaseException catch (e) {
        Logger().w("Firebase Exception: $e");
        snackbarMessage = "Something went wrong";
      } catch (e) {
        Logger().w("Unknown Exception: $e");
        snackbarMessage = "Something went wrong";
      } finally {
        Logger().i(snackbarMessage);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(snackbarMessage),
          ),
        );
      }
    }
  }

  Future<void> saveEditedAddressButtonCallback() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      final Address newAddress =
          generateAddressObject(id: widget.addressToEdit.id);

      bool status = false;
      String snackbarMessage;
      try {
        status =
            await UserDatabaseService().updateAddressForCurrentUser(newAddress);
        if (status == true) {
          snackbarMessage = "Address updated successfully";
        } else {
          throw "Couldn't update address due to unknown reason";
        }
      } on FirebaseException catch (e) {
        Logger().w("Firebase Exception: $e");
        snackbarMessage = "Something went wrong";
      } catch (e) {
        Logger().w("Unknown Exception: $e");
        snackbarMessage = "Something went wrong";
      } finally {
        Logger().i(snackbarMessage);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(snackbarMessage),
          ),
        );
      }
    }
  }

   Address generateAddressObject({String id}) {
    return Address(
      id: id,
      addresLine1: addressLine1Controller.text,
      addresLine2: addressLine2Controller.text,
      city: cityController.text,
      district: districtController.text,
      province: proviceController.text,
      postalCode: postalCodeController.text,
    );
  }
}