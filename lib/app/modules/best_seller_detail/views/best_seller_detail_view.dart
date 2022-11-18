import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/best_seller_detail_controller.dart';

class BestSellerDetailView extends GetView<BestSellerDetailController> {
  BestSellerDetailView({Key? key}) : super(key: key);
  final BestSellerDetailController bs = Get.put(BestSellerDetailController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Best Seller Detail'),
        centerTitle: true,
      ),
      body: Obx(
        (() => bs.isLoading.value
            ? Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(),
                  Text('Loading data....'),
                ],
              ))
            : ListView.builder(
                itemCount: bs.bestSellers.value.data!.length,
                itemBuilder: (ctx, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.grey,
                      child: Image(
                          image: NetworkImage(
                              'http://103.112.139.155:9000/api/${bs.bestSellers.value.data![index].gambar}')),
                    ),
                    title: Text(bs.bestSellers.value.data![index].kodeBarang
                        .toString()),
                  );
                },
              )),
      ),
    );
  }
}
