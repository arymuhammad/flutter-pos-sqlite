import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:my_first_app/app/desktop/views/home_view_desktop.dart';
import 'package:my_first_app/app/modules/stock/views/stock_view.dart';
import 'package:my_first_app/app/modules/transaksi/views/transaksi_view.dart';
import 'package:my_first_app/print_setting.dart';
import '../../../service/repo.dart';
import '../../../settings/settings.dart';
import '../../historytransaksi/views/historytransaksi_view.dart';
import '../controllers/home_controller.dart';
// import 'drawer_view.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;

    return mediaQuery.width > 1000
        ? HomeViewDesktop()
        : WillPopScope(
            onWillPop: () async {
              bool willLeave = false;
              // if (transaksiController.listdata.isNotEmpty) {
              await Get.defaultDialog(
                  title: 'Peringatan',
                  content: Container(
                    child: const Text(
                        'Anda yakin ingin keluar dari aplikasi ini?'),
                  ),
                  confirm: ElevatedButton(
                      onPressed: () {
                        Get.back();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent[700]),
                      child: const Text('TIDAK')),
                  cancel: ElevatedButton(
                      onPressed: () {
                        willLeave = true;
                        Get.back();
                      },
                      child: const Text('IYA')));
              // } else {
              //   willLeave = true;
              // }
              return willLeave;
            },
            child: Scaffold(
                // drawer: myDrawer,
                // key: keyDrawer,
                body: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 29, 30, 32),
                  ),
                  // child: Stack(
                  //   children: [Container()],
                  // ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 490),
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(218, 228, 225, 225),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40))),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.fromLTRB(30, 270, 30, 380),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Card(
                //         child: Container(
                //           width: 150,
                //           child: Column(
                //           mainAxisAlignment: MainAxisAlignment.end,
                //           crossAxisAlignment: CrossAxisAlignment.center,
                //             children: [
                //             Divider(),
                //               Text('Penjualan Hari ini', style: TextStyle(fontWeight: FontWeight.bold),),
                //             ],
                //           ),
                //         ),
                //       ),
                //       Card(
                //         child: Container(
                //           width: 150,
                //           child: Column(
                //           mainAxisAlignment: MainAxisAlignment.end,
                //           crossAxisAlignment: CrossAxisAlignment.center,
                //             children: [
                //             Divider(),
                //               Text('Penjualan Bulan ini', style: TextStyle(fontWeight: FontWeight.bold),),
                //             ],
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 410, 30, 10),
                  child: Container(
                    child: GridView.count(
                      crossAxisCount:
                          mediaQuery.width > 600 && mediaQuery.width < 1100
                              ? 4
                              : 2,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      childAspectRatio: 1,
                      children: [
                        // Card(
                        //   elevation: 10,
                        //   shape: RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.circular(30)),
                        //   color: Colors.grey,
                        //   child: Column(
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     children: [
                        //       CircleAvatar(
                        //         backgroundColor: Colors.transparent,
                        //         radius: 50,
                        //         child: ColorFiltered(
                        //           colorFilter: ColorFilter.mode(
                        //               Colors.grey, BlendMode.color),
                        //           child: ClipRRect(
                        //             child: Image.asset('asset/cat.png'),
                        //             borderRadius: BorderRadius.circular(10.0),
                        //           ),
                        //         ),
                        //       ),
                        //       SizedBox(
                        //         height: 5,
                        //       ),
                        //       Text(
                        //         'Kategori',
                        //         style: TextStyle(fontWeight: FontWeight.bold),
                        //       )
                        //     ],
                        //   ),
                        // ),
                        // Card(
                        //   elevation: 10,
                        //   shape: RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.circular(30)),
                        //   color: Colors.grey,
                        //   child: Column(
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     children: [
                        //       CircleAvatar(
                        //         backgroundColor: Colors.transparent,
                        //         radius: 50,
                        //         child: ColorFiltered(
                        //           colorFilter: ColorFilter.mode(
                        //               Colors.grey, BlendMode.color),
                        //           child: ClipRRect(
                        //             child: Image.asset('asset/supplier.png'),
                        //             borderRadius: BorderRadius.circular(10.0),
                        //           ),
                        //         ),
                        //       ),
                        //       SizedBox(
                        //         height: 5,
                        //       ),
                        //       Text(
                        //         'Supplier',
                        //         style: TextStyle(fontWeight: FontWeight.bold),
                        //       )
                        //     ],
                        //   ),
                        // ),
                        Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          color: myDefaultBackground,
                          child: InkWell(
                            onTap: () => Get.to(() => StockView()),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  radius: 30,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Image.asset('asset/stocks.png'),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  'Data Master (Stok)',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ),
                        Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          color: myDefaultBackground,
                          child: InkWell(
                            onTap: () => Get.to(() => TransaksiView()),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 35,
                                  backgroundColor: Colors.transparent,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Image.asset('asset/transaksi.png'),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  'Transaksi',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ),
                        Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          color: myDefaultBackground,
                          child: InkWell(
                            onTap: () => Get.to(() => HistoryTransaksiView()),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 35,
                                  backgroundColor: Colors.transparent,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child:
                                        Image.asset('asset/report_sales.png'),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  'Laporan Penjualan',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ),
                        // Card(
                        //   elevation: 10,
                        //   shape: RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.circular(30)),
                        //   color: Colors.grey,
                        //   child: Column(
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     children: [
                        //       CircleAvatar(
                        //         radius: 50,
                        //         child: ColorFiltered(
                        //           colorFilter: ColorFilter.mode(
                        //               Colors.grey, BlendMode.color),
                        //           child: ClipRRect(
                        //             borderRadius: BorderRadius.circular(10.0),
                        //             child:
                        //                 Image.asset('asset/report_stock.png'),
                        //           ),
                        //         ),
                        //         backgroundColor: Colors.transparent,
                        //       ),
                        //       SizedBox(
                        //         height: 5,
                        //       ),
                        //       Text(
                        //         'Laporan Stok',
                        //         style: TextStyle(fontWeight: FontWeight.bold),
                        //       )
                        //     ],
                        //   ),
                        // ),
                        Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          color: myDefaultBackground,
                          child: InkWell(
                            onTap: () => Get.to(() => const SettingsView()),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 35,
                                  backgroundColor: Colors.transparent,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Image.asset('asset/setting.png'),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  'Settings',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(top: 45.0, left: 20),
                //   child: Container(
                //     child: GestureDetector(
                //         onTap: () => keyDrawer.currentState!.openDrawer(),
                //         child: Icon(
                //           Icons.menu_rounded,
                //           color: Colors.white,
                //         )),
                //   ),
                // ),
                Positioned(
                  top: 150,
                  left: 120,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.asset(
                          'asset/logo_app.png',
                          scale: 1.5,
                        ),
                      ),
                      const Text(
                        'POS App',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        'Versi 1.9.22',
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                )
              ],
            )),
          );
  }
}
