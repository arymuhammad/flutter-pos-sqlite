import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_first_app/app/service/repo.dart';
import 'package:my_first_app/app/service/service_api.dart';

import '../../../helper/currency_format.dart';
import '../controllers/stock_controller.dart';

class StockView extends GetView<StockController> {
  StockView({Key? key}) : super(key: key);

  final masterCtr = Get.put(StockController());
  TextEditingController artikel = TextEditingController();
  TextEditingController inputKodeBarang = TextEditingController();
  TextEditingController inputNamaBarang = TextEditingController();
  TextEditingController inputHargaBarang = TextEditingController();
  TextEditingController inputJumlahBarang = TextEditingController();
  TextEditingController inputHargaUpdate = TextEditingController();
  TextEditingController inputSisaUpdate = TextEditingController();
  TextEditingController inputNamaUpdate = TextEditingController();
  FocusNode myFocusNode = FocusNode();
  FocusNode myFocusNodeKode = FocusNode();
  FocusNode myFocusNodeNama = FocusNode();
  FocusNode myFocusNodeHarga = FocusNode();
  FocusNode myFocusNodeStatus = FocusNode();
  FocusNode myFocusNodeQty = FocusNode();
  ValueNotifier<bool> isDialOpen = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Master (Stock)'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 29, 30, 32),
        actions: [
          IconButton(
            onPressed: () => masterCtr.getData(),
            icon: const Icon(Icons.refresh),
            tooltip: 'refresh',
          ),
          IconButton(
            onPressed: () => tambahMaster(),
            icon: const Icon(Icons.add_to_photos),
            tooltip: 'Tambah Data',
          )
        ],
      ),
      backgroundColor: myDefaultBackground,
      body: Obx(() {
        print('total data : ${masterCtr.dbMaster.length}');
        return masterCtr.isLoading.value
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    CircularProgressIndicator(),
                    Text('Loading...')
                  ],
                ),
              )
            : masterCtr.dbMaster.isEmpty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Center(
                          child: Text('Tidak ada data ${artikel.text}'),
                        ),
                      ),
                      Container(
                        height: 40,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20)),
                            color: Colors.white),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              'Menampilkan ${masterCtr.dbMaster.length} baris data'),
                        ),
                      )
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Padding(
                      //   padding: EdgeInsets.all(8.0),
                      //   child: TextField(
                      //     decoration: InputDecoration(
                      //       border: OutlineInputBorder(
                      //         borderSide:
                      //             BorderSide(color: Colors.white, width: 2.0),
                      //         borderRadius: BorderRadius.circular(25.0),
                      //       ),
                      //       label: Text('Filter Merk Artikel'),
                      //       prefixIcon: Icon(Icons.search),
                      //       // fillColor: Colors.white,
                      //       // filled: true,
                      //       focusedBorder: OutlineInputBorder(
                      //         borderSide:
                      //             BorderSide(color: Colors.white, width: 2.0),
                      //         borderRadius: BorderRadius.circular(25.0),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      masterCtr.dbMaster.isNotEmpty
                          ? Expanded(
                              child: GridView.count(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  // padding: EdgeInsets.all(8),
                                  crossAxisCount: 2,
                                  childAspectRatio: 2 / 3,
                                  children: List.generate(
                                      masterCtr.dbMaster.length, (index) {
                                    // int stock = 0;
                                    // if (masterCtr.dataMaster[index].sisa == 0 ||
                                    //     masterCtr.dataMaster[index].sisa == null) {
                                    //   stock = masterCtr.dataMaster[index].awal +
                                    //       masterCtr.dataMaster[index].masuk;
                                    //   print(stock);
                                    // } else {
                                    //   stock = masterCtr.dataMaster[index].sisa;
                                    // }
                                    // stock = stock;
                                    // if (masterCtr.dataMaster[index].foto !=
                                    //     null) {
                                    //   masterCtr.dataMaster[index].foto =
                                    //       masterCtr.dataMaster[index].foto;
                                    // } else {
                                    //   masterCtr.dataMaster[index].foto =
                                    //       "no-image.jpg";
                                    // }

                                    int sisa = 0;
                                    // if (masterCtr.dataMaster[index].sisa == 0) {
                                    //   sisa = masterCtr.dataMaster[index].awal +
                                    //       masterCtr.dataMaster[index].masuk;
                                    // } else {
                                    //   sisa = masterCtr.dataMaster[index].sisa;
                                    // }

                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                        onTap: () {
                                          updateData(
                                              masterCtr
                                                  .dbMaster[index].kodeBarang,
                                              masterCtr
                                                  .dbMaster[index].namaBarang,
                                              masterCtr
                                                  .dbMaster[index].hargaBarang,
                                              masterCtr.dbMaster[index].stok);
                                        },
                                        child: Card(
                                          semanticContainer: true,
                                          elevation: 5,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Stack(
                                                  children: [
                                                    BarcodeWidget(
                                                        barcode:
                                                            Barcode.codabar(),
                                                        data: masterCtr
                                                            .dbMaster[index]
                                                            .kodeBarang
                                                            .toString(),
                                                        height: 100,
                                                        width: 320,
                                                        style: const TextStyle(
                                                            fontSize: 20)),
                                                  ],
                                                ),
                                                const SizedBox(height: 8),
                                                Text(
                                                  '${masterCtr.dbMaster[index].namaBarang}\n${masterCtr.dbMaster[index].kodeBarang}',
                                                  maxLines: 3,
                                                  style: const TextStyle(
                                                      fontFamily: 'avenir',
                                                      fontWeight:
                                                          FontWeight.w700),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                Text(
                                                  'Stock : ${masterCtr.dbMaster[index].stok}',
                                                  style: const TextStyle(
                                                    fontFamily: 'avenir',
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                Text(
                                                  CurrencyFormat.convertToIdr(
                                                      int.parse(masterCtr
                                                          .dbMaster[index]
                                                          .hargaBarang
                                                          .toString()),
                                                      0),
                                                  style: const TextStyle(
                                                    fontFamily: 'avenir',
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  })),
                            )
                          : Text('Tidak ada data barang ${artikel.text}'),
                      Container(
                        height: 40,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20)),
                            color: Colors.white),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              'Menampilkan ${masterCtr.dbMaster.length} baris data'),
                        ),
                      )
                    ],
                  );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // scanCariBarcode();
          Get.defaultDialog(
              radius: 10,
              title: 'Cari Data Barang',
              content: Row(
                children: [
                  Expanded(
                    child: TextField(
                      autofocus: true,
                      focusNode: myFocusNode,
                      controller: artikel,
                      onSubmitted: (value) async {
                        // print(artikel.text.length);
                        if (value.isNotEmpty) {
                          masterCtr.getItem(value);
                          // masterCtr.isLoading.value = true;
                          // masterCtr.isLengthData.value = artikel.text.length;
                          artikel.clear();
                          Get.back();
                        } else {
                          Get.defaultDialog(
                              radius: 10,
                              title: 'Peringatan',
                              content: const Center(
                                  child: Text(
                                      'Data tidak boleh kosong!\nHarap masukkan nama barang yang ingin dicari.')),
                              confirm: ElevatedButton(
                                  onPressed: () {
                                    Get.back();
                                    myFocusNode.requestFocus();
                                  },
                                  child: const Text('OK')),
                              barrierDismissible: false);
                        }
                      },
                      decoration: InputDecoration(
                          label: const Text('Nama / Kode Barang'),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          suffixIcon: const Icon(Icons.search),
                          prefixIcon: IconButton(
                            onPressed: () {
                              scanCariBarcode();
                            },
                            icon: const Icon(Icons.qr_code_2),
                          )),
                    ),
                  ),
                  // IconButton(
                  //     onPressed: () => scanBarcodeDiscovery(),
                  //     icon: Icon(Icons.qr_code_scanner))
                ],
              ));
        },
        tooltip: 'Cari Barang',
        child: const Icon(Icons.search),
      ),
    );
  }

  tambahMaster() {
    Get.bottomSheet(
        Container(
          height: 356,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              color: Colors.white),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Input Data Master Barang (Stock)',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Divider(),
                SizedBox(
                  height: 50,
                  child: TextField(
                    controller: inputKodeBarang,
                    autofocus: true,
                    focusNode: myFocusNodeKode,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        label: const Text('Kode Barang'),
                        suffixIcon: IconButton(
                            onPressed: () {
                              scanBarcode();
                            },
                            icon: const Icon(Icons.qr_code))),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  height: 50,
                  child: TextField(
                    autofocus: true,
                    focusNode: myFocusNodeNama,
                    controller: inputNamaBarang,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        label: const Text('Nama Barang'),
                        suffixIcon: const Icon(Icons.paste_rounded)),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  height: 50,
                  child: TextField(
                    controller: inputHargaBarang,
                    autofocus: true,
                    focusNode: myFocusNodeHarga,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        label: const Text('Harga'),
                        suffixIcon: const Icon(Icons.price_check_rounded)),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                // SizedBox(
                //   height: 40,
                //   child: Obx(
                //     (() => DropdownButtonFormField<String>(
                //           autofocus: true,
                //           focusNode: myFocusNodeStatus,
                //           decoration: InputDecoration(
                //               border: OutlineInputBorder(
                //                   borderRadius: BorderRadius.circular(20))),
                //           isExpanded: true,
                //           hint: Text('Status'),
                //           icon: Icon(Icons.list_alt),
                //           value: masterCtr.selectedItem.value == ""
                //               ? null
                //               : masterCtr.selectedItem.value,
                //           items: masterCtr.selected.map((value) {
                //             // print(salesCtr.selectedItem.value);
                //             return DropdownMenuItem(
                //               value: value,
                //               child: Text(value),
                //             );
                //           }).toList(),
                //           onChanged: (value) {
                //             masterCtr.selectedItem.value = value!;
                //           },
                //           selectedItemBuilder: (ctx) => masterCtr.selected
                //               .map((e) => Text(
                //                     e,
                //                     style: const TextStyle(
                //                         // fontSize: 18,
                //                         // color: Colors.amber,
                //                         // fontStyle: FontStyle.italic,
                //                         // fontWeight: FontWeight.bold
                //                         ),
                //                   ))
                //               .toList(),
                //         )),
                //   ),
                // ),
                SizedBox(
                  height: 50,
                  child: TextField(
                    controller: inputJumlahBarang,
                    autofocus: true,
                    focusNode: myFocusNodeQty,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      label: const Text('Quantity Input (pcs)'),
                      suffixIcon: const Icon(Icons.note_alt_outlined),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton.icon(
                        icon: const Icon(Icons.save_as),
                        label: const Text('S I M P A N'),
                        onPressed: () {
                          if (inputKodeBarang.text == "" &&
                              inputNamaBarang.text == "" &&
                              inputHargaBarang.text == "" &&
                              inputJumlahBarang.text == "") {
                            Get.snackbar('Warning',
                                'Data Master tidak boleh ada yang kosong. Harap dilengkapi semua datanya.',
                                snackPosition: SnackPosition.TOP,
                                backgroundColor: Colors.redAccent[700],
                                colorText: Colors.white,
                                icon: const Icon(
                                  Icons.warning_amber_rounded,
                                  color: Colors.white,
                                ));
                            myFocusNodeKode.requestFocus();
                          } else if (inputNamaBarang.text == "") {
                            Get.snackbar(
                                'Warning', 'Nama Barang tidak boleh kosong.',
                                snackPosition: SnackPosition.TOP,
                                backgroundColor: Colors.redAccent[700],
                                colorText: Colors.white,
                                icon: const Icon(
                                  Icons.warning_amber_rounded,
                                  color: Colors.white,
                                ));
                            myFocusNodeNama.requestFocus();
                          } else if (inputKodeBarang.text == "") {
                            Get.snackbar(
                                'Warning', 'Kode Barang tidak boleh kosong.',
                                snackPosition: SnackPosition.TOP,
                                backgroundColor: Colors.redAccent[700],
                                colorText: Colors.white,
                                icon: const Icon(
                                  Icons.warning_amber_rounded,
                                  color: Colors.white,
                                ));
                            myFocusNodeKode.requestFocus();
                          } else if (inputHargaBarang.text == "") {
                            Get.snackbar('Warning', 'Harga tidak boleh kosong.',
                                snackPosition: SnackPosition.TOP,
                                backgroundColor: Colors.redAccent[700],
                                colorText: Colors.white,
                                icon: const Icon(
                                  Icons.warning_amber_rounded,
                                  color: Colors.white,
                                ));
                            myFocusNodeHarga.requestFocus();
                          } else if (inputJumlahBarang.text == "") {
                            Get.snackbar(
                                'Warning', 'Quantity Input tidak boleh kosong.',
                                snackPosition: SnackPosition.TOP,
                                backgroundColor: Colors.redAccent[700],
                                colorText: Colors.white,
                                icon: const Icon(
                                  Icons.warning_amber_rounded,
                                  color: Colors.white,
                                ));
                            myFocusNodeQty.requestFocus();
                          } else {
                            var dataMaster = {
                              "kode_barang": inputKodeBarang.text,
                              "nama_barang": inputNamaBarang.text,
                              "harga_barang": inputHargaBarang.text,
                              "status": masterCtr.selectedItem.value,
                              "awal": inputJumlahBarang.text
                            };

                            // ServiceApi().inputDataMaster(dataMaster);

                            masterCtr.addData(
                                inputKodeBarang.text,
                                inputNamaBarang.text,
                                inputHargaBarang.text,
                                inputJumlahBarang.text,
                                DateFormat('yyyy-MM-dd H:mm:ss')
                                    .format(DateTime.now())
                                    .toString());
                            inputKodeBarang.clear();
                            inputNamaBarang.clear();
                            inputHargaBarang.clear();
                            inputJumlahBarang.clear();
                            masterCtr.selectedItem.value = '';
                            masterCtr.getData();
                            Get.back();
                            // Get.snackbar(
                            //     'Success', 'Data Master berhasil diinput.',
                            //     snackPosition: SnackPosition.TOP,
                            //     backgroundColor: Colors.greenAccent[700],
                            //     colorText: Colors.white,
                            //     icon: const Icon(
                            //       Icons.warning_amber_rounded,
                            //       color: Colors.white,
                            //     ),
                            //     duration: const Duration(seconds: 3));
                            Fluttertoast.showToast(
                                msg: "Data berhasil diinput.",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.greenAccent[700],
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }

                          // SalesController().fetchSales(tgl1, tgl2);
                          // ignore: unrelated_type_equality_checks
                          // if (dateInputAwal.text == "" ||
                          //     dateInputAkhir.text == "" ||
                          //     DateTime.parse(dateInputAkhir.text).isBefore(
                          //         DateTime.parse(dateInputAwal.text))) {
                          // ignore: void_checks
                          // return modalError(
                          //     dateInputAwal.text, dateInputAkhir.text);
                          // } else {
                          // masterCtr.fetchSales(
                          //     dateInputAwal.text,
                          //     dateInputAkhir.text,
                          //     salesCtr.selectedItem.value);
                          // salesCtr.isLoading.value = true;
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 15,
                          minimumSize: const Size(135, 50),
                          maximumSize: const Size(135, 50),
                        )),
                    ElevatedButton.icon(
                        onPressed: () {
                          if (inputKodeBarang.text != "" ||
                              inputNamaBarang.text != "" ||
                              inputHargaBarang.text != "" ||
                              inputJumlahBarang.text != "") {
                            Get.defaultDialog(
                                title: 'Warning',
                                content: const Text(
                                    'Anda Yakin ingin membatalkan proses ini?\nData tidak akan disimpan'),
                                confirm: ElevatedButton(
                                    onPressed: () {
                                      inputKodeBarang.clear();
                                      inputNamaBarang.clear();
                                      inputHargaBarang.clear();
                                      inputJumlahBarang.clear();
                                      masterCtr.selectedItem.value = '';
                                      Get.back();
                                      Get.back();
                                    },
                                    child: const Text('Ya')),
                                cancel: ElevatedButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: const Text('Batal'),
                                ));
                          } else {
                            Get.back();
                          }
                        },
                        icon: const Icon(Icons.cancel),
                        label: const Text('B A T A L'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          elevation: 15,
                          minimumSize: const Size(200, 50),
                          maximumSize: const Size(200, 50),
                        )),
                  ],
                )
              ],
            ),
          ),
        ),
        isScrollControlled: true);
  }

  updateData(kode, nama, harga, stok) {
    Get.defaultDialog(
        radius: 10,
        title: 'Update Master Barang',
        content: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Divider(),
            TextField(
                readOnly: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: kode.toString(),
                    hintStyle: const TextStyle(color: Colors.black))),
            const SizedBox(
              height: 10,
            ),
            TextField(
                // readOnly: true,
                controller: inputNamaUpdate,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    hintText: nama.toString(),
                    hintStyle: const TextStyle(color: Colors.black))),
            const SizedBox(
              height: 10,
            ),
            TextField(
              // readOnly: true,
              controller: inputHargaUpdate,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                hintText:
                    'Harga sebelumnya ${CurrencyFormat.convertToIdr(harga, 0)}',
              ),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              // readOnly: true,
              controller: inputSisaUpdate,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                hintText: 'Stock sisa ${stok.toString()} pcs',
              ),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                    onPressed: () async {
                      // var updated = {
                      //   "kode_barang": kode.toString(),
                      //   "harga_barang": harga.toString(),
                      //   "harga_input": inputHargaUpdate.text.toString(),
                      //   "awal": awal.toString(),
                      //   "masuk": masuk.toString(),
                      //   "input_masuk": inputSisaUpdate.text.toString(),
                      // };

                      // await ServiceApi().updateMasterBarang(updated);
                      // masterCtr.fetchdataMaster(kode.toString());
                      var hargaUpdate = "";
                      var stokUpdate = "";
                      var namaUpdate = "";
                      if (inputHargaUpdate.text == "") {
                        hargaUpdate = harga.toString();
                      } else {
                        hargaUpdate = inputHargaUpdate.text;
                      }

                      if (inputSisaUpdate.text == "") {
                        stokUpdate = stok.toString();
                      } else {
                        stokUpdate = inputSisaUpdate.text;
                      }

                      if (inputNamaUpdate.text == "") {
                        namaUpdate = nama.toString();
                      } else {
                        namaUpdate = inputNamaUpdate.text;
                      }

                      masterCtr.updateData(
                          kode, namaUpdate, hargaUpdate, stokUpdate);
                      masterCtr.getData();
                      Get.back();
                      masterCtr.isLoading.value = true;
                      inputHargaUpdate.clear();
                      inputSisaUpdate.clear();

                      // Get.snackbar('Success', 'Data berhasil diupdate',
                      //     snackPosition: SnackPosition.TOP,
                      //     backgroundColor: Colors.greenAccent[700],
                      //     duration: const Duration(seconds: 2),
                      //     snackStyle: SnackStyle.FLOATING,
                      //     colorText: Colors.white,
                      //     icon: const Icon(Icons.check_circle));

                      Fluttertoast.showToast(
                          msg: "Data berhasil diupdate.",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.greenAccent[700],
                          textColor: Colors.white,
                          fontSize: 16.0);
                    },
                    icon: const Icon(Icons.update_rounded),
                    label: const Text('Update'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent[700],
                      elevation: 15,
                      minimumSize: const Size(140, 50),
                      maximumSize: const Size(140, 50),
                    )),
                ElevatedButton.icon(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(Icons.cancel),
                    label: const Text('Batal'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent[700],
                      elevation: 15,
                      minimumSize: const Size(120, 50),
                      maximumSize: const Size(120, 50),
                    )),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton.icon(
                onPressed: () async {
                  Get.defaultDialog(
                      title: 'Peringatan',
                      content: Text(
                          'Anda ingin menghapus data barang ini?\n- $nama'),
                      confirm: ElevatedButton(
                          onPressed: () async {
                            // var barcodeMaster = {
                            //   'kode_barang': kode.toString()
                            // };

                            // await ServiceApi()
                            //     .deleteMasterBarang(barcodeMaster);
                            masterCtr.delete(kode);
                            Get.back();
                            Get.back();
                            // masterCtr.fetchdataMaster('');
                            masterCtr.getData();
                            masterCtr.isLoading.value = true;
                            // Get.snackbar('Success', 'Data berhasil dihapus',
                            //     snackPosition: SnackPosition.TOP,
                            //     backgroundColor: Colors.greenAccent[700],
                            //     duration: const Duration(seconds: 2),
                            //     snackStyle: SnackStyle.FLOATING,
                            //     colorText: Colors.white,
                            //     icon: const Icon(Icons.check_circle));

                            Fluttertoast.showToast(
                                msg: "Data berhasil dihapus.",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.greenAccent[700],
                                textColor: Colors.white,
                                fontSize: 16.0);
                          },
                          child: const Text('Oke')),
                      cancel: ElevatedButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: const Text('Batal')));
                },
                icon: const Icon(Icons.delete_forever_rounded),
                label: const Text('Hapus Data Barang'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent[700],
                  elevation: 15,
                  minimumSize: const Size(double.maxFinite, 50),
                  maximumSize: const Size(double.maxFinite, 50),
                )),
          ],
        ),
        barrierDismissible: false);
  }

  void scanBarcode() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      // print(barcodeScanRes);
      inputKodeBarang.text = barcodeScanRes;
      // artikel.text = barcodeScanRes;
      // await masterCtr.getItem(barcodeScanRes);
      // masterCtr.isLoading.value = true;
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
  }

  void scanCariBarcode() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      // print(barcodeScanRes);
      // inputKodeBarang.text = barcodeScanRes;
      // artikel.text = barcodeScanRes;
      Get.back();
      await masterCtr.getItem(barcodeScanRes);
      // masterCtr.isLoading.value = true;
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
  }
}
