import 'package:shoppinglist/domain/entities/shopping_list_entity.dart';
import 'package:shoppinglist/domain/usecases/delete_product_on_list_usecase.dart';
import 'package:shoppinglist/domain/usecases/get_lists_usecase.dart';
import 'package:shoppinglist/domain/usecases/update_list_usecase.dart';

class LocalDeleteProduct implements DeleteProductOnListUsecase {
  final GetListsUsecase getListsUsecase;
  final UpdateListUsecase updateListUsecase;

  LocalDeleteProduct(this.getListsUsecase, this.updateListUsecase);

  @override
  Future<ShoppingListEntity> deleteProduct(
    String idList,
    String idProduct,
  ) async {
    try {
      var list = await getListsUsecase.getById(idList);
      if (list == null) {
        throw Exception("Não foi possível encontrar a lista");
      }
      list.products.removeWhere((element) => element.id == idProduct);
      return await updateListUsecase.update(list);
    } catch (e) {
      throw Exception("Não foi possível deletar o produto na lista");
    }
  }
}
