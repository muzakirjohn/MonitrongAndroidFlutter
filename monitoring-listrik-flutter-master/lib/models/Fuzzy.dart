class Fuzzy {
  bool? status;
  int? code;
  String? msg;
  Data? data;

  Fuzzy({this.status, this.code, this.msg, this.data});

  Fuzzy.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    msg = json['msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  List<DataFuzy>? dataFuzy;
  List<ResultTable>? resultTable;
  int? energyTotal;
  String? hargaTotal;

  Data({this.dataFuzy, this.resultTable, this.energyTotal, this.hargaTotal});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['dataFuzy'] != null) {
      dataFuzy = <DataFuzy>[];
      json['dataFuzy'].forEach((v) {
        dataFuzy!.add(new DataFuzy.fromJson(v));
      });
    }
    if (json['resultTable'] != null) {
      resultTable = <ResultTable>[];
      json['resultTable'].forEach((v) {
        resultTable!.add(new ResultTable.fromJson(v));
      });
    }
    energyTotal = json['energyTotal'];
    hargaTotal = json['hargaTotal'];
  }
}

class DataFuzy {
  String? waktus;
  DataFuzys? dataFuzys;

  DataFuzy({this.waktus, this.dataFuzys});

  DataFuzy.fromJson(Map<String, dynamic> json) {
    waktus = json['waktu'];
    dataFuzys = json['dataFuzy'] != null
        ? new DataFuzys.fromJson(json['dataFuzy'])
        : null;
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['waktu'] = this.waktus;
  //   if (this.dataFuzys != null) {
  //     data['dataFuzy'] = this.dataFuzys!.toJson();
  //   }
  //   return data;
  // }
}

class DataFuzys {
  double? fuzy;
  String? text;

  DataFuzys({this.fuzy, this.text});

  DataFuzys.fromJson(Map<String, dynamic> json) {
    fuzy = json['fuzy'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fuzy'] = this.fuzy;
    data['text'] = this.text;
    return data;
  }
}

class ResultTable {
  String? waktu;
  dynamic? power;
  dynamic? energy;
  String? biaya;
  dynamic jumlah = 1;
  int stopwatch = 0;

  ResultTable({this.waktu, this.power, this.energy, this.biaya});

  ResultTable.fromJson(Map<String, dynamic> json) {
    waktu = json['waktu'];
    power = json['power'];
    energy = json['energy'];
    biaya = json['biaya'];
    jumlah = json['jumlah'];
    stopwatch = json['stopwatch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['waktu'] = this.waktu;
    data['power'] = this.power;
    data['energy'] = this.energy;
    data['biaya'] = this.biaya;
    return data;
  }
}
