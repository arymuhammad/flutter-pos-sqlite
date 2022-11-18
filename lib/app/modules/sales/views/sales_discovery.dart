import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:my_first_app/app/helper/currency_format.dart';
import 'package:my_first_app/app/service/repo.dart';
import '../controllers/sales_controller.dart';

class SalesDiscovery extends GetView<SalesController> {
  SalesDiscovery({
    Key? key,
  }) : super(key: key);

  final SalesController salesCtr = Get.put(SalesController());
  TextEditingController artikel = TextEditingController();

  var barcodeBarang = "".obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppbar,
      backgroundColor: myDefaultBackground,
      body: Obx(() {
        // print(salesCtr.isLengthData);
        if (salesCtr.isLoading.value == true && salesCtr.isLengthData == 0) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Center(child: Text('Tidak ada data...')),
              ],
            ),
          );
        } else {
          // print(salesCtr.isLengthData);
          return salesCtr.isLoading.value
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Center(
                        child: CircularProgressIndicator(),
                      ),
                      Center(child: Text('Loading data...')),
                    ],
                  ),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.white, width: 2.0),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          label: const Text('Filter Merk Artikel'),
                          prefixIcon: const Icon(Icons.search),
                          // fillColor: Colors.white,
                          // filled: true,
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.white, width: 2.0),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GridView.count(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          crossAxisCount: 2,
                          childAspectRatio: 2 / 3,
                          children:
                              List.generate(salesCtr.discovery.length, (index) {
                            if (salesCtr.discovery[index].foto ==
                                "amogos.webp") {
                              salesCtr.discovery[index].foto = "no-image.jpg";
                            } else {
                              salesCtr.discovery[index].foto =
                                  salesCtr.discovery[index].foto;
                            }
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                semanticContainer: true,
                                elevation: 5,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Stack(
                                        children: [
                                          Container(
                                            height: 140,
                                            width: double.infinity,
                                            clipBehavior: Clip.antiAlias,
                                            decoration: BoxDecoration(
                                              color: Colors.grey[200],
                                              // image: DecorationImage(image: NetworkImage(
                                              // img + salesCtr.discovery[index].foto,
                                              // )
                                              // ),
                                              // borderRadius:
                                              //     BorderRadius.circular(4),
                                            ),
                                            child: Image.network(
                                              img +
                                                  salesCtr
                                                      .discovery[index].foto,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        '${salesCtr.discovery[index].merk} ${salesCtr.discovery[index].warna}',
                                        style: const TextStyle(
                                            fontFamily: 'avenir',
                                            fontWeight: FontWeight.w700),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        salesCtr.discovery[index].season,
                                        style: const TextStyle(
                                          fontFamily: 'avenir',
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        CurrencyFormat.convertToIdr(
                                            int.parse(salesCtr
                                                .discovery[index].hargaNet),
                                            0),
                                        style: const TextStyle(
                                          fontFamily: 'avenir',
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        salesCtr.discovery[index].promosi,
                                        style: const TextStyle(
                                            fontFamily: 'avenir',
                                            color: Colors.red),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          })),
                    ),
                  ],
                );
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.defaultDialog(
            title: 'Cari Artikel',
            content: Row(
              children: [
                Expanded(
                  child: Obx(
                    () {
                      artikel.text = barcodeBarang.value;
                  
                      return TextField(
                        controller: artikel,
                        onChanged: (value){
                          salesCtr.fetchDiscovery(value);
                        },
                        onSubmitted: (value) {
                          // print(artikel.text.length);
                          if (value.isNotEmpty) {
                            salesCtr.fetchDiscovery(value);
                            salesCtr.isLoading.value = true;
                            salesCtr.isLengthData.value = artikel.text.length;
                            artikel.clear();
                            Get.back();
                          } else {
                            Get.defaultDialog(
                                title: 'Peringatan',
                                content: const Center(
                                    child: Text(
                                        'Harap masukkan nama artikel yang ingin dicari.')),
                                confirm: ElevatedButton(
                                    onPressed: () => Get.back(),
                                    child: const Text('OK')),
                                barrierDismissible: false);
                          }
                        },
                        decoration: InputDecoration(
                          label: const Text('Nama Artikel'),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          suffixIcon: const Icon(Icons.search),
                        ),
                      );
                    },
                  ),
                ),
                IconButton(
                    onPressed: () => scanBarcodeDiscovery(),
                    icon: const Icon(Icons.qr_code_scanner))
              ],
            )),
        tooltip: 'Search',
        child: const Icon(Icons.search),
      ),
    );
  }

  Future<void> scanBarcodeDiscovery() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
      barcodeBarang.value = barcodeScanRes;
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
}
