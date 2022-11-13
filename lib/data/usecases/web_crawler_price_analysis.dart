import 'dart:developer';

import 'package:shoppinglist/data/http/http_client.dart';
import 'package:shoppinglist/data/models/shopping_list_supplier_model.dart';
import 'package:shoppinglist/domain/entities/entities.dart';
import 'package:shoppinglist/domain/entities/supplier_entity.dart';
import 'package:shoppinglist/domain/usecases/price_analysis_usecase.dart';
import 'package:shoppinglist/utils/generate_md5.dart';

import '../mock/price_analysis.dart';

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

      var listSuppliersModel = ShoppingListSupplierModel.fromMap(priceAnalysisResponse);

      List<SupplierEntity> list = [];
      list.add(
        SupplierEntity(
          name: listSuppliersModel.fornecedorMaisCompetitivo.nome,
          isBetterOption: true,
          products: listSuppliersModel.fornecedorMaisCompetitivo.produtos.map((product) {
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
      "produtos": shoppingList.products
          .map(
            (e) => {
              "nome": e.name,
              "quantidade": e.measure,
              "unidadeMedida": e.unitOfMeasurement,
              "descricao": " ${e.description} ${e.brand}",
            },
          )
          .toList(),
    };
  }
}
