import 'model.dart';

class Offer extends Model {
  static const String SELLER_ID_KEY = "seller_id";
  static const String MESSAGE_KEY = "message";
  static const String PRICE_KEY = "price";

  String sellerID;
  String message;
  double price;
  Offer(
    String id, {
    this.sellerID,
    this.message,
    this.price,
  }) : super(id);

  factory Offer.fromMap(Map<String, dynamic> map, {String id}) {
    return Offer(
      id,
      sellerID: map[SELLER_ID_KEY],
      message: map[MESSAGE_KEY],
      price: map[PRICE_KEY],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      SELLER_ID_KEY: sellerID,
      MESSAGE_KEY: message,
      PRICE_KEY: price,
    };
    return map;
  }

  @override
  Map<String, dynamic> toUpdateMap() {
    final map = <String, dynamic>{};
    if (sellerID != null) map[SELLER_ID_KEY] = sellerID;
    if (message != null) map[MESSAGE_KEY] = message;
    if (price != null) map[PRICE_KEY] = price;
    return map;
  }
}
