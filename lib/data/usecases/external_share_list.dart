import 'package:shoppinglist/domain/entities/shopping_list_entity.dart';
import 'package:shoppinglist/domain/entities/supplier_entity.dart';
import 'package:shoppinglist/domain/usecases/usecases.dart';
import 'package:shoppinglist/infra/packages/share_adapter.dart';

class ExternalShareList implements ShareListUsecase, ShareSupplierUsecase {
  final ShareAdapter shareAdapter;

  ExternalShareList(this.shareAdapter);

  @override
  Future<void> shareList(ShoppingListEntity shoppingList) async {
    try {
      String products = "";

      for (var prod in shoppingList.products) {
        String temp = "${prod.name}\n";
        if (prod.brand != null) {
          temp += "- Marca: ${prod.brand}\n";
        }
        if (prod.description != null) {
          temp += "- Descrição: ${prod.description}\n";
        }
        if (prod.measure != null && prod.unitOfMeasurement != null) {
          temp += "- Qtd: ${prod.measure} ${prod.unitOfMeasurement}\n";
        }
        if (prod.unitPrice != null) {
          temp += "- Preço: ${prod.unitPrice}\n";
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

  @override
  Future<void> shareSupplier(SupplierEntity supplier) async {
    try {
      String products = "";

      for (var prod in supplier.products) {
        String temp = "${prod.name}\n";
        if (prod.brand != null) {
          temp += "- Marca: ${prod.brand}\n";
        }
        if (prod.description != null) {
          temp += "- Descrição: ${prod.description}\n";
        }
        if (prod.measure != null && prod.unitOfMeasurement != null) {
          temp += "- Qtd: ${prod.measure} ${prod.unitOfMeasurement}\n";
        }
        if (prod.unitPrice != null) {
          temp += "- Preço: R\$ ${prod.unitPrice}\n";
        }
        temp += "\n";
        products += temp;
      }

      String content = supplier.name;

      content += "\n\n-----\n\n";
      content += "Produtos: \n";
      content += products;

      await shareAdapter.share(content);
    } catch (e) {
      throw Exception("Não foi possível compartilhar a lista");
    }
  }
}
