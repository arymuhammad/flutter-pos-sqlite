class SalesOutlet {
  late String cabang;
  late String tanggal;
  late String kodeCabang;
  late String qtySales;
  late String hargaNetSales;
  late String qtyExchange;
  late String hargaNetExchange;
  late String qtyBersih;
  late String achievement;
  late int target;
  late String persen;

  SalesOutlet(
      {required this.cabang,
      required this.tanggal,
      required this.kodeCabang,
      required this.qtySales,
      required this.hargaNetSales,
      required this.qtyExchange,
      required this.hargaNetExchange,
      required this.qtyBersih,
      required this.achievement,
      required this.target,
      required this.persen});

  SalesOutlet.fromJson(Map<String, dynamic> json) {
    cabang = json['cabang'];
    tanggal = json['Tanggal'];
    kodeCabang = json['Kode_Cabang'];
    qtySales = json['qty_sales'];
    hargaNetSales = json['harga_net_sales'];
    qtyExchange = json['qty_exchange'];
    hargaNetExchange = json['harga_net_exchange'];
    qtyBersih = json['qty_bersih'];
    achievement = json['achievement'];
    target = json['target'];
    persen = json['persen'];
  }

}
