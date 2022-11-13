import 'package:shoppinglist/data/usecases/local_update_product.dart';
import 'package:shoppinglist/domain/usecases/update_product_on_list_usecase.dart';
import 'package:shoppinglist/main/factories/usecases/usecases.dart';

UpdateProductOnListUsecase makeLocalUpdateProduct() {
  return LocalUpdateProduct(makeLocalGetLists(), makeLocalUpdateList());
}
