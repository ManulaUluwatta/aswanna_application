import 'package:aswanna_application/services/database/user_database_service.dart';

import 'data_stream.dart';

class OrderedProductsStream extends DataStream<List<String>> {
  @override
  void reload() {
    final orderedProductsFuture = UserDatabaseService().orderedProductsList;
    orderedProductsFuture.then((data) {
      addData(data);
    }).catchError((e) {
      addError(e);
    });
  }
}
