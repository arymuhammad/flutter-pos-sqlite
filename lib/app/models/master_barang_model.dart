class MasterBarang {
  late int kodeBarang;
  late String namaBarang;
  late int hargaBarang;
  late int awal;
  late int masuk;
  late int keluar;
  late int sisa;
  String? foto;

  MasterBarang(
      {required this.kodeBarang,
      required this.namaBarang,
      required this.hargaBarang,
      required this.awal,
      required this.masuk,
      required this.keluar,
      required this.sisa,
      this.foto});

  MasterBarang.fromJson(Map<String, dynamic> json) {
    kodeBarang = json['kode_barang'];
    namaBarang = json['nama_barang'];
    hargaBarang = json['harga_barang'];
    awal = json['awal'];
    masuk = json['masuk'];
    keluar = json['keluar'];
    sisa = json['sisa'];
    foto = json['foto'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['kode_barang'] = kodeBarang;
    data['nama_barang'] = namaBarang;
    data['harga_barang'] = hargaBarang;
    data['awal'] = awal;
    data['masuk'] = masuk;
    data['keluar'] = keluar;
    data['sisa'] = sisa;
    data['foto'] = foto;
    return data;
  }
}
