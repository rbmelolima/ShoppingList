import 'dart:convert';

import 'package:shoppinglist/domain/entities/entities.dart';

class SupplierEntity {
  SupplierEntity({
    required this.name,
    required this.products,
    required this.totalPrice,
    required this.isBetterOption,
  });

  final String name;
  final List<ProductEntity> products;
  final String totalPrice;
  final bool isBetterOption;

  factory SupplierEntity.fromJson(String str) => SupplierEntity.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SupplierEntity.fromMap(Map<String, dynamic> json) => SupplierEntity(
        name: json["name"],
        products: List<ProductEntity>.from(json["products"].map((x) => ProductEntity.fromMap(x))),
        totalPrice: json["totalPrice"],
        isBetterOption: json["isBetterOption"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "products": List<dynamic>.from(products.map((x) => x.toMap())),
        "totalPrice": totalPrice,
        "isBetterOption": isBetterOption,
      };
}
