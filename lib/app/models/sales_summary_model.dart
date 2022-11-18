class SalesSummary {
  int ?status;
  bool? success;
  String? message;
  bool? isCached;
  late Data? data;

  SalesSummary(
      { this.status,  this.success,  this.message,  this.isCached,   this.data});

  SalesSummary.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];
    message = json['message'];
    isCached = json['isCached'];
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['success'] = success;
    data['message'] = message;
    data['isCached'] = isCached;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  late Result result;
  late int statusTop;
  late List<ResultTop> resultTop;
  late List<ResultTopDaily> resultTopDaily;
  late List<ResultDetMonth> resultDetMonth;
  late List<ResultDetDayly> resultDetDayly;

  Data(
      {required this.result,
      required this.statusTop,
      required this.resultTop,
      required this.resultTopDaily,
      required this.resultDetMonth,
      required this.resultDetDayly});

  Data.fromJson(Map<String, dynamic> json) {
    result =
        Result.fromJson(json['result']);
    statusTop = json['status_top'];
    if (json['result_top'] != null) {
      resultTop = <ResultTop>[];
      json['result_top'].forEach((v) {
        resultTop.add( ResultTop.fromJson(v));
      });
    }
    if (json['result_top_daily'] != null) {
      // resultTopDaily = <ResultTopDaily>[];
      json['result_top_daily'].forEach((v) {
        // resultTopDaily!.add( ResultTopDaily.fromJson(v));
      });
    }
    if (json['result_det_month'] != null) {
      resultDetMonth = <ResultDetMonth>[];
      json['result_det_month'].forEach((v) {
        resultDetMonth.add( ResultDetMonth.fromJson(v));
      });
    }
    if (json['result_det_dayly'] != null) {
      resultDetDayly = <ResultDetDayly>[];
      json['result_det_dayly'].forEach((v) {
        resultDetDayly.add( ResultDetDayly.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['result'] = result.toJson();
    data['status_top'] = statusTop;
    data['result_top'] = resultTop.map((v) => v.toJson()).toList();
    data['result_top_daily'] =
        resultTopDaily.map((v) => v.toJson()).toList();
    data['result_det_month'] =
        resultDetMonth.map((v) => v.toJson()).toList();
    data['result_det_dayly'] =
        resultDetDayly.map((v) => v.toJson()).toList();
    return data;
  }
}

class Result {
  String? tanggal;
  String? daily;
  String? dailyQty;
  String? bulan;
  String? monthly;
  String? monthlyQty;

  Result(
      {this.tanggal,
      this.daily,
      this.dailyQty,
      this.bulan,
      this.monthly,
      this.monthlyQty});

  Result.fromJson(Map<String, dynamic> json) {
    tanggal = json['tanggal'];
    daily = json['daily'];
    dailyQty = json['daily_qty'];
    bulan = json['bulan'];
    monthly = json['monthly'];
    monthlyQty = json['monthly_qty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['tanggal'] = tanggal;
    data['daily'] = daily;
    data['daily_qty'] = dailyQty;
    data['bulan'] = bulan;
    data['monthly'] = monthly;
    data['monthly_qty'] = monthlyQty;
    return data;
  }
}

class ResultTop {
  late String kodeBarang;
  late String namaBarang;
  late String total;
  late String gambar;
  late String stock;

  ResultTop(
      {required this.kodeBarang, required this.namaBarang, required this.total, required this.gambar, required this.stock});

  ResultTop.fromJson(Map<String, dynamic> json) {
    kodeBarang = json['Kode_Barang'];
    namaBarang = json['Nama_Barang'];
    total = json['total'];
    gambar = json['gambar'];
    stock = json['Stock'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Kode_Barang'] = kodeBarang;
    data['Nama_Barang'] = namaBarang;
    data['total'] = total;
    data['gambar'] = gambar;
    data['Stock'] = stock;
    return data;
  }
}

class ResultTopDaily {
  late String kodeBarang;
  late String namaBarang;
  late String total;
  late String gambar;
  late String stock;

  ResultTopDaily(
      {required this.kodeBarang, required this.namaBarang, required this.total, required this.gambar, required this.stock});

  ResultTopDaily.fromJson(Map<String, dynamic> json) {
    kodeBarang = json['Kode_Barang'];
    namaBarang = json['Nama_Barang'];
    total = json['total'];
    gambar = json['gambar'];
    stock = json['Stock'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Kode_Barang'] = kodeBarang;
    data['Nama_Barang'] = namaBarang;
    data['total'] = total;
    data['gambar'] = gambar;
    data['Stock'] = stock;
    return data;
  }
}


class ResultDetMonth {
  late String footwearMonth;
  late String footwearMonthQty;
  late String onlinestoreMonth;
  late String onlinestoreMonthQty;
  late String clothingMonth;
  late String clothingMonthQty;

  ResultDetMonth(
      {required this.footwearMonth,
      required this.footwearMonthQty,
      required this.onlinestoreMonth,
      required this.onlinestoreMonthQty,
      required this.clothingMonth,
      required this.clothingMonthQty});

  ResultDetMonth.fromJson(Map<String, dynamic> json) {
    footwearMonth = json['footwear_month'];
    footwearMonthQty = json['footwear_month_qty'];
    onlinestoreMonth = json['onlinestore_month'];
    onlinestoreMonthQty = json['onlinestore_month_qty'];
    clothingMonth = json['clothing_month'];
    clothingMonthQty = json['clothing_month_qty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['footwear_month'] = footwearMonth;
    data['footwear_month_qty'] = footwearMonthQty;
    data['onlinestore_month'] = onlinestoreMonth;
    data['onlinestore_month_qty'] = onlinestoreMonthQty;
    data['clothing_month'] = clothingMonth;
    data['clothing_month_qty'] = clothingMonthQty;
    return data;
  }
}

class ResultDetDayly {
  late String footwearDay;
  late String footwearDayQty;
  late String onlinestoreDay;
  late String onlinestoreDayQty;
  late String clothingDay;
  late String clothingDayQty;

  ResultDetDayly(
      {required this.footwearDay,
      required this.footwearDayQty,
      required this.onlinestoreDay,
      required this.onlinestoreDayQty,
      required this.clothingDay,
      required this.clothingDayQty});

  ResultDetDayly.fromJson(Map<String, dynamic> json) {
    footwearDay = json['footwear_day'];
    footwearDayQty = json['footwear_day_qty'];
    onlinestoreDay = json['onlinestore_day'];
    onlinestoreDayQty = json['onlinestore_day_qty'];
    clothingDay = json['clothing_day'];
    clothingDayQty = json['clothing_day_qty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['footwear_day'] = footwearDay;
    data['footwear_day_qty'] = footwearDayQty;
    data['onlinestore_day'] = onlinestoreDay;
    data['onlinestore_day_qty'] = onlinestoreDayQty;
    data['clothing_day'] = clothingDay;
    data['clothing_day_qty'] = clothingDayQty;
    return data;
  }
}