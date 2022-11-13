import 'package:shoppinglist/data/usecases/external_share_list.dart';

import '../packages/share_adapter_factory.dart';

dynamic makeExternalShareList() {
  return ExternalShareList(makeShareAdapter());
}
