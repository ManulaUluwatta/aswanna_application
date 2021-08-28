import 'package:aswanna_application/models/model.dart';

class Address extends Model {
  static const String ADDRESS_LINE_1_KEY = "address_line_1";
  static const String ADDRESS_LINE_2_KEY = "address_line_2";
  static const String CITY_KEY = "city";
  static const String DISTRICT_KEY = "district";
  static const String PROVINCE_KEY = "province";

  String addresLine1;
  String addresLine2;
  String city;
  String district;
  String province;

  Address({
    String id,
    this.addresLine1,
    this.addresLine2,
    this.city,
    this.district,
    this.province,
  }) : super(id);

  factory Address.fromMap(Map<String, dynamic> map, {String id}) {
    return Address(
      id: id,
      addresLine1: map[ADDRESS_LINE_1_KEY],
      addresLine2: map[ADDRESS_LINE_2_KEY],
      city: map[CITY_KEY],
      district: map[DISTRICT_KEY],
      province: map[PROVINCE_KEY],
    );
  }
  @override
  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      ADDRESS_LINE_1_KEY: addresLine1,
      ADDRESS_LINE_2_KEY: addresLine2,
      CITY_KEY: city,
      DISTRICT_KEY: district,
      PROVINCE_KEY: province,
    };
    return map;
  }

  @override
  Map<String, dynamic> toUpdateMap() {
    final map = <String, dynamic>{};
    if (addresLine1 != null) map[ADDRESS_LINE_1_KEY] = addresLine1;
    if (addresLine2 != null) map[ADDRESS_LINE_2_KEY] = addresLine2;
    if (city != null) map[CITY_KEY] = city;
    if (district != null) map[DISTRICT_KEY] = district;
    if (province != null) map[PROVINCE_KEY] = province;
    return map;
  }
}
