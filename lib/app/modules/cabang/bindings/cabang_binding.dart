import 'package:get/get.dart';

import '../controllers/cabang_controller.dart';

class CabangBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CabangController>(
      () => CabangController(),
    );
  }
}
