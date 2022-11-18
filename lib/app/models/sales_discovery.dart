class Discovery {
  late String merk;
  late String warna;
  late String season;
  late String kelompok;
  late String subkelompok;
  late String departemen;
  late String promosi;
  late String hargaJual;
  late String hargaNet;
  late String foto;

  Discovery(
      {
      required this.merk,
      required this.warna,
      required this.season,
      required this.kelompok,
      required this.subkelompok,
      required this.departemen,
      required this.promosi,
      required this.hargaJual,
      required this.hargaNet,
      required this.foto});

  Discovery.fromJson(Map<String, dynamic> json) {
    merk = json['merk'];
    warna = json['warna'];
    season = json['season'];
    kelompok = json['kelompok'];
    subkelompok = json['subkelompok'];
    departemen = json['departemen'];
    promosi = json['Promosi'];
    hargaJual = json['Harga_jual'];
    hargaNet = json['harga_net'];
    foto = json['foto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['merk'] = merk;
    data['warna'] = warna;
    data['season'] = season;
    data['kelompok'] = kelompok;
    data['subkelompok'] = subkelompok;
    data['departemen'] = departemen;
    data['Promosi'] = promosi;
    data['Harga_jual'] = hargaJual;
    data['harga_net'] = hargaNet;
    data['foto'] = foto;
    return data;
  }
}