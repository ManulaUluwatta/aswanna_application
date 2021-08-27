import 'package:aswanna_application/components/top_rounded_container.dart';
import 'package:aswanna_application/models/buyer_request.dart';
import 'package:aswanna_application/screens/buyer_request_detail_screen/components/buyer_request_description.dart';
import 'package:flutter/material.dart';

class BuyerRequestActionSection extends StatelessWidget {
  final BuyerRequest buyerRequest;

  const BuyerRequestActionSection({
    Key key,
    @required this.buyerRequest,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final column = Column(
      children: [
        Stack(
          children: [
            TopRoundedContainer(
              child: BuyerRequestDecription(buyerRequest:buyerRequest),
            ),
          ],
        ),
      ],
    );

    return column;
  }
}