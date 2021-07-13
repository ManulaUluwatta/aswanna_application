import 'package:aswanna_application/services/database/product_database_service.dart';

import 'data_stream.dart';

class AllProductsStream extends DataStream<List<String>> {
  @override
  void reload() {
    final allProductsFuture = ProductDatabaseService().allProductsList;
    allProductsFuture.then((favProducts) {
      addData(favProducts as List<String>);
    }).catchError((e) {
      addError(e);
    });
  }
}
