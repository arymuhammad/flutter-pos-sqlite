
import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:my_first_app/app/modules/sales/controllers/sales_controller.dart';
import 'package:my_first_app/app/service/repo.dart';

// import 'package:get/get.dart';

class SalesSummary extends GetView<SalesController> {
  SalesSummary({
    Key? key,
  }) : super(key: key);

  final SalesController salesCtr = Get.put(SalesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Sales Summary'),
          centerTitle: true,
        ),
        body: Obx(() =>

            // salesCtr.isLoading.value
            // ? Center(
            //     child: Column(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     children: const [
            //       CircularProgressIndicator(),
            //       Text('Loading data...'),
            //     ],
            //   ))
            // :

            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(Icons.calendar_month),
                      Text(salesCtr.salesSummary.value.tanggal ??
                          "Loading data..."),
                      const SizedBox(
                        width: 20,
                      ),
                      const Icon(Icons.attach_money),
                      const Text('Daily '),
                      Text(
                          salesCtr.salesSummary.value.daily ??
                              "Loading data...",
                          style: const TextStyle(
                              color: Colors.blue,
                              fontSize: 15,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(
                        width: 20,
                      ),
                      const Icon(Icons.stacked_bar_chart_outlined),
                      const Text('Daily Qty '),
                      Text(
                        salesCtr.salesSummary.value.dailyQty ??
                            "Loading data...",
                        style: const TextStyle(
                            color: Colors.blue,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      const Text('Monthly Qty '),
                      Text(
                        salesCtr.salesSummary.value.monthlyQty ??
                            "Loading data...",
                        style: const TextStyle(
                            color: Colors.blue,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        alignment: Alignment.bottomLeft,
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'SALES TOP',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        )),
                    Container(
                        alignment: Alignment.bottomLeft,
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'SALES TOP DAILY',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        )),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        flex: 2,
                        child: SizedBox(
                          height: 400.0,
                          child: ListView.builder(
                              // scrollDirection: Axis.vertical,
                              // controller: _scrollController,
                              itemCount: salesCtr.salesTop.length,
                              itemBuilder: (ctx, index) {
                                return Card(
                                  elevation: 5,
                                  child: ListTile(
                                    leading: ConstrainedBox(
                                      constraints: const BoxConstraints(
                                        minWidth: 44,
                                        minHeight: 44,
                                        maxWidth: 64,
                                        maxHeight: 64,
                                      ),
                                      child: Image.network(img +
                                          salesCtr.salesTop[index].gambar),
                                    ),
                                    title: Text(
                                      salesCtr.salesTop[index].namaBarang,
                                    ),
                                    subtitle: Text(
                                        '${salesCtr.salesTop[index].total} \nStock ${salesCtr.salesTop[index].stock}'),
                                  ),
                                );
                              }),
                        )),
                    Expanded(
                      flex: 2,
                      child: SizedBox(
                        height: 400.0,
                        child: ListView.builder(
                            // scrollDirection: Axis.vertical,
                            // controller: _scrollController,
                            itemCount: salesCtr.salesTop.length,
                            itemBuilder: (ctx, index) {
                              return Card(
                                elevation: 5,
                                child: ListTile(
                                  leading: ConstrainedBox(
                                    constraints: const BoxConstraints(
                                      minWidth: 44,
                                      minHeight: 44,
                                      maxWidth: 64,
                                      maxHeight: 64,
                                    ),
                                    child: Image.network(
                                        img + salesCtr.salesTop[index].gambar),
                                  ),
                                  title: Text(
                                    salesCtr.salesTop[index].namaBarang,
                                  ),
                                  subtitle: Text(
                                      '${salesCtr.salesTop[index].total} \nStock ${salesCtr.salesTop[index].stock}'),
                                ),
                              );
                            }),
                      ),
                    )
                  ],
                ),
                bottomView()
              ],
            )));
  }
}

bottomView() {
  return Container(
    child: const Text('data'),
  );
}
// bottomView() {
//     return Get.bottomSheet(
//       Container(
//       decoration: BoxDecoration(
//         color: Color.fromARGB(255, 88, 87, 87),
//         borderRadius:  BorderRadius.vertical(top: Radius.circular(20.0)),
//         border: Border.all(
//           color: Colors.black,
//           width: 1,
//         ),
//       ),
//       height: 70,
//       width: double.maxFinite,
//       child:  Row(
//               mainAxisSize: MainAxisSize.max,
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: <Widget>[
//                 // IconButton(icon: Icon(Icons.arrow_forward), onPressed: (){},),
//                 // IconButton(icon: Icon(Icons.arrow_downward), onPressed: (){},),
//                 // IconButton(icon: Icon(Icons.arrow_left), onPressed: (){},),
//                 // IconButton(icon: Icon(Icons.arrow_upward), onPressed: (){},),
//               ],
//             ),
//     ));
//   }