import 'package:get/get.dart';

class HomeController extends GetxController {
  var selectedIndex = 0.obs;

  var url = '103.112.139.155'.obs;

  final count = 0.obs;

  void increment() => count.value++;
}
