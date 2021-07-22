import 'package:flutter/material.dart';
import 'package:enum_to_string/enum_to_string.dart';

import 'model.dart';

// class Product {
//   final int id;
//   final String title, description;
//   final List<String> images;
//   final List<Color> colors;
//   final double rating, price;
//   final bool isFavourite, isPopular;

//   Product({
//     required this.id,
//     required this.images,
//     required this.colors,
//     this.rating = 0.0,
//     this.isFavourite = false,
//     this.isPopular = false,
//     required this.title,
//     required this.price,
//     required this.description,
//   });
// }

// // Our demo Products

// List<Product> demoProducts = [
//   Product(
//     id: 1,
//     images: [
//       "assets/images/fruit.png",
//       // "assets/images/ps4_console_white_2.png",
//       // "assets/images/ps4_console_white_3.png",
//       // "assets/images/ps4_console_white_4.png",
//     ],
//     colors: [
//       Color(0xFFF6625E),
//       Color(0xFF836DB8),
//       Color(0xFFDECB9C),
//       Colors.white,
//     ],
//     title: "Green Chilies™",
//     price: 700,
//     description: description,
//     rating: 4.8,
//     isFavourite: true,
//     isPopular: true,
//   ),
//   Product(
//     id: 2,
//     images: [
//       "assets/images/png-cliparvegi1.png",
//     ],
//     colors: [
//       Color(0xFFF6625E),
//       Color(0xFF836DB8),
//       Color(0xFFDECB9C),
//       Colors.white,
//     ],
//     title: "Apples",
//     price: 50.50,
//     description: description,
//     rating: 4.1,
//     isPopular: true,
//   ),
//   Product(
//     id: 3,
//     images: [
//       "assets/images/rice.png",
//     ],
//     colors: [
//       Color(0xFFF6625E),
//       Color(0xFF836DB8),
//       Color(0xFFDECB9C),
//       Colors.white,
//     ],
//     title: "Turmeric",
//     price: 500,
//     description: description,
//     rating: 4.1,
//     isFavourite: true,
//     isPopular: true,
//   ),
//   Product(
//     id: 4,
//     images: [
//       "assets/images/vegi.png",
//     ],
//     colors: [
//       Color(0xFFF6625E),
//       Color(0xFF836DB8),
//       Color(0xFFDECB9C),
//       Colors.white,
//     ],
//     title: "Grapes",
//     price: 100,
//     description: description,
//     rating: 4.1,
//     isFavourite: true,
//   ),
// ];

// const String description =
//     "Wireless Controller for PS4™ gives you what you want in your gaming from over precision control your games to sharing …";

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
  List<String> searchTags;
  Product(
    String id, {
    this.images,
    this.title,
    this.subCategory,
    this.discountPrice,
    this.originalPrice,
    this.rating,
    this.highlights,
    this.description,
    this.favourite,
    this.owner,
    this.minQuantity,
    this.availableQuantity,
    this.listedDate,
    this.exprieDate,
    this.productType,
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
      searchTags: map["search_tag"],
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
      "search_tag": searchTags,
    };
    return map;
  }

  @override
  Map<String, dynamic> toUpdateMap() {
    final map = <String, dynamic>{};
    if (images != null) if (images != null) map["image"] = images;
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
    if (searchTags != null) map["search_tag"] = searchTags;
    return map;
  }

  num calculateDiscountPrice() {
    num discoumt =
        (((originalPrice - discountPrice) * 100) / originalPrice).round();
    return discoumt;
  }
}
