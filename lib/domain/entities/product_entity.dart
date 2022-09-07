import 'dart:convert';

class ProductEntity {
  ProductEntity({
    required this.name,
    required this.id,
    this.measure,
    this.unitOfMeasurement,
    this.company,
    this.description,
  });

  final String id;
  final String name;
  final String? measure;
  final String? unitOfMeasurement;
  final String? company;
  final String? description;

  factory ProductEntity.fromJson(String str) {
    return ProductEntity.fromMap(
      json.decode(str),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductEntity.fromMap(Map<String, dynamic> json) {
    return ProductEntity(
      name: json["name"],
      id: json["id"],
      measure: json["measure"],
      unitOfMeasurement: json["unitOfMeasurement"],
      company: json["company"],
      description: json["description"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "id": id,
      "measure": measure,
      "unitOfMeasurement": unitOfMeasurement,
      "company": company,
      "description": description,
    };
  }
}
