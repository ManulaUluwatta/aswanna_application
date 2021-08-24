import 'package:enum_to_string/enum_to_string.dart';

import 'model.dart';

enum ProductType {
  FRUIT,
  VEGITABLE,
  RICE,
}

class Product extends Model {
  List<String> images;
  String title;
  String subCategory;
  num discountPrice;
  num originalPrice;
  num rating;
  String highlights;
  String description;
  bool favourite;
  String owner;
  num minQuantity;
  num availableQuantity;
  String listedDate;
  String exprieDate;
  ProductType productType;
  String status;
  List<String> searchTags;
  Product(
    String id, {
    this.images,
    this.title,
    this.subCategory,
    this.discountPrice,
    this.originalPrice,
    this.rating = 0.0,
    this.highlights,
    this.description,
    this.favourite,
    this.owner,
    this.minQuantity,
    this.availableQuantity,
    this.listedDate,
    this.exprieDate,
    this.productType,
    this.status,
    this.searchTags,
  }) : super(id);

  factory Product.fromMap(Map<String, dynamic> map, {String id}) {
    if (map["search_tag"] == null) {
      map["search_tag"] = <String>[];
    }
    return Product(
      id,
      images: map["image"].cast<String>(),
      title: map["title"],
      subCategory: map["sub_category"],
      discountPrice: map["discount_price"],
      originalPrice: map["original_price"],
      rating: map["rating"],
      highlights: map["highlight"],
      description: map["description"],
      favourite: map["favourite"],
      owner: map["owner"],
      minQuantity: map["min_quantity"],
      availableQuantity: map["available_quantity"],
      listedDate: map["listed_date"],
      exprieDate: map["expire_date"],
      productType:
          EnumToString.fromString(ProductType.values, map["product_type"]),
      status: map["status"],
      searchTags: map["search_tag"].cast<String>(),
    );
  }
  @override
  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      "image": images,
      "title": title,
      "sub_category": subCategory,
      "discount_price": discountPrice,
      "original_price": originalPrice,
      "rating": rating,
      "highlight": highlights,
      "description": description,
      "owner": owner,
      "min_quantity": minQuantity,
      "available_quantity": availableQuantity,
      "listed_date": listedDate,
      "expire_date": exprieDate,
      "product_type": EnumToString.convertToString(productType),
      "status": status,
      "search_tag": searchTags,
    };
    return map;
  }

  @override
  Map<String, dynamic> toUpdateMap() {
    final map = <String, dynamic>{};
    if (images != null) map["image"] = images;
    if (title != null) map["title"] = title;
    if (subCategory != null) map["sub_category"] = subCategory;
    if (discountPrice != null) map["discount_price"] = discountPrice;
    if (originalPrice != null) map["original_price"] = originalPrice;
    if (rating != null) map["rating"] = rating;
    if (highlights != null) map["highlight"] = highlights;
    if (description != null) map["description"] = description;
    if (owner != null) map["owner"] = owner;
    if (minQuantity != null) map["min_quantity"] = minQuantity;
    if (availableQuantity != null)
      map["available_quantity"] = availableQuantity;
    if (listedDate != null) map["listed_date"] = listedDate;
    if (exprieDate != null) map["expire_date"] = exprieDate;
    if (productType != null)
      map["product_type"] = EnumToString.convertToString(productType);
    if (status != null) map["status"] = status;
    if (searchTags != null) map["search_tag"] = searchTags;
    return map;
  }

  num calculateDiscountPrice() {
    num discoumt =
        (((originalPrice - discountPrice) * 100) / originalPrice).round();
    return discoumt;
  }
}
