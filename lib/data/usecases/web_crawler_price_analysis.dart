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
      /* 
      const String urlAPI = "";
      var response = await httpClient.request(
        url: urlAPI,
        method: "post",
        body: _makeBodySearch(shoppingList),
      ); 
      */
      var response = {
        "fornecedores": [
          {
            "nome": "Pão de Açúcar",
            "produtos": [
              {"nome": "Maçã Nacional Qualitá 1kg", "quantidade": 1, "precoUnitario": 15.39}
            ],
            "precoTotal": "R\$ 15,39"
          },
          {
            "nome": "Carrefour",
            "produtos": [
              {"nome": "Maçã Pink Lady - 1kg", "quantidade": 1, "precoUnitario": 11.9}
            ],
            "precoTotal": "R\$ 11,90"
          }
        ],
        "fornecedorMaisCompetitivo": {
          "nome": "Clube Extra",
          "produtos": [
            {"nome": "Maçã Pré-Lavada Gala Pra Valer 1kg", "quantidade": 1, "precoUnitario": 11.39}
          ],
          "precoTotal": "R\$ 11,39"
        }
      };

      ShoppingListSupplierModel listSuppliersModel = ShoppingListSupplierModel.fromMap(response);

      List<SupplierEntity> list = [];
      list.add(
        SupplierEntity(
          name: listSuppliersModel.fornecedorMaisCompetitivo.nome,
          products: listSuppliersModel.fornecedorMaisCompetitivo.produtos.map((product) {
            return ProductEntity(
              id: generateMd5(product.nome),
              name: product.nome,
              unitPrice: product.precoUnitario,
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
            products: supplier.produtos.map((product) {
              return ProductEntity(
                id: generateMd5(product.nome),
                name: product.nome,
                unitPrice: product.precoUnitario,
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
      "produtos": shoppingList.products
          .map(
            (e) => {
              "nome": "${e.name} ${e.description} ${e.brand}",
              "quantidade": e.measure,
              "unidadeMedida": e.unitOfMeasurement,
            },
          )
          .toList(),
    };
  }
}
