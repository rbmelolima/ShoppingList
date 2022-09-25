import 'package:shoppinglist/data/usecases/external_share_list.dart';
import 'package:shoppinglist/domain/usecases/usecases.dart';

import '../packages/share_adapter_factory.dart';

ShareListUsecase makeExternalShareList() {
  return ExternalShareList(makeShareAdapter());
}
