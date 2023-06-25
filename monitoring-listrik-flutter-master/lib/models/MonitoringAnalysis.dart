import 'package:cloud_firestore/cloud_firestore.dart';

class Monitoring {
  double? hargaListrik;
  double? pF;
  Timestamp? timeStamp;
  double? energy;
  double? frequency;
  double? power;

  Monitoring(
      {this.hargaListrik,
      this.pF,
      this.timeStamp,
      this.energy,
      this.frequency,
      this.power});

  Monitoring.fromJson(Map<String, dynamic> json) {
    hargaListrik = json['HargaListrik'];
    pF = json['PF'];
    timeStamp = json['timestamp'];
    energy = json['energy'];
    frequency = json['frequency'];
    power = json['power'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['HargaListrik'] = this.hargaListrik;
    data['PF'] = this.pF;
    data['timestamp'] = this.timeStamp;
    data['energy'] = this.energy;
    data['frequency'] = this.frequency;
    data['power'] = this.power;
    return data;
  }
}
