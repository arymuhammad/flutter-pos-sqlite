import 'package:get/get.dart';
import 'package:my_first_app/app/modules/best_seller_detail/models/best_seller_detail.dart';
import 'package:my_first_app/app/service/service_api.dart';

class BestSellerDetailController extends GetxController {
  var bestSellers = BestSellerDetail().obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchBestSellerDetail();
  }

  fetchBestSellerDetail() async {
    var penjualan = await ServiceApi().fetchBestSelletDetail();

    // print(penjualan.data![1].departemen);

    bestSellers.value = penjualan;
    isLoading.value = false;
  }
}
