import 'package:shoppinglist/data/usecases/local_update_list.dart';
import 'package:shoppinglist/domain/usecases/update_list_usecase.dart';
import 'package:shoppinglist/main/factories/cache/cache.dart';

UpdateListUsecase makeLocalUpdateList() {
  return LocalUpdateList(makeLocalStorageAdapter());
}

