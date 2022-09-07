import 'package:shoppinglist/data/usecases/usecases.dart';
import 'package:shoppinglist/domain/usecases/usecases.dart';
import 'package:shoppinglist/main/factories/cache/cache.dart';

GetListsUsecase makeLocalGetLists() {
  return LocalGetLists(makeLocalStorageAdapter());
}
