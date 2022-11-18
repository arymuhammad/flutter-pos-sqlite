import 'package:get/get.dart';

import '../controllers/sales_controller.dart';

class SalesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SalesController>(
      () => SalesController(),
    );
  }
}
