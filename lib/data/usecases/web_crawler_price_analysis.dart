import 'dart:developer';

import 'package:shoppinglist/data/http/http_client.dart';
import 'package:shoppinglist/data/models/shopping_list_supplier_model.dart';
import 'package:shoppinglist/domain/entities/entities.dart';
import 'package:shoppinglist/domain/entities/supplier_entity.dart';
import 'package:shoppinglist/domain/usecases/price_analysis_usecase.dart';
import 'package:shoppinglist/utils/generate_md5.dart';

class WebCrawlerPriceAnalysis implements PriceAnalysisUsecase {
  final HttpClient httpClient;
  final String apiEndpoint;

  WebCrawlerPriceAnalysis(this.httpClient, this.apiEndpoint);

  @override
  Future<List<SupplierEntity>> analysis(ShoppingListEntity shoppingList) async {
    try {
      var body = _makeBodySearch(shoppingList);

      var response = await httpClient.request(
        url: apiEndpoint,
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
          String description = "";

          if (product.brand != null) {
            description += product.brand.toString();
          }

          if (product.description != null) {
            if (product.brand != null) description += " ";
            description += "${product.description}";
          }

          return {
            "nome": "${product.name} $description",
            "quantidade":
                product.unitOfMeasurement == "unidade(s)" ? product.measure : 1,
          };
        },
      ).toList(),
    };
  }
}
