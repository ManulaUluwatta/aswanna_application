

import 'package:aswanna_application/services/database/product_database_service.dart';

import 'data_stream.dart';

class UsersProductsStream extends DataStream<List<String>> {
  @override
  void reload() {
    final usersProductsFuture = ProductDatabaseService().usersProductsList;
    usersProductsFuture.then((data) {
      addData(data as List<String>);
    }).catchError((e) {
      addError(e);
    });
  }
}
