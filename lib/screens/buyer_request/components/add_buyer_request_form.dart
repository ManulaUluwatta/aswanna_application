import 'package:aswanna_application/components/default_button.dart';
import 'package:aswanna_application/models/buyer_request.dart';
import 'package:aswanna_application/models/product.dart';
import 'package:aswanna_application/screens/buyer_request/provider_models/buyer_request_details.dart';
import 'package:aswanna_application/services/database/buyer_request_database_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import '../../../constrants.dart';
import '../../../size_cofig.dart';

class AddProductForm extends StatefulWidget {
  final BuyerRequest buyerRequest;
  AddProductForm({
    Key key,
    this.buyerRequest,
  }) : super(key: key);

  @override
  _AddProductFormState createState() => _AddProductFormState();
}

class _AddProductFormState extends State<AddProductForm> {
  final _basicDetailsFormKey = GlobalKey<FormState>();
  final _describeProductFormKey = GlobalKey<FormState>();

  final TextEditingController titleFieldController = TextEditingController();
  final TextEditingController desciptionFieldController =
      TextEditingController();
  final TextEditingController quantityContoller = TextEditingController();

  bool newBuyerRequest = true;
  BuyerRequest buyerRequest;
  DateTimeRange dateTimeRange;
  ThemeData themeData;

  @override
  void dispose() {
    titleFieldController.dispose();
    desciptionFieldController.dispose();
    quantityContoller.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // ignore: unnecessary_null_comparison
    if (widget.buyerRequest == null) {
      buyerRequest = BuyerRequest(null);
      newBuyerRequest = true;
    } else {
      buyerRequest = widget.buyerRequest;
      newBuyerRequest = false;
      final buyerRequestDetails =
          Provider.of<BuyerRequestDetails>(context, listen: false);
      buyerRequestDetails.initialProductType = buyerRequest.productType;
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final column = Column(
      children: [
        buildProductTypeDropdown(),
        SizedBox(height: getProportionateScreenHeight(20)),
        buildBasicDetailsTile(context),
        SizedBox(height: getProportionateScreenHeight(10)),
        DefaultButton(
            text: "Save Product",
            press: () {
              saveProductButtonCallback(context);
            }),
        SizedBox(height: getProportionateScreenHeight(10)),
      ],
    );
    if (newBuyerRequest == false) {
      titleFieldController.text = buyerRequest.title;
      desciptionFieldController.text = buyerRequest.description;;
      quantityContoller.text = buyerRequest.quantity.toString();
    }
    return column;
  }

  Widget buildBasicDetailsTile(BuildContext context) {
    return Form(
      key: _basicDetailsFormKey,
      child: Column(
        children: [
          Text(
            "Fill Folowing Details \nto add buyer request",
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(
            height: getProportionateScreenHeight(10),
          ),
          buildTitleField(),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          buildDescriptionField(),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          buildQuantityField(),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          buildSelectDateRangeButton(context),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
        ],
      ),
    );
  }

  bool validateBasicDetailsForm() {
    if (_basicDetailsFormKey.currentState.validate()) {
      _basicDetailsFormKey.currentState.save();
      buyerRequest.title = titleFieldController.text;
      buyerRequest.description = desciptionFieldController.text;
      buyerRequest.quantity = double.parse(quantityContoller.text);
      return true;
    }
    return false;
  }

  Widget buildSelectDateRangeButton(BuildContext context) {
    return TextButton(
      onPressed: () => pickDateRange(context),
      child: Text(
        "${getListedDate()} To ${getExpiredDate()}",
        style: TextStyle(
            fontSize: 16, fontWeight: FontWeight.w500, color: cTextColor),
      ),
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        side: MaterialStateProperty.all(
          BorderSide(
            color: Color(0xFF09af00),
            width: 2,
          ),
        ),
      ),
    );
  }

  Widget buildProductTypeDropdown() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(100),
        vertical: getProportionateScreenHeight(1),
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFF09af00), width: 2),
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      child: Consumer<BuyerRequestDetails>(
        builder: (context, buyerRequestDetails, child) {
          return DropdownButton(
            onChanged: (value) {
              buyerRequestDetails.productType = value as ProductType;
            },
            value: buyerRequestDetails.productType,
            items: ProductType.values
                .map(
                  (e) => DropdownMenuItem(
                    value: e,
                    child: Text(
                      EnumToString.convertToString(e),
                    ),
                  ),
                )
                .toList(),
            hint: Text(
              "Chose Product Type",
            ),
            style: TextStyle(
                color: cTextColor, fontSize: 16, fontWeight: FontWeight.w500),
            elevation: 1,
            // underline: SizedBox(width: 100, height: 100),
          );
        },
      ),
    );
  }

  Widget buildDateRangeTile(BuildContext context) {
    return ExpansionTile(
      title: Text(
        "Select Date Range",
        style: Theme.of(context).textTheme.headline6,
      ),
      leading: Icon(Icons.date_range),
      children: [],
    );
  }

  Future pickDateRange(BuildContext context) async {
    final initialDateRange = DateTimeRange(
      start: DateTime.now(),
      end: DateTime.now().add(Duration(hours: 24 * 7)),
    );
    final newDateRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 1),
      lastDate: DateTime(DateTime.now().year + 1),
      initialDateRange: dateTimeRange ?? initialDateRange,
      builder: (context, Widget child) => Theme(
          data: ThemeData.from(
            colorScheme: ColorScheme(
                primary: Color(0xFF09af00),
                primaryVariant: Colors.green, //
                secondary: Colors.white,
                secondaryVariant: Colors.green, //
                surface: Colors.green, //
                background: Colors.white,
                error: cTextColor,
                onPrimary: Colors.white,
                onSecondary: Colors.green,
                onSurface: Color(0xFF09af00),
                onBackground: Colors.green, //
                onError: cTextColor,
                brightness: Brightness.light),
          ),
          child: child),
    );

    if (newDateRange == null) return;

    setState(() {
      dateTimeRange = newDateRange;
    });
  }

  String getListedDate() {
    if (dateTimeRange == null) {
      return "Listed Date";
    } else {
      buyerRequest.listedDate = DateFormat('dd/MM/yyyy').format(dateTimeRange.start);
      return DateFormat('dd/MM/yyyy').format(dateTimeRange.start);
    }
  }

  String getExpiredDate() {
    if (dateTimeRange == null) {
      return "Expire Date";
    } else {
      buyerRequest.expireDate = DateFormat('dd/MM/yyyy').format(dateTimeRange.end);
      return DateFormat('dd/MM/yyyy').format(dateTimeRange.end);
    }
  }

  Widget buildTitleField() {
    return TextFormField(
      controller: titleFieldController,
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        hintText: "e.g., Onion",
        labelText: "Product Name",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      validator: (_) {
        if (titleFieldController.text.isEmpty) {
          return cRequirdError;
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  Widget buildDescriptionField() {
    return TextFormField(
      controller: desciptionFieldController,
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        hintText: "e.g., ",
        labelText: "Description",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      validator: (_) {
        if (desciptionFieldController.text.isEmpty) {
          return cRequirdError;
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      maxLines: null,
    );
  }

  Widget buildQuantityField() {
    return TextFormField(
      controller: quantityContoller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: "e.g., 500",
        labelText: "Minimum Bulk Quantiy(KG)",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      validator: (_) {
        if (quantityContoller.text.isEmpty) {
          return cRequirdError;
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  Future<void> saveProductButtonCallback(BuildContext context) async {
    if (validateBasicDetailsForm() == false) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Erros in Basic Details Form",
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.red[300],
        ),
      );
      return;
    }
    final buyerRequestDetails =
        Provider.of<BuyerRequestDetails>(context, listen: false);
    if (buyerRequestDetails.productType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Please select Product Type",
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.red[300],
        ),
      );
      return;
    }
    String productId;
    String snackbarMessage;
    try {
      buyerRequest.productType = buyerRequestDetails.productType;
      final productUploadFuture = newBuyerRequest
          ? BuyerRequestDatabaseSerivce().addBuyerRequest(buyerRequest)
          : BuyerRequestDatabaseSerivce().updateBuyerRequest(buyerRequest);
      productUploadFuture.then((value) {
        productId = value;
      });
      await showDialog(
        context: context,
        builder: (context) {
          return FutureProgressDialog(
            productUploadFuture,
            message: Text(newBuyerRequest
                ? "Adding Buyer Request"
                : "Updating Buyer Request"),
          );
        },
      );
      if (productId != null) {
        snackbarMessage = "Buyer Requesr Information updated successfully";
      } else {
        throw "Couldn't update buyer request info due to some unknown issue";
      }
    } on FirebaseException catch (e) {
      Logger().w("Firebase Exception: $e");
      snackbarMessage = "Something went wrong";
    } catch (e) {
      Logger().w("Unknown Exception: $e");
      snackbarMessage = e.toString();
    } finally {
      Logger().i(snackbarMessage);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(snackbarMessage),
        ),
      );
    }
    Navigator.pop(context);
  }
}
