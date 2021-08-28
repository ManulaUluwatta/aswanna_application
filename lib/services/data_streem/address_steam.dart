import 'package:aswanna_application/models/address.dart';
import 'package:aswanna_application/services/database/user_database_service.dart';

import 'data_stream.dart';

class AddressesStream extends DataStream<List<String>> {
  final String userID;
  AddressesStream(this.userID);
  @override
  void reload() {
    final addressesList = UserDatabaseService().getCurrentUserAddressID(userID);
    addressesList.then((list) {
      addData(list);
    }).catchError((e) {
      addError(e);
    });
  }
}