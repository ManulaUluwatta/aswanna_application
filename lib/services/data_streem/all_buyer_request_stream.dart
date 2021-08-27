import 'package:aswanna_application/services/database/buyer_request_database_service.dart';

import 'data_stream.dart';

class AllBuyerRequestStream extends DataStream<List<String>> {
  @override
  void reload() {
    final allBuyerRequestFuture = BuyerRequestDatabaseSerivce().allBuyerRequestList;
    allBuyerRequestFuture.then((favProducts) {
      addData(favProducts as List<String>);
    }).catchError((e) {
      addError(e);
    });
  }
}