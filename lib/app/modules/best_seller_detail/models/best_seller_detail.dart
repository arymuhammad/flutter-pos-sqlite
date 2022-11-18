// To parse this JSON data, do
//
//     final bestSellerDetail = bestSellerDetailFromJson(jsonString);

import 'dart:convert';

BestSellerDetail bestSellerDetailFromJson(String str) => BestSellerDetail.fromJson(json.decode(str));

String bestSellerDetailToJson(BestSellerDetail data) => json.encode(data.toJson());

class BestSellerDetail {
  int? status;
  bool? success;
  String? message;
  int? totalData;
  bool? isCached;
  List<Data>? data;

  BestSellerDetail(
      {this.status,
      this.success,
      this.message,
      this.totalData,
      this.isCached,
      this.data});

  BestSellerDetail.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];
    message = json['message'];
    totalData = json['total_data'];
    isCached = json['isCached'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['success'] = success;
    data['message'] = message;
    data['total_data'] = totalData;
    data['isCached'] = isCached;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? kodeBarang;
  String? namaBarang;
  String? kodeCabang;
  String? artikel;
  String? departemen;
  String? kelompok;
  String? season;
  String? subkelompok;
  String? kodeMerk;
  String? value;
  String? total;
  String? stock;
  String? gambar;

  Data(
      {this.kodeBarang,
      this.namaBarang,
      this.kodeCabang,
      this.artikel,
      this.departemen,
      this.kelompok,
      this.season,
      this.subkelompok,
      this.kodeMerk,
      this.value,
      this.total,
      this.stock,
      this.gambar});

  Data.fromJson(Map<String, dynamic> json) {
    kodeBarang = json['Kode_Barang'];
    namaBarang = json['Nama_Barang'];
    kodeCabang = json['Kode_Cabang'];
    artikel = json['artikel'];
    departemen = json['departemen'];
    kelompok = json['kelompok'];
    season = json['season'];
    subkelompok = json['subkelompok'];
    kodeMerk = json['kode_merk'];
    value = json['value'];
    total = json['total'];
    stock = json['stock'];
    gambar = json['gambar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Kode_Barang'] = kodeBarang;
    data['Nama_Barang'] = namaBarang;
    data['Kode_Cabang'] = kodeCabang;
    data['artikel'] = artikel;
    data['departemen'] = departemen;
    data['kelompok'] = kelompok;
    data['season'] = season;
    data['subkelompok'] = subkelompok;
    data['kode_merk'] = kodeMerk;
    data['value'] = value;
    data['total'] = total;
    data['stock'] = stock;
    data['gambar'] = gambar;
    return data;
  }
}