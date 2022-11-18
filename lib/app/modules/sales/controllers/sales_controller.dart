import 'dart:async';

import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'package:my_first_app/app/models/sales_discovery.dart';
import 'package:my_first_app/app/models/sales_summary_model.dart';
import 'package:my_first_app/app/service/service_api.dart';

import 'package:my_first_app/app/models/sales_model.dart';

class SalesController extends GetxController
    with StateMixin<List<SalesOutlet>> {
  var sales = <SalesOutlet>[].obs;
  RxList<SalesOutlet> searchSales = RxList<SalesOutlet>([]);

  var salesSummary = Result().obs;
  var salesTop = <ResultTop>[].obs;
  var discovery = <Discovery>[].obs;
  var isLoading = true.obs;
  var connectionStatus = 0.obs;
  var isLengthData = 0.obs;
  var isSearch = true.obs;

  String? tgl1;
  String? tgl2;
  String? merk;
  String? lmt;

  final List<String> selected = ["", "10", "20", "30", "40", "50", "100"].obs;
  var selectedItem = ''.obs;

  late StreamSubscription<InternetConnectionStatus> _listener;

  @override
  void onInit() {
    fetchDiscovery(merk);
    super.onInit();
    // fetchSalesSummary();
    // fetchTopSummary();

    searchSales.value = sales;
  }

  fetchSales(String? tglAwal, String? tglAkhir, String? limit) async {
    if (tglAwal == null && tglAkhir == null && limit == null ||
        tglAwal == "" && tglAkhir == "" && limit == "") {
      tgl1 = DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();
      tgl2 = DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();
      lmt = "20";
    } else if (tglAwal == "" && tglAkhir == "" && limit != "") {
      tgl1 = DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();
      tgl2 = DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();
      lmt = limit;
    } else if (tglAwal != "" && tglAkhir != "" && limit == "") {
      tgl1 = tglAwal;
      tgl2 = tglAkhir;
      lmt = "20";
    } else {
      tgl1 = tglAwal;
      tgl2 = tglAkhir;
      lmt = limit;
    }
    var penjualan = await ServiceApi().fetchSalesOutlet(tgl1, tgl2, lmt);

    if (sales != null) {
      sales.value = penjualan;
      isLoading.value = false;
    } else {
      isLoading.value = true;
    }
  }

  fetchSalesSummary() async {
    var summary = await ServiceApi().fetchSalesSummary();

    salesSummary.value = summary;
    isLoading.value = false;
  }

  fetchTopSummary() async {
    var topSummary = await ServiceApi().fetchTopSalesSummary();

    salesTop.value = topSummary;
    isLoading.value = false;
  }

  fetchDiscovery(String? merk) async {
    var ldt = merk.toString().length;
    // print(merk);
    if (ldt > 0 && merk != null) {
      var dataDiscovery = await ServiceApi().fetchDataDiscovery(merk);
      if (dataDiscovery.toList().isEmpty) {
        return print('ROROROR');
      }
      discovery.value = dataDiscovery;
      isLoading.value = false;
    } else {
      return;
    }
  }

  @override
  void onClose() {
    _listener.cancel();
  }

  @override
  void filterSales(String store) {
    List<SalesOutlet> result = [];

    if (store.isEmpty) {
      result = sales;
    } else {
      result = sales
          .where((e) =>
              e.cabang.toString().toLowerCase().contains(store.toLowerCase()))
          .toList();
    }
    searchSales.value = result;
  }

  @override
  void onReady() {
    super.onReady();
    fetchSales(tgl1, tgl2, lmt);

    _listener = InternetConnectionChecker()
        .onStatusChange
        .listen((InternetConnectionStatus status) {
      switch (status) {
        case InternetConnectionStatus.connected:
          connectionStatus.value = 1;

          // Get.snackbar('SUCCESS', 'Anda Terhubung Kembali', duration: Duration(seconds: 5), maxWidth: double.infinity, snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green, colorText: Colors.white, icon: Icon(Icons.check_circle_outline));

          break;

        case InternetConnectionStatus.disconnected:
          connectionStatus.value = 0;

          // Get.snackbar('ERROR', 'Tidak Ada Koneksi Internet', duration: Duration(seconds: 5), maxWidth: double.infinity, snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white, icon: Icon(Icons.cancel_outlined));

          break;
      }
    });
  }
}
