import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_first_app/app/helper/currency_format.dart';
import 'package:my_first_app/app/service/repo.dart';
// import 'package:my_first_app/app/service/service_api.dart';
// import 'package:my_first_app/app/models/sales_model.dart';

import '../controllers/sales_controller.dart';
import 'empty_failure_no_internet.dart';

class SalesView extends GetView<SalesController> {
  SalesView({
    Key? key,
  }) : super(key: key);

  final SalesController salesCtr = Get.put(SalesController());
  TextEditingController dateInputAwal = TextEditingController();
  TextEditingController dateInputAkhir = TextEditingController();
  TextEditingController SearchCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Obx(() => salesCtr.isSearch.value
              ? const Text('Sales Outlet')
              : SizedBox(
                  child: TextField(
                    controller: SearchCtrl,
                    onChanged: (value) => salesCtr.filterSales(value),
                    decoration: const InputDecoration(
                        hintText: 'Cari Nama Outlet...',
                        hintStyle: TextStyle(
                          color: Colors.white,
                          fontFamily: 'avenir',
                        ),
                        border: InputBorder.none),
                    cursorColor: Colors.white,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    cursorHeight: 20,
                  ),
                )),
          centerTitle: true,
          actions: [
            Obx(() => salesCtr.isSearch.value
                ? IconButton(
                    onPressed: () {
                      // print(salesCtr.isSearch.value);
                      salesCtr.isSearch.value = false;
                    },
                    icon: const Icon(Icons.search))
                : IconButton(
                    onPressed: () {
                      salesCtr.isSearch.value = true;
                      SearchCtrl.clear();
                      // salesCtr.searchSales.length;
                    },
                    icon: const Icon(Icons.cancel))),
            IconButton(
                onPressed: () => filterSales(), icon: const Icon(Icons.filter_alt)),
          ],
        ),
        drawer: myDrawer,
        backgroundColor: myDefaultBackground,
        body: Obx(
          () {
            if (salesCtr.connectionStatus.value == 1) {
              return salesCtr.isLoading.value
                  ? Center(
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        CircularProgressIndicator(),
                        Text('Loading data...'),
                        // Text('Menampilkan data tanggal '+ DateFormat(" d MMMM yyyy", "id_ID").format(DateTime.parse(dateInputAwal.text)) + ' sampai ' + DateFormat(" d MMMM yyyy", "id_ID").format(DateTime.parse(dateInputAkhir.text)))
                      ],
                    ))
                  : salesCtr.searchSales.isEmpty
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Center(
                                child:
                                    Text('Tidak ada data ${SearchCtrl.text}'),
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
                                    'Menampilkan ${salesCtr.searchSales.length} baris data'),
                              ),
                            )
                          ],
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // TextField(
                            //   onChanged: (value) => salesCtr.filterSales(value),
                            //   decoration: const InputDecoration(
                            //     labelText: 'Search',
                            //     suffixIcon: Icon(Icons.search),
                            //   ),
                            // ),
                            Expanded(
                              flex: 15,
                              child: ListView.builder(
                                itemCount: salesCtr.searchSales.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(8, 5, 8, 0),
                                    child: Card(
                                      elevation: 10,
                                      child: ListTile(
                                          // leading: CircleAvatar(
                                          //   backgroundColor: Colors.brown,
                                          //   radius: 40,
                                          // ),
                                          isThreeLine: true,
                                          title: Text(salesCtr
                                              .searchSales[index].cabang),
                                          subtitle: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text('Achievement: ${CurrencyFormat.convertToIdr(
                                                      int.parse(salesCtr
                                                          .sales[index]
                                                          .achievement),
                                                      0)}'),
                                              Text('Target: ${salesCtr.sales[index].target}'),
                                              Text('Sales: ${CurrencyFormat.convertToIdr(
                                                      int.parse(salesCtr
                                                          .sales[index]
                                                          .hargaNetSales),
                                                      0)} (${salesCtr
                                                      .sales[index].qtySales} pcs)'),
                                              Text('Exchange: ${salesCtr.sales[index]
                                                      .qtyExchange}'),
                                              Text('Qty Net: ${salesCtr
                                                      .sales[index].qtyBersih}'),
                                            ],
                                          ),
                                          trailing: Text(DateFormat(
                                                  " d MMMM yyyy", "id_ID")
                                              .format(DateTime.parse(salesCtr
                                                  .sales[index].tanggal)))),
                                    ),
                                  );
                                },
                              ),
                            ),
                            Expanded(
                                child: Container(
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20)),
                                  color: Colors.white),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    'Menampilkan ${salesCtr.searchSales.length} baris data'),
                              ),
                            ))
                          ],
                        );
            } else {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: EmptyFailureNoInternetView(
                  image: 'lib/app/data/no_internet.json',
                  title: 'Network Error',
                  description: 'Periksa Koneksi Internet Anda !!',
                  // buttonText: "Retry",
                  onPressed: () {
                    salesCtr.fetchSales("", "", "");
                  },
                ),
              );
            }
          },
        ));
  }

  filterSales() {
    return Get.bottomSheet(
        Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          height: 340,
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, top: 15, right: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Pilih Tanggal',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const Divider(),
                const SizedBox(
                  height: 10,
                ),
                DateTimeField(
                  controller: dateInputAwal,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.calendar_month),
                      hintText: 'Tanggal Awal',
                      border: OutlineInputBorder()),
                  format: DateFormat("yyyy-MM-dd"),
                  onShowPicker: (context, currentValue) {
                    return showDatePicker(
                        context: context,
                        firstDate: DateTime(1900),
                        initialDate: currentValue ?? DateTime.now(),
                        lastDate: DateTime(2100));
                  },
                ),
                const SizedBox(
                  height: 5,
                ),
                DateTimeField(
                  controller: dateInputAkhir,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.calendar_month),
                      hintText: 'Tanggal Akhir',
                      border: OutlineInputBorder()),
                  format: DateFormat("yyyy-MM-dd"),
                  onShowPicker: (context, currentValue) {
                    return showDatePicker(
                        context: context,
                        firstDate: DateTime(1900),
                        initialDate: currentValue ?? DateTime.now(),
                        lastDate: DateTime(2100));
                  },
                ),
                const SizedBox(
                  height: 5,
                ),
                Obx(
                  (() => DropdownButtonFormField<String>(
                        decoration:
                            const InputDecoration(border: OutlineInputBorder()),
                        isExpanded: true,
                        hint: const Text('Limit data'),
                        icon: const Icon(Icons.list_alt),
                        value: salesCtr.selectedItem.value == ""
                            ? null
                            : salesCtr.selectedItem.value,
                        items: salesCtr.selected.map((value) {
                          // print(salesCtr.selectedItem.value);
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          salesCtr.selectedItem.value = value!;
                        },
                        selectedItemBuilder: (ctx) => salesCtr.selected
                            .map((e) => Text(
                                  e,
                                  style: const TextStyle(
                                      // fontSize: 18,
                                      // color: Colors.amber,
                                      // fontStyle: FontStyle.italic,
                                      // fontWeight: FontWeight.bold
                                      ),
                                ))
                            .toList(),
                      )),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton.icon(
                        onPressed: () {
                          // SalesController().fetchSales(tgl1, tgl2);
                          // ignore: unrelated_type_equality_checks
                          if (dateInputAwal.text == "" ||
                              dateInputAkhir.text == "" ||
                              DateTime.parse(dateInputAkhir.text).isBefore(
                                  DateTime.parse(dateInputAwal.text))) {
                            // ignore: void_checks
                            return modalError(
                                dateInputAwal.text, dateInputAkhir.text);
                          } else {
                            salesCtr.fetchSales(
                                dateInputAwal.text,
                                dateInputAkhir.text,
                                salesCtr.selectedItem.value);
                            salesCtr.isLoading.value = true;
                            Get.back();
                            dateInputAwal.clear();
                            dateInputAkhir.clear();
                            salesCtr.selectedItem.value = '';
                          }
                        },
                        icon: const Icon(Icons.save_as),
                        label: const Text('S E T'),
                        style: ElevatedButton.styleFrom(
                          elevation: 15,
                          minimumSize: const Size(130, 50),
                          maximumSize: const Size(130, 50),
                        )),
                    ElevatedButton.icon(
                        onPressed: () {
                          Get.back();
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
        isDismissible: false);
  }

  modalError(String tgl1, String tgl2) {
    return Get.defaultDialog(
      title: "Perhatian",
      content: Text(tgl1 == '' && tgl2 == ''
          ? 'Tanggal awal atau tanggal akhir tidak boleh kosong!\nHarap isi tanggal pencarian.'
          : 'Tanggal akhir tidak boleh lebih kecil dari tanggal awal!'),
      confirm: ElevatedButton(onPressed: () => Get.back(), child: const Text('OK')),
      barrierDismissible: false,
      radius: 8,
    );
  }
}
