import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_first_app/app/models/master_barang_model.dart';

import '../../../helper/db_helper.dart';
import '../../../models/master_barang_db.dart';
import '../../../service/service_api.dart';

class StockController extends GetxController {
  var dataMaster = <MasterBarang>[].obs;
  var dbMaster = <MasterBarangDb>[].obs;
  var isLoading = true.obs;
  // var isLengthData = 0.obs;
  var isSearch = true.obs;
  String? barcode;
  String? kode;
  final count = 0.obs;
  final List<String> selected =
      ["", "AWAL (Stock Awal Barang)", "IN (Barang Masuk)"].obs;
  var selectedItem = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // fetchdataMaster(barcode);
    getData();
    // getItem(kode);
  }

  fetchdataMaster(String? barcode) async {
    // var ldt = barcode.toString().length;
    // print(merk);
    // if (ldt > 0 && barcode != null) {
    var dataBarang = await ServiceApi().fetchDataMasterBarang(barcode);
    // if (dataBarang.toList().length <= 0) {
    //   return print('ROROROR');
    // }
    dataMaster.value = dataBarang;
    isLoading.value = false;
    // } else {
    //   return;
    // }
  }

  void increment() => count.value++;

  getData() async {
    await SQLHelper.instance.queryAllRows().then((data) {
      dbMaster.value = data;
      isLoading.value = false;
    });
  }

  getItem(kode) async {
    await SQLHelper.instance.getItem(kode).then((data) {
      dbMaster.value = data;
      isLoading.value = false;
    });
  }

  addData(kode, nama, harga, stok, created) async {
    await SQLHelper.instance.insertMasterBarang(MasterBarangDb(
        kodeBarang: int.parse(kode),
        namaBarang: nama,
        hargaBarang: int.parse(harga),
        stok: int.parse(stok),
        createdAt: created));
    // dbMaster.insert(
    // 0, MasterBarangDb(id: taskData.length, title: addTaskController.text));
    // addTaskController.clear();
  }

  updateData(kode, nama, harga, stok) async {
    final data = MasterBarangDb(
        kodeBarang: kode,
        namaBarang: nama,
        hargaBarang: int.parse(harga),
        stok: int.parse(stok));

    await SQLHelper.instance.upadteMasterBarang(data).then((data) {});
  }

  void delete(int id) async {
    await SQLHelper.instance.delete(id);
    // dataMaster.removeWhere((element) => element.id == id);
  }
}
