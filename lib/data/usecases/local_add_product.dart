import 'package:shoppinglist/domain/entities/product_entity.dart';
import 'package:shoppinglist/domain/entities/shopping_list_entity.dart';
import 'package:shoppinglist/domain/usecases/add_product_on_list_usecase.dart';
import 'package:shoppinglist/domain/usecases/get_lists_usecase.dart';
import 'package:shoppinglist/domain/usecases/update_list_usecase.dart';

class LocalAddProduct implements AddProductOnListUsecase {
  final GetListsUsecase getListsUsecase;
  final UpdateListUsecase updateListUsecase;

  LocalAddProduct(this.getListsUsecase, this.updateListUsecase);

  @override
  Future<ShoppingListEntity> addProduct(
    String idList,
    ProductEntity product,
  ) async {
    try {
      var list = await getListsUsecase.getById(idList);
      if (list == null) {
        throw Exception("Não foi possível encontrar a lista");
      }
      list.products.add(product);
      return await updateListUsecase.update(list);
    } catch (e) {
      throw Exception("Não foi possível adicionar o produto na lista");
    }
  }
}
