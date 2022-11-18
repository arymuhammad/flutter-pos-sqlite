import 'package:get/get.dart';
import 'package:my_first_app/app/models/cabang_model.dart';
import 'package:my_first_app/app/service/service_api.dart';

class CabangController extends GetxController {
  var dataCabang = <Cabang>[].obs;
  RxList<Cabang> searchCabang = RxList<Cabang>([]);

  var isLoading = true.obs;
  var isSearch = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCabang();
    searchCabang.value = dataCabang;
  }

  fetchCabang() async {
    var cabang = await ServiceApi().fetchDataCabang();

    dataCabang.value = cabang;
    isLoading.value = false;
  }

  @override
  void filterCabang(String namaCabang) {
    List<Cabang> result = [];

    if (namaCabang.isEmpty) {
      result = dataCabang;
    } else {
      result = dataCabang
          .where((e) => e.nama
              .toString()
              .toLowerCase()
              .contains(namaCabang.toLowerCase()))
          .toList();
    }
    searchCabang.value = result;
  }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  // @override
  // void onClose() {
  //   super.onClose();
  // }

  // void increment() => count.value++;
}
