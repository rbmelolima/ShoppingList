import 'package:faker/faker.dart';
import 'package:shoppinglist/domain/entities/entities.dart';

ShoppingListEntity generateShoppingListEntityMock() {
  return ShoppingListEntity(
    id: faker.guid.guid(),
    name: faker.lorem.words(2).toString(),
    createdAt: DateTime.now().toString(),
    updatedAt: DateTime.now().toString(),
    description: faker.lorem.sentences(2).toString(),
    products: [],
  );
}
