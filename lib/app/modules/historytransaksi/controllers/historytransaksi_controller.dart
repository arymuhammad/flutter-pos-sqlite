import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_first_app/app/models/trx_model.dart';

import '../../../helper/db_helper.dart';
import '../../../models/trx_model_db.dart';
import '../../../service/app_exceptions.dart';
import '../../../service/base_client.dart';
import '../../home/controllers/home_controller.dart';

// import 'base_controller.dart';

class HistorytransaksiController extends GetxController {
  // var historyTrx = <Trx>[].obs;
  var historyTrxDb = <TrxDb>[].obs;
  var isLoading = true.obs;
  var isSearch = true.obs;
  var totalTrx = 0.obs;

  final List<String> selected = ["", "10", "20", "30", "40", "50", "100"].obs;
  var selectedItem = ''.obs;

  var url = 'http://${HomeController().url.value}/api-pos';

  // RxList<Trx> searchTrx = RxList<Trx>([]);
  RxList<TrxDb> searchTrx = RxList<TrxDb>([]);

  String? tgl1;
  String? tgl2;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    fetchDataHistory(tgl1, tgl2);
    // searchTrx.value = historyTrx;
    searchTrx.value = historyTrxDb;
  }

  // Future<List<Trx>> fetchDataHistory(
  //     String? tglAwal, String? tglAkhir, String? limit) async {
  //   if (tglAwal == null && tglAkhir == null && limit == null ||
  //       tglAwal == "" && tglAkhir == "" && limit == "") {
  //     tgl1 = DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();
  //     tgl2 = DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();
  //     lmt = "20";
  //   } else if (tglAwal == "" && tglAkhir == "" && limit != "") {
  //     tgl1 = DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();
  //     tgl2 = DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();
  //     lmt = limit;
  //   } else if (tglAwal != "" && tglAkhir != "" && limit == "") {
  //     tgl1 = tglAwal;
  //     tgl2 = tglAkhir;
  //     lmt = "20";
  //   } else {
  //     tgl1 = tglAwal;
  //     tgl2 = tglAkhir;
  //     lmt = limit;
  //   }

  //   // Future<List<Trx>> fetchHistoryTrx(
  //   //   String? tgl1, String? tgl2, String? limit) async {
  //   var response = await BaseClient()
  //       .get(url, '/transaksi/history.php?tgl1=$tgl1&tgl2=$tgl2&limit=$limit')
  //       .catchError(handleError);
  //   List<dynamic> dataTrx = json.decode(response)['rows'];
  //   List<Trx> trx = dataTrx.map((e) => Trx.fromJson(e)).toList();
  //   // print(response.body);
  //   print(url);
  //   historyTrx.value = trx;
  //   isLoading.value = false;
  //   return historyTrx;
  //   // }

  //   // var dtHistory = await ServiceApi().getDataTrx(tgl1, tgl2, lmt);
  //   // historyTrx.value = dtHistory;
  // }

  fetchDataHistory(String? tglAwal, String? tglAkhir) async {
    if (tglAwal == null && tglAkhir == null ||
        tglAwal == "" && tglAkhir == "") {
      tgl1 = DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();
      tgl2 = DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();
    } else if (tglAwal != "" && tglAkhir != "") {
      tgl1 = tglAwal;
      tgl2 = tglAkhir;
    }

    await SQLHelper.instance.queryAllTrx(tgl1, tgl2).then((data) {
      historyTrxDb.value = data;
      isLoading.value = false;
      totalTrx.value = historyTrxDb.fold( 0, (total, dst) => total.toInt() +int.parse(dst.total.toString()));
    });
  }

  filterDataTrx(String noTrx) {
    List<TrxDb> result = [];

    if (noTrx.isEmpty) {
      result = historyTrxDb;
    } else {
      result = historyTrxDb
          .where((e) =>
              e.noTrx.toString().toLowerCase().contains(noTrx.toLowerCase()))
          .toList();
    }
    searchTrx.value = result;
  }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  handleError(error) {
    hideLoading();
    if (error is BadRequestException) {
      var message = error.message;
      // DialogHelper().showErroDialog(description: message);
      Get.defaultDialog(
          title: 'Error',
          content: Text(message.toString()),
          confirm: ElevatedButton.icon(
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
              onPressed: () {
                fetchDataHistory(tgl1, tgl2);
                Get.back();
              }));
    } else if (error is FetchDataException) {
      var message = error.message;
      // DialogHelper().showErroDialog(description: message);
      Get.defaultDialog(
          title: 'Error',
          content: Text(message.toString()),
          confirm: ElevatedButton.icon(
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
              onPressed: () {
                fetchDataHistory(tgl1, tgl2);
                Get.back();
              }));
    } else if (error is ApiNotRespondingException) {
      // DialogHelper()
      //     .showErroDialog(description: 'Oops! It took longer to respond.');
      Get.defaultDialog(
          title: 'Error',
          content: const Text('Oops! It took longer to respond.'),
          confirm: ElevatedButton.icon(
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
              onPressed: () {
                fetchDataHistory(tgl1, tgl2);
                Get.back();
              }));
    }
  }

  showLoading([String? message]) {
    // DialogHelper.showLoading(message);
    Get.defaultDialog(
        title: '',
        content: const Center(
          child: CircularProgressIndicator(),
        ));
  }

  hideLoading() {
    // DialogHelper.hideLoading();
  }
}
