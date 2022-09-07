import 'package:shoppinglist/data/usecases/usecases.dart';
import 'package:shoppinglist/domain/usecases/usecases.dart';
import 'package:shoppinglist/main/factories/cache/cache.dart';

CreateListUsecase makeLocalCreateList() {
  return LocalCreateList(makeLocalStorageAdapter());
}
