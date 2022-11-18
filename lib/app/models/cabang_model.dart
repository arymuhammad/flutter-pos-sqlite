class Cabang {
  late String kode;
  late String nama;
  late String alamat;
  late String telepon;
  late String fotoCabang;

  Cabang({required this.kode, required this.nama, required this.alamat, required this.telepon, required this.fotoCabang});

  Cabang.fromJson(Map<String, dynamic> json) {
    kode = json['kode'];
    nama = json['nama'];
    alamat = json['alamat'];
    telepon = json['telepon'];
    fotoCabang = json['foto_cabang'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['kode'] = this.kode;
  //   data['nama'] = this.nama;
  //   data['alamat'] = this.alamat;
  //   data['telepon'] = this.telepon;
  //   data['foto_cabang'] = this.fotoCabang;
  //   return data;
  // }
}