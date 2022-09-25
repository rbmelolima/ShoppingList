import 'package:shoppinglist/domain/entities/shopping_list_entity.dart';
import 'package:shoppinglist/domain/usecases/usecases.dart';
import 'package:shoppinglist/infra/packages/share_adapter.dart';

class ExternalShareList implements ShareListUsecase {
  final ShareAdapter shareAdapter;

  ExternalShareList(this.shareAdapter);

  @override
  Future<void> share(ShoppingListEntity shoppingList) async {
    try {
      String products = "";

      for (var prod in shoppingList.products) {
        String temp = "${prod.name}\n";
        if (prod.company != null) {
          temp += "- Marca: ${prod.company}\n";
        }
        if (prod.description != null) {
          temp += "- Descrição: ${prod.description}\n";
        }
        if (prod.measure != null && prod.unitOfMeasurement != null) {
          temp += "- Qtd: ${prod.measure} ${prod.unitOfMeasurement}\n";
        }
        temp += "\n";
        products += temp;
      }

      String content = "Lista de compras: ${shoppingList.name}";

      DateTime? data = DateTime.tryParse(shoppingList.updatedAt);
      if (data != null) {
        content +=
            "\nÚltima att: ${data.day}/${data.month}/${data.year}, às ${data.hour}:${data.minute}";
      }

      content += "\n\n-----\n\n";
      content += "Produtos: \n";
      content += products;

      await shareAdapter.share(content);
    } catch (e) {
      throw Exception("Não foi possível compartilhar a lista");
    }
  }
}
