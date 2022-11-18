import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:my_first_app/app/service/repo.dart';

import '../controllers/cabang_controller.dart';

class CabangView extends GetView<CabangController> {
  CabangView({Key? key}) : super(key: key);

  final cbController = Get.put(CabangController());
  TextEditingController SearchCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => cbController.isSearch.value
            ? const Text('Toko Cabang')
            : SizedBox(
                child: TextField(
                controller: SearchCtrl,
                onChanged: (value) => cbController.filterCabang(value),
                decoration: const InputDecoration(
                    hintText: 'Cari Nama Toko...',
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
              ))),
        centerTitle: true,
        actions: [
           Obx(() => cbController.isSearch.value
                ? IconButton(
                    onPressed: () {
                      cbController.isSearch.value = false;
                    },
                    icon: const Icon(Icons.search))
                : IconButton(
                    onPressed: () {
                      cbController.isSearch.value = true;
                      SearchCtrl.clear();
                    },
                    icon: const Icon(Icons.cancel))),
        ],
      ),
      drawer: myDrawer,
      body: Obx(
        (() => cbController.isLoading.value
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Center(child: CircularProgressIndicator()),
                  Text('Loading data...')
                ],
              )
            :cbController.searchCabang.isEmpty
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
                                    'Menampilkan ${cbController.searchCabang.length} baris data'),
                              ),
                            )
                          ],
                        )
                      : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                 
                  Container(
                    child: Expanded(
                      child: ListView.builder(
                        itemCount: cbController.searchCabang.length,
                        itemBuilder: (ctx, index) {
                          // if (cbController.searchCabang[index].fotoCabang ==
                          //     "amogos.webp") {
                          //   cbController.searchCabang[index].fotoCabang =
                          //       "no-image.jpg";
                          // } else {
                          //   cbController.searchCabang[index].fotoCabang =
                          //       cbController.searchCabang[index].fotoCabang;
                          // }
                          // print(imgToko +
                          // cbController.searchCabang[index].fotoCabang);
                          return ListTile(
                            leading: ConstrainedBox(
                              constraints: const BoxConstraints(
                                minWidth: 44,
                                minHeight: 44,
                                maxWidth: 64,
                                maxHeight: 64,
                              ),
                              child: Image.network(imgToko +
                                  cbController.searchCabang[index].fotoCabang),
                            ),
                            title: Text(
                                '${cbController.searchCabang[index].nama} (${cbController.searchCabang[index].kode})'),
                            // ignore: prefer_if_null_operators
                            subtitle: Text(
                                cbController.searchCabang[index].alamat !=null ? cbController.searchCabang[index].alamat : "alamat tidak tersedia"),
                          );
                        },
                      ),
                    ),
                  ),
                  Container(
                              width: double.infinity,
                              decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    color: Colors.white),
                              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      'Menampilkan ${cbController.searchCabang.length} baris data'),
                              ),
                            )
                ],
              )),
      ),
    );
  }
}
