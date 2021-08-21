import 'package:aswanna_application/models/product.dart';
import 'package:flutter/material.dart';

class BuyerRequestDetails extends ChangeNotifier {
  ProductType _productType;

  set initialProductType(ProductType type) {
    _productType = type;
    notifyListeners();
  }

  set productType(ProductType type) {
    _productType = type;
    notifyListeners();
  }

  ProductType get productType {
    return _productType;
  }
}
