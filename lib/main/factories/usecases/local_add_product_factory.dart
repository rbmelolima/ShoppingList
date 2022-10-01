import 'package:shoppinglist/data/usecases/usecases.dart';
import 'package:shoppinglist/domain/usecases/add_product_on_list_usecase.dart';
import 'package:shoppinglist/main/factories/usecases/usecases.dart';

AddProductOnListUsecase makeLocalAddProduct() {
  return LocalAddProduct(makeLocalGetLists(), makeLocalUpdateList());
}
