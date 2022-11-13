import 'package:shoppinglist/domain/entities/supplier_entity.dart';

abstract class ShareSupplierUsecase {
  Future<void> shareSupplier(SupplierEntity supplier);
}
