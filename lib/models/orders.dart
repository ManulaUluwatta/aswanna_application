import 'model.dart';

class Order extends Model{
  static const String USER_ID_KEY = "user_id";
  static const String ORDER_DATE_KEY = "order_date";
  static const String STATUS_KEY = "status";
  static const String DELIVERY_OPTION_KEY = "delivery_option";
  static const String ORDER_ID_KEY = "order_id";


  String userID;
  String orderDate;
  String status;
  String deliveryOption;
  String orderID;

  Order(
    String id,{
    this.orderID,
    this.userID,
    this.orderDate,
    this.deliveryOption,
    this.status,
  }) : super(id);

  factory Order.fromMap(Map<String, dynamic> map, {String id}) {
    return Order(
      id,
      orderID: map[ORDER_ID_KEY],
      userID: map[USER_ID_KEY],
      orderDate: map[ORDER_DATE_KEY],
      deliveryOption: map[DELIVERY_OPTION_KEY],
      status: map[STATUS_KEY],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      ORDER_ID_KEY: orderID,
      USER_ID_KEY: userID,
      ORDER_DATE_KEY: orderDate,
      DELIVERY_OPTION_KEY: deliveryOption,
      STATUS_KEY: status,
    };
    return map;
  }

  @override
  Map<String, dynamic> toUpdateMap() {
    final map = <String, dynamic>{};
    if (orderID != null) map[ORDER_ID_KEY] = orderID;
    if (userID != null) map[USER_ID_KEY] = userID;
    if (orderDate != null) map[ORDER_DATE_KEY] = orderDate;
    if (deliveryOption != null) map[DELIVERY_OPTION_KEY] = deliveryOption;
    if (status != null) map[STATUS_KEY] = status;
    return map;
  }

}