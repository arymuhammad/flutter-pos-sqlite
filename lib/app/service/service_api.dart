// ignore_for_file: unnecessary_null_comparison

import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:my_first_app/app/models/master_barang_model.dart';
import 'package:my_first_app/app/modules/best_seller_detail/models/best_seller_detail.dart';
import 'package:my_first_app/app/models/sales_model.dart';
import 'package:my_first_app/app/models/sales_summary_model.dart';
import 'package:my_first_app/app/modules/home/controllers/home_controller.dart';

import '../models/cabang_model.dart';
import '../models/detail_trx_model.dart';
import '../models/sales_discovery.dart';
import '../models/trx_model.dart';
import 'base_client.dart';

class ServiceApi {
  var apiUrl = 'http://103.112.139.155:9000/api/';
  
  final client = Dio();
  var url = 'http://${HomeController().url.value}/api-pos';

  Future<List<SalesOutlet>> fetchSalesOutlet(
      String? tglAwl, String? tglAkhir, String? limit) async {
    // if (InternetConnectionStatus.values == 0) {
    //   Get.snackbar('ERROR', 'No Internet Connection',
    //       duration: Duration(seconds: 5),
    //       maxWidth: double.infinity,
    //       snackPosition: SnackPosition.BOTTOM,
    //       backgroundColor: Colors.red,
    //       colorText: Colors.white,
    //       icon: Icon(Icons.cancel_outlined));
    // }
    print('${limit!} ini adalah limit');
    var url =
        'http://103.112.139.155:9000/api/sales/outlet?datefrom=${tglAwl!}&dateto=${tglAkhir!}&cabang=UC000,UC001,UC002,UC004,UC005,UC006,UC008,UC011,UC012,UC013,UC014,UC015,UC016,UC017,UC018,UC019,UC020,UC021,UC022,UC023,UC024,UC025,UC026,UC027,UC028,UC029,UC030,UC031,UC032,UC033,UC034,UC035,UC036,UC037,UC038,UC039,UC041,UC042,UC043,UC044,UC046,UC047,UC048,UC049,UC050,UC051,UC099,UC300,UC301,UC302,UC999,UE501,UE502,UE503,UE504,UE505,UE506,UE507,UE508,UE509,UE510,UE511,UE512,UE513,UE514,UE515,UE516,UE517,UE518,UE519,UE520,UE521,UE522,UE523,UE524,UE525,UE526,UE527,UE528,UE529,UE530,UE531,UR88&data=daily&limit=$limit';
    // print(url);
    var response =
        await http.get(Uri.parse(url), headers: {"API_KEY": "53713"});
    List<dynamic> jsonString = json.decode(response.body)['data'];
    // print(jsonString);
    List<SalesOutlet> result =
        jsonString.map((e) => SalesOutlet.fromJson(e)).toList();
    return result;
  }

  Future<BestSellerDetail> fetchBestSelletDetail() async {
    var pathUrl =
        'sales/best-seller/detail?datefrom=2021-11-01&dateto=2021-11-01&cabang=UC000,UC001,UC002,UC004,UC005,UC006,UC008,UC011,UC012,UC013,UC014,UC015,UC016,UC017,UC018,UC019,UC020,UC021,UC022,UC023,UC024,UC025,UC026,UC027,UC028,UC029,UC030,UC031,UC032,UC033,UC034,UC035,UC036,UC037,UC038,UC039,UC041,UC042,UC043,UC044,UC046,UC047,UC048,UC049,UC050,UC051,UC099,UC300,UC301,UC302,UC999,UE501,UE502,UE503,UE504,UE505,UE506,UE507,UE508,UE509,UE510,UE511,UE512,UE513,UE514,UE515,UE516,UE517,UE518,UE519,UE520,UE521,UE522,UE523,UE524,UE525,UE526,UE527,UE528,UE529,UE530,UE531,UR88&merk=';
    var response = await http
        .get(Uri.parse(apiUrl + pathUrl), headers: {"API_KEY": "53713"});
    var jsonString = json.decode(response.body);
    // List<BestSellerDetail> bestSellerDetail =
    //     jsonString.map((e) => BestSellerDetail.fromJson(e)).toList();
    BestSellerDetail bestSellerDetail = BestSellerDetail.fromJson(jsonString);
    // print(bestSellerDetail);
    return bestSellerDetail;
  }

  Future<Result> fetchSalesSummary() async {
    var pathUrl = 'sales/summary';
    var response = await http
        .get(Uri.parse(apiUrl + pathUrl), headers: {"API_KEY": "53713"});
    var jsonString = json.decode(response.body)['data']['result'];

    // List<BestSellerDetail> bestSellerDetail =
    //     jsonString.map((e) => BestSellerDetail.fromJson(e)).toList();
    Result sales = Result.fromJson(jsonString);
    // print(jsonString);
    return sales;
  }

  Future<List<ResultTop>> fetchTopSalesSummary() async {
    var pathUrl = 'sales/summary';
    var response = await http
        .get(Uri.parse(apiUrl + pathUrl), headers: {"API_KEY": "53713"});
    List<dynamic> resTop = json.decode(response.body)['data']['result_top'];
    // var rest = resTop['result_top'] as List;
    // List<BestSellerDetail> bestSellerDetail =
    //     jsonString.map((e) => BestSellerDetail.fromJson(e)).toList();
    List<ResultTop> salesTop =
        resTop.map((e) => ResultTop.fromJson(e)).toList();
    // print(resTop);
    return salesTop;
  }

  Future<List<Cabang>> fetchDataCabang() async {
    var pathUrl = 'cabang';
    var response = await http
        .get(Uri.parse(apiUrl + pathUrl), headers: {"API_KEY": "53713"});

    List<dynamic> dtCabang = json.decode(response.body)['data'];
    //     jsonString.map((e) => BestSellerDetail.fromJson(e)).toList();
    List<Cabang> cabang = dtCabang.map((e) => Cabang.fromJson(e)).toList();
    // print(dtCabang);
    return cabang;
  }

  Future<List<Discovery>> fetchDataDiscovery(String? artikel) async {
    var pathUrl = 'sales/discovery?search=$artikel';
    var response = await http
        .get(Uri.parse(apiUrl + pathUrl), headers: {"API_KEY": "53713"});
    // print(pathUrl);
    List<dynamic> dtDiscovery = json.decode(response.body)['data'];
    List<Discovery> discovery =
        dtDiscovery.map((e) => Discovery.fromJson(e)).toList();
    return discovery;
  }

  // Future<List<MasterBarang>> fetchBarcode() async {
  //   var pathUrl = 'http://103.112.139.155/api-pos/stock/cekstock.php';
  //   var response = await http.get(Uri.parse(pathUrl));

  //   List<dynamic> kdBarang = json.decode(response.body)['rows'];
  //   List<MasterBarang> dtBarang =
  //       kdBarang.map((e) => MasterBarang.fromJson(e)).toList();
  //   // print(kdBarang);
  //   return dtBarang;
  // }

  Future<List<MasterBarang>> fetchDataMasterBarang(String? barcode) async {
    var pathUrl =
        'http://103.112.139.155/api-pos/stock/cekstock.php?kode_barang=$barcode&nama_barang=$barcode';
    var response = await http.get(Uri.parse(pathUrl));
    print(pathUrl);
    List<dynamic> kdBarang = json.decode(response.body)['rows'];
    List<MasterBarang> dtBarang =
        kdBarang.map((e) => MasterBarang.fromJson(e)).toList();

    return dtBarang;
  }

  postData(data) async {
    //   final url = Uri.parse('http://103.112.139.155/api-pos/transaksi/input.php');
    // final headers = {"Content-type": "application/json"};
    // final json = jsonEncode(data);
    // final response = await http.post(url, headers: headers, body: json);
    var response = await http.post(
        Uri.parse('http://103.112.139.155/api-pos/transaksi/input.php'),
        // headers: {
        //   HttpHeaders.contentTypeHeader: 'application/json',
        // },
        body: data);
    // print('Status code: ${response.statusCode}');
    // print('Body: $data');
    // print('response body :${response.body}');
  }

  updateMasterBarang(data) async {
    var response = await http.post(
        Uri.parse('http://103.112.139.155/api-pos/stock/update_stock.php'),
        // headers: {
        //   HttpHeaders.contentTypeHeader: 'application/json',
        // },
        body: data);
    // print('Status code: ${response.statusCode}');
    // print('Body: $data');
    // print('response body :${response.body}');
  }

  updateMasterTrx(data) async {
    var response = await http.post(
        Uri.parse('http://103.112.139.155/api-pos/stock/update_stockV2.php'),
        // headers: {
        //   HttpHeaders.contentTypeHeader: 'application/json',
        // },
        body: data);
    // print('Status code: ${response.statusCode}');
    // print('Body: $data');
    // print('response body :${response.body}');
  }

  postDataPenjualan(dataPenjualan) async {
    var response = await http.post(
        Uri.parse('http://103.112.139.155/api-pos/transaksi/input.php'),
        // headers: {
        //   HttpHeaders.contentTypeHeader: 'application/json',
        // },
        body: dataPenjualan);
    print('Status code: ${response.statusCode}');
    print('Body: $dataPenjualan');
    print('response body :${response.body}');
  }

  Future<List<Trx>> fetchHistoryTrx(
      String? tgl1, String? tgl2, String? limit) async {
    var pathUrl =
        'http://103.112.139.155/api-pos/transaksi/history.php?tgl1=$tgl1&tgl2=$tgl2&limit=$limit';
    var response = await http.get(Uri.parse(pathUrl));
    // print(tgl1);
    // print(tgl2);
    // print(pathUrl);
    List<dynamic> dataTrx = json.decode(response.body)['rows'];
    List<Trx> trx = dataTrx.map((e) => Trx.fromJson(e)).toList();
    // print(response.body);
    return trx;
  }

  Future<List<Trx>> getDataTrx(
      String? tgl1, String? tgl2, String? limit) async {
    // showLoading('Fetching data');
    var response = await BaseClient()
        .get(url, '/transaksi/history.php?tgl1=$tgl1&tgl2=$tgl2&limit=$limit');
    // .catchError(handleError);
    List<dynamic> dataTrx = json.decode(response)['rows'];
    List<Trx> trx = dataTrx.map((e) => Trx.fromJson(e)).toList();

    // print(response);
    // if (response == null) return null;
    // hideLoading();
    return trx;
    // return trx;
  }

  Future<List<DetailTrx>> fetchDetHistoryTrx(noTrx) async {
    var response = await BaseClient()
        .get(url, '/transaksi/detail_history.php?no_trx=$noTrx');
    // .catchError(handleError);
    // print(pathUrl);
    List<dynamic> dataDetTrx = json.decode(response)['rows'];
    // print(dataDetTrx);
    List<DetailTrx> detailtrx =
        dataDetTrx.map((e) => DetailTrx.fromJson(e)).toList();
    // print(response.body);
    return detailtrx;
  }

  inputDataMaster(dataMaster) async {
    var pathUrl = 'http://103.112.139.155/api-pos/stock/input_master.php';
    var response = await http.post(Uri.parse(pathUrl), body: dataMaster);
    // print(pathUrl);
    // print('Status code: ${response.statusCode}');
    // print('Body: $dataMaster');
    // print('response body :${response.body}');
  }

  deleteMasterBarang(barcodeMaster) async {
    // var url =
    //     'http://103.112.139.155/api-pos/stock/delete_master.php?kode_barang=$kode';
    var response = await http.post(
        Uri.parse('http://103.112.139.155/api-pos/stock/delete_master.php'),
        body: barcodeMaster);
    // print(url);
  }
}
