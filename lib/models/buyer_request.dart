import 'package:aswanna_application/models/model.dart';
import 'package:aswanna_application/models/product.dart';
import 'package:enum_to_string/enum_to_string.dart';

class BuyerRequest extends Model {
  static const String TITLE_KEY = "title";
  static const String DESCRIPTION_KEY = "description";
  static const String QUANTITY_KEY = "quantity";
  static const String BUYER_ID_KEY = "buyerID";
  static const String PRODUCT_TYPE_KEY = "product_type";
  static const String LISTED_DATE_KEY = "listed_date";
  static const String EXPIRE_DATE_KEY = "expire_date";

  String title;
  String description;
  ProductType productType;
  num quantity;
  String buyerId;
  String listedDate;
  String expireDate;

  BuyerRequest(String id,
      {this.title,
      this.description,
      this.productType,
      this.quantity,
      this.buyerId,
      this.listedDate,
      this.expireDate})
      : super(id);

  factory BuyerRequest.fromMap(Map<String, dynamic> map, {String id}) {
    return BuyerRequest(
      id,
      title: map[TITLE_KEY],
      description: map[DESCRIPTION_KEY],
      productType:
          EnumToString.fromString(ProductType.values, map[PRODUCT_TYPE_KEY]),
      quantity: map[QUANTITY_KEY],
      buyerId: map[BUYER_ID_KEY],
      listedDate: map[LISTED_DATE_KEY],
      expireDate: map[EXPIRE_DATE_KEY],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      TITLE_KEY: title,
      DESCRIPTION_KEY: description,
      PRODUCT_TYPE_KEY: EnumToString.convertToString(productType),
      QUANTITY_KEY: quantity,
      BUYER_ID_KEY: buyerId,
      LISTED_DATE_KEY: listedDate,
      EXPIRE_DATE_KEY: expireDate
    };
    return map;
  }

  @override
  Map<String, dynamic> toUpdateMap() {
    final map = <String, dynamic>{};
    if (title != null) map[TITLE_KEY] = title;
    if (description != null) map[DESCRIPTION_KEY] = description;
    if (productType != null)
      map[PRODUCT_TYPE_KEY] = EnumToString.convertToString(productType);
    if (quantity != null) map[QUANTITY_KEY] = quantity;
    if (buyerId != null) map[BUYER_ID_KEY] = buyerId;
    if (listedDate != null) map[LISTED_DATE_KEY] = listedDate;
    if (expireDate != null) map[EXPIRE_DATE_KEY] = expireDate;
    return map;
  }
}
