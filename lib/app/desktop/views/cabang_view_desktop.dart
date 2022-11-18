import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:my_first_app/app/service/repo.dart';

import '../../modules/cabang/controllers/cabang_controller.dart';

class CabangViewDesktop extends GetView<CabangController> {
  const CabangViewDesktop({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CabangView'),
        centerTitle: true,
      ),
      // drawer: myDrawer,
      body: Row(
        children: [
          myDrawer,
          
        ],
      ),
    );
  }
}
