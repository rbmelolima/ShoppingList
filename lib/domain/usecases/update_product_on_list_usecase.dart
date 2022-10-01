import 'package:shoppinglist/domain/entities/product_entity.dart';

abstract class UpdateProductOnListUsecase {
  Future<void> updateProduct(String idList, ProductEntity product);
}
