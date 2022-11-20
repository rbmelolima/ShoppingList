import 'dart:developer';

import 'package:shoppinglist/data/http/http_client.dart';
import 'package:shoppinglist/data/models/shopping_list_supplier_model.dart';
import 'package:shoppinglist/domain/entities/entities.dart';
import 'package:shoppinglist/domain/entities/supplier_entity.dart';
import 'package:shoppinglist/domain/usecases/price_analysis_usecase.dart';
import 'package:shoppinglist/utils/generate_md5.dart';

class WebCrawlerPriceAnalysis implements PriceAnalysisUsecase {
  final HttpClient httpClient;

  WebCrawlerPriceAnalysis(this.httpClient);

  @override
  Future<List<SupplierEntity>> analysis(ShoppingListEntity shoppingList) async {
    try {
      const String endpoint =
          "https://listadecomprasinteligenteapi20221019090206.azurewebsites.net/ListaCompras";

      var body = _makeBodySearch(shoppingList);

      var response = await httpClient.request(
        url: endpoint,
        method: "post",
        body: body,
      );

      var listSuppliersModel = ShoppingListSupplierModel.fromMap(response);

      List<SupplierEntity> list = [];
      list.add(
        SupplierEntity(
          name: listSuppliersModel.fornecedorMaisCompetitivo.nome,
          isBetterOption: true,
          products: listSuppliersModel.fornecedorMaisCompetitivo.produtos
              .map((product) {
            return ProductEntity(
              id: generateMd5(product.nome),
              name: product.nome,
              unitPrice: product.precoUnitario,
              description: product.descricao,
            );
          }).toList(),
          totalPrice: listSuppliersModel.fornecedorMaisCompetitivo.precoTotal,
        ),
      );

      for (var supplier in listSuppliersModel.fornecedores) {
        list.add(
          SupplierEntity(
            name: supplier.nome,
            totalPrice: supplier.precoTotal,
            isBetterOption: false,
            products: supplier.produtos.map((product) {
              return ProductEntity(
                id: generateMd5(product.nome),
                name: product.nome,
                unitPrice: product.precoUnitario,
                description: product.descricao,
              );
            }).toList(),
          ),
        );
      }

      return list;
    } catch (e) {
      log("Erro ao buscar a lista de compras e seus preços na API");
      rethrow;
    }
  }

  Map<String, dynamic> _makeBodySearch(ShoppingListEntity shoppingList) {
    return {
      "produtos": shoppingList.products.map(
        (product) {
          String quantity = product.measure ?? "1";
          String description = "";
          if (product.brand != null) description += product.brand.toString();
          if (product.description != null) {
            description += " ${product.description}";
          }

          return {
            "nome": product.name,
            "quantidade": quantity,
            "unidadeMedida":
                _parsingUnitOfMeasurement(product.unitOfMeasurement),
            "descricao": description,
          };
        },
      ).toList(),
    };
  }

  String _parsingUnitOfMeasurement(String? unit) {
    if (unit == null) return "Un";

    Map<String, dynamic> quantifiers = {
      "unidade(s)": "Un",
      "ml": "ml",
      "l": "L",
      "mg": "mg",
      "g": "g",
      "kg": "Kg",
      "caixa(s)": "Un",
      "garrafa(s)": "Un",
      "lata(s)": "Un",
      "pacote(s)": "Un",
      "galão(ões)": "Un",
      "": "",
    };

    return quantifiers[unit];
  }
}
