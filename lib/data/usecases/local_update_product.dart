import 'package:shoppinglist/domain/entities/product_entity.dart';
import 'package:shoppinglist/domain/usecases/get_lists_usecase.dart';
import 'package:shoppinglist/domain/usecases/update_list_usecase.dart';
import 'package:shoppinglist/domain/usecases/update_product_on_list_usecase.dart';

class LocalUpdateProduct implements UpdateProductOnListUsecase {
  final GetListsUsecase getListsUsecase;
  final UpdateListUsecase updateListUsecase;

  LocalUpdateProduct(this.getListsUsecase, this.updateListUsecase);

  @override
  Future<void> updateProduct(String idList, ProductEntity product) async {
    try {
      var list = await getListsUsecase.getById(idList);
      if (list == null) {
        throw Exception("Não foi possível encontrar a lista");
      }
      int index = list.products.indexWhere(
        (element) => element.id == product.id,
      );
      list.products[index] = product;
      return await updateListUsecase.update(list);
    } catch (e) {
      throw Exception("Não foi possível deletar o produto na lista");
    }
  }
}
