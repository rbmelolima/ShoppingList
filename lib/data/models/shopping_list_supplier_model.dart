import 'dart:convert';

class ShoppingListSupplierModel {
  ShoppingListSupplierModel({
    required this.fornecedores,
    required this.fornecedorMaisCompetitivo,
  });

  final List<SupplierModel> fornecedores;
  final SupplierModel fornecedorMaisCompetitivo;

  factory ShoppingListSupplierModel.fromJson(String str) => ShoppingListSupplierModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ShoppingListSupplierModel.fromMap(Map<String, dynamic> json) => ShoppingListSupplierModel(
        fornecedores: List<SupplierModel>.from(json["fornecedores"].map((x) => SupplierModel.fromMap(x))),
        fornecedorMaisCompetitivo: SupplierModel.fromMap(json["fornecedorMaisCompetitivo"]),
      );

  Map<String, dynamic> toMap() => {
        "fornecedores": List<dynamic>.from(fornecedores.map((x) => x.toMap())),
        "fornecedorMaisCompetitivo": fornecedorMaisCompetitivo.toMap(),
      };
}

class SupplierModel {
  SupplierModel({
    required this.nome,
    required this.produtos,
    required this.precoTotal,
  });

  final String nome;
  final List<ProductModel> produtos;
  final String precoTotal;

  factory SupplierModel.fromJson(String str) => SupplierModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SupplierModel.fromMap(Map<String, dynamic> json) => SupplierModel(
        nome: json["nome"],
        produtos: List<ProductModel>.from(json["produtos"].map((x) => ProductModel.fromMap(x))),
        precoTotal: json["precoTotal"],
      );

  Map<String, dynamic> toMap() => {
        "nome": nome,
        "produtos": List<dynamic>.from(produtos.map((x) => x.toMap())),
        "precoTotal": precoTotal,
      };
}

class ProductModel {
  ProductModel({
    required this.nome,
    required this.quantidade,
    required this.precoUnitario,
    required this.descricao,
  });

  final String nome;
  final String? descricao;
  final double quantidade;
  final double precoUnitario;

  factory ProductModel.fromJson(String str) => ProductModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductModel.fromMap(Map<String, dynamic> json) => ProductModel(
        nome: json["nome"],
        descricao: json["descricao"],
        quantidade: json["quantidade"],
        precoUnitario: json["precoUnitario"].toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "nome": nome,
        "quantidade": quantidade,
        "precoUnitario": precoUnitario,
        "descricao": descricao,
      };
}
