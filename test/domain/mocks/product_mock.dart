import 'package:faker/faker.dart';
import 'package:shoppinglist/domain/entities/product_entity.dart';

ProductEntity generateProductEntityMock() {
  return ProductEntity(
    name: faker.food.dish(),
    id: faker.guid.guid(),
    company: faker.company.name(),
    description: faker.lorem.sentence().toString(),
    measure: 10.toString(),
    unitOfMeasurement: "u",
  );
}
