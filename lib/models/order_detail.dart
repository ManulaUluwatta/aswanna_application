import 'model.dart';

class OrderDetail extends Model{
  static const String ORDER_ID_KEY = "order_id";
  static const String ORDER_DETAIL_ID_KEY = "order_detail_id";
  static const String ORDER_QTY_KEY = "order_qty";
  static const String PRODUCT_ID_KEY = "product_id";


  String orderID;
  String orderDetailID;
  String orderQTY;
  String productID;

  OrderDetail(
    String id,{
    this.orderID,
    this.orderDetailID,
    this.orderQTY,
    this.productID,
  }) : super(id);

  factory OrderDetail.fromMap(Map<String, dynamic> map, {String id}) {
    return OrderDetail(
      id,
      orderID: map[ORDER_ID_KEY],
      orderDetailID: map[ORDER_DETAIL_ID_KEY],
      orderQTY: map[ORDER_QTY_KEY],
      productID: map[PRODUCT_ID_KEY],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      ORDER_ID_KEY: orderID,
      ORDER_DETAIL_ID_KEY: orderDetailID,
      ORDER_QTY_KEY: orderQTY,
      PRODUCT_ID_KEY: productID,
    };
    return map;
  }

  @override
  Map<String, dynamic> toUpdateMap() {
    final map = <String, dynamic>{};
    if (orderID != null) map[ORDER_ID_KEY] = orderID;
    if (orderDetailID != null) map[ORDER_DETAIL_ID_KEY] = orderDetailID;
    if (orderQTY != null) map[ORDER_QTY_KEY] = orderQTY;
    if (productID != null) map[PRODUCT_ID_KEY] = productID;
    return map;
  }

}