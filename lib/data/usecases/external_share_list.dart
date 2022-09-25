import 'package:shoppinglist/domain/entities/shopping_list_entity.dart';
import 'package:shoppinglist/domain/usecases/usecases.dart';
import 'package:shoppinglist/infra/packages/share_adapter.dart';

class ExternalShareList implements ShareListUsecase {
  final ShareAdapter shareAdapter;

  ExternalShareList(this.shareAdapter);

  @override
  Future<void> share(ShoppingListEntity shoppingList) async {
    try {
      String content = "Lista de compras: ${shoppingList.name}";
      // TODO: melhorar o texto de compartilhamento
      await shareAdapter.share(content);
    } catch (e) {
      throw Exception("Não foi possível compartilhar a lista");
    }
  }
}
