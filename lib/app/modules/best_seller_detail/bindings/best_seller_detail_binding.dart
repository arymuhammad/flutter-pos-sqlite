import 'package:get/get.dart';

import '../controllers/best_seller_detail_controller.dart';

class BestSellerDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BestSellerDetailController>(
      () => BestSellerDetailController(),
    );
  }
}
