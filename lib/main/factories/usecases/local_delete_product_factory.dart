import 'package:shoppinglist/data/usecases/local_delete_product.dart';
import 'package:shoppinglist/domain/usecases/delete_product_on_list_usecase.dart';
import 'package:shoppinglist/main/factories/usecases/usecases.dart';

DeleteProductOnListUsecase makeLocalDeleteProduct() {
  return LocalDeleteProduct(makeLocalGetLists(), makeLocalUpdateList());
}
