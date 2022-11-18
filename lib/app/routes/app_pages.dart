import 'package:get/get.dart';

import '../modules/best_seller_detail/bindings/best_seller_detail_binding.dart';
import '../modules/best_seller_detail/views/best_seller_detail_view.dart';
import '../modules/cabang/bindings/cabang_binding.dart';
import '../modules/cabang/views/cabang_view.dart';
import '../modules/histori_transaksi_detail/bindings/histori_transaksi_detail_binding.dart';
import '../modules/histori_transaksi_detail/views/histori_transaksi_detail_view.dart';
import '../modules/historytransaksi/bindings/historytransaksi_binding.dart';
import '../modules/historytransaksi/views/historytransaksi_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/sales/bindings/sales_binding.dart';
import '../modules/sales/views/sales_view.dart';
import '../modules/stock/bindings/stock_binding.dart';
import '../modules/stock/views/stock_view.dart';
import '../modules/transaksi/bindings/transaksi_binding.dart';
import '../modules/transaksi/views/transaksi_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SALES,
      page: () => SalesView(),
      binding: SalesBinding(),
    ),
    GetPage(
      name: _Paths.BEST_SELLER_DETAIL,
      page: () => BestSellerDetailView(),
      binding: BestSellerDetailBinding(),
    ),
    GetPage(
      name: _Paths.CABANG,
      page: () => CabangView(),
      binding: CabangBinding(),
    ),
    GetPage(
      name: _Paths.TRANSAKSI,
      page: () => TransaksiView(),
      binding: TransaksiBinding(),
    ),
    GetPage(
      name: _Paths.HISTORYTRANSAKSI,
      page: () => HistoryTransaksiView(),
      binding: HistorytransaksiBinding(),
    ),
    GetPage(
      name: _Paths.STOCK,
      page: () => StockView(),
      binding: StockBinding(),
    ),
    GetPage(
      name: _Paths.HISTORI_TRANSAKSI_DETAIL,
      page: () => HistoriTransaksiDetailView(),
      binding: HistoriTransaksiDetailBinding(),
    ),
  ];
}
