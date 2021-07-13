import 'package:aswanna_application/models/product.dart';
import 'package:aswanna_application/services/database/product_database_service.dart';
import 'data_stream.dart';

class CategoryProductsStream extends DataStream<List<String>> {
  final ProductType category;

  CategoryProductsStream(this.category);
  @override
  void reload() {
    final allProductsFuture =
        ProductDatabaseService().getCategoryProductsList(category);
    allProductsFuture.then((favProducts) {
      addData(favProducts as List<String>);
    }).catchError((e) {
      addError(e);
    });
  }
}
