import 'package:aswanna_application/screens/buyer_request_detail_screen/buyer_request_detail_screen.dart';
import 'package:aswanna_application/screens/view_all_buyer_request/components/all_request_section.dart';
import 'package:aswanna_application/services/data_streem/all_buyer_request_stream.dart';
import 'package:flutter/material.dart';

import '../../../size_cofig.dart';

class Body extends StatefulWidget {
  const Body({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body>{
  final AllBuyerRequestStream allProductsStream = AllBuyerRequestStream();

  @override
  void initState() {
    super.initState();
    allProductsStream.init();
  }

  @override
  void dispose() {
    allProductsStream.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: refreshPage,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: SizeConfig.screenHeight * 0.85,
                child: AllRequestSection(
                  sectionTitle: "Explore All Requests",
                  allRequestStreamController: allProductsStream,
                  emptyMessage: "No requests",
                  onCardTap: onProductCardTapped,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> refreshPage() {
    // favouriteProductsStream.reload();
    allProductsStream.reload();
    return Future<void>.value();
  }

  void onProductCardTapped(String buyerRequestID) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BuyerRequestDetailScreen(buyerRequestID: buyerRequestID),
      ),
    ).then((_) async {
      await refreshPage();
    });
  }
}
