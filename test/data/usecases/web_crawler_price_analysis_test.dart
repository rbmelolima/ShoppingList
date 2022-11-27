import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shoppinglist/data/usecases/usecases.dart';
import 'package:shoppinglist/domain/entities/entities.dart';

import 'package:shoppinglist/utils/generate_md5.dart';

import '../mocks/http_client_spy.dart';
import '../mocks/response.dart';

void main() {
  late WebCrawlerPriceAnalysis sut;
  late HttpClientSpy httpClientSpy;
  late String apiEndpoint;

  setUp(() {
    apiEndpoint = faker.internet.httpsUrl();
    httpClientSpy = HttpClientSpy();
    sut = WebCrawlerPriceAnalysis(httpClientSpy, apiEndpoint);
  });

  test(
    'Garantindo que o método está chamando o endpoint com os parâmetros corretos',
    () async {
      httpClientSpy.mockRequest(response);

      ShoppingListEntity shoppingList = ShoppingListEntity(
        id: generateMd5("Mercado"),
        createdAt: DateTime.now().toString(),
        updatedAt: DateTime.now().toString(),
        name: "Mercado",
        products: [
          ProductEntity(
            name: "Feijão",
            description: "Preto",
            unitOfMeasurement: "unidade(s)",
            measure: "5",
            id: generateMd5("Feijão"),
          ),
        ],
      );

      await sut.analysis(shoppingList);

      verify(
        () => httpClientSpy.request(
          url: apiEndpoint,
          method: 'post',
          headers: null,
          body: {
            "produtos": [
              {"nome": "Feijão Preto", "quantidade": 5},
            ]
          },
        ),
      );
    },
  );
}

// Testar o body do request
// Testar o retorno do método