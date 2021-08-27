import 'package:aswanna_application/services/database/buyer_request_database_service.dart';

import 'data_stream.dart';

class UsersBuyerRequestStream extends DataStream<List<String>> {
  @override
  void reload() {
    final usersBuyerRequestFuture = BuyerRequestDatabaseSerivce().usersBuyerRequestList;
    usersBuyerRequestFuture.then((data) {
      addData(data as List<String>);
    }).catchError((e) {
      addError(e);
    });
  }
}