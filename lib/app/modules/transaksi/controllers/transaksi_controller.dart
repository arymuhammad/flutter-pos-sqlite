import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_first_app/app/models/master_barang_model.dart';
import 'package:my_first_app/app/service/service_api.dart';

import '../../../helper/db_helper.dart';
import '../../../models/master_barang_db.dart';

class TransaksiController extends GetxController {
  var dataBarang = <MasterBarang>[].obs;
  var dbBarang = <MasterBarangDb>[].obs;
  var listdata = [].obs;
  var barcodeBarang = ''.obs;
  var initNum = 1.obs;
  var generateTrx =
      int.parse(DateFormat('ddMMyyHHmmss').format(DateTime.now())).obs;

  var total = 0.obs;
  var kembalian = 0.obs;
  final count = 0.obs;
  String? barkode;
  TextEditingController transaksi = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchDtBarang(barkode);
    scanBarcodeDiscovery();
    // clearTable();
  }

  fetchDtBarang(barkode) async {
    // var dtBarang = await ServiceApi().fetchDataMasterBarang(barkode);

    // dataBarang.value = dtBarang;
    await SQLHelper.instance.getItem(barkode).then((data) {
      dbBarang.value = data;
    });
  }

  @override
  void pembayaran(String bayar) async {
    var result = int.parse(bayar) - total.value;
    kembalian.value = result;
    print(kembalian.value);
  }

  void scanBarcodeDiscovery() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      // print(barcodeScanRes);
      transaksi.text = barcodeScanRes;
      await fetchDtBarang(barcodeScanRes);

      final int index1 = dbBarang
          .indexWhere(((book) => book.kodeBarang == int.parse(barcodeScanRes)));

      if (index1 != -1) {
        // print('Index: $index1');
        // print(transaksiController.dataBarang[index1].kodeBarang);
      } else {
        // Get.snackbar('Kesalahan',
        //     'Kode Barang $barcodeScanRes tidak ditemukan\nHarap periksa Kode Barang!',
        //     snackPosition: SnackPosition.BOTTOM,
        //     backgroundColor: Colors.redAccent[700],
        //     colorText: Colors.white,
        //     icon: const Icon(Icons.cancel, color: Colors.white));
        // transaksi.clear();
        Fluttertoast.showToast(
            msg: "Kode barang atau Stok tidak ada.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey,
            textColor: Colors.white,
            fontSize: 16.0);
        // myFocusNode.requestFocus();
      }

      if (dbBarang[index1].stok == 0) {
        Fluttertoast.showToast(
            msg:
                "Stok barang kosong, Harap periksa stok barang di menu Data Stok.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.redAccent[700],
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        listdata.add(MasterBarangDb(
            kodeBarang: int.parse(barcodeScanRes),
            namaBarang: dbBarang[index1].namaBarang,
            hargaBarang: dbBarang[index1].hargaBarang,
            // awal: dataBarang[index1].awal,
            // masuk: dataBarang[index1].masuk,
            // keluar: 0,
            // sisa: dataBarang[index1].sisa
            stok: dbBarang[index1].stok));
        transaksi.clear();
        // myFocusNode.requestFocus();
        var initialV = 0;
        int sum = listdata.fold(
            initialV,
            (hargaBarang, dst) =>
                hargaBarang.toInt() + int.parse(dst.hargaBarang.toString()));
        // print('$sum fold');
        total.value = sum;
        // print(barcodeBarang + ' barcode nih scan');
        scanBarcodeDiscovery();
      }
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    // if (!mounted) return;

    // setState(() {
    //   _scanBarcode = barcodeScanRes;
    // });
  }

  clearTable() async {
    await SQLHelper.instance.clearTable();
  }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  // @override
  // void onClose() {
  //   super.onClose();
  // }
}
