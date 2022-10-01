import 'package:shoppinglist/domain/entities/product_entity.dart';

abstract class AddProductOnListUsecase {
  Future<void> addProduct(String idList, ProductEntity product);
}
