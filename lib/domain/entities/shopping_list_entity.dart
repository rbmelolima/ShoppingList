import 'dart:convert';

import 'product_entity.dart';

class ShoppingListEntity {
  ShoppingListEntity({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.products,
    this.description,
  });

  final String id;
  final String name;
  final String? description;
  final String createdAt;
  final String updatedAt;
  final List<ProductEntity> products;

  factory ShoppingListEntity.fromJson(String str) {
    return ShoppingListEntity.fromMap(json.decode(str));
  }

  String toJson() => json.encode(toMap());

  factory ShoppingListEntity.fromMap(Map<String, dynamic> json) {
    return ShoppingListEntity(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      createdAt: json["createdAt"],
      updatedAt: json["updatedAt"],
      products: List<ProductEntity>.from(
        json["products"].map((x) => ProductEntity.fromMap(x)),
      ),
    );
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "description": description,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "products": List<dynamic>.from(products.map((x) => x.toMap())),
      };
}
