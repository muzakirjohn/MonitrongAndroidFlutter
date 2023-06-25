import 'package:cloud_firestore/cloud_firestore.dart';

class Monitoring {
  double? arus1;
  double? arus2;
  double? arus3;
  double? arustotal;
  double? hargaListrik;
  double? tegangan1;
  double? tegangan2;
  double? tegangan3;
  double? tegangantotal;
  Timestamp? timeStamp;
  double? energy1;
  double? energy2;
  double? energy3;
  double? energytotal;
  double? power1;
  double? power2;
  double? power3;
  double? powerUtama;

  Monitoring(
      {this.arus1,
      this.arus2,
      this.arus3,
      this.arustotal,
      this.hargaListrik,
      this.tegangan1,
      this.tegangan2,
      this.tegangan3,
      this.tegangantotal,
      this.timeStamp,
      this.energy1,
      this.energy2,
      this.energy3,
      this.energytotal,
      this.power1,
      this.power2,
      this.power3,
      this.powerUtama});

  Monitoring.fromJson(Map<String, dynamic> json) {
    arus1 = json['Arus1'];
    arus2 = json['Arus2'];
    arus3 = json['Arus3'];
    arustotal = json['Arustotal'];
    hargaListrik = json['HargaListrik'];
    tegangan1 = json['Tegangan1'];
    tegangan2 = json['Tegangan2'];
    tegangan3 = json['Tegangan3'];
    tegangantotal = json['Tegangantotal'];
    timeStamp = json['TimeStamp'];
    energy1 = json['energy1'];
    energy2 = json['energy2'];
    energy3 = json['energy3'];
    energytotal = json['energytotal'];
    power1 = json['power1'];
    power2 = json['power2'];
    power3 = json['power3'];
    powerUtama = json['powerUtama'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Arus1'] = this.arus1;
    data['Arus2'] = this.arus2;
    data['Arus3'] = this.arus3;
    data['Arustotal'] = this.arustotal;
    data['HargaListrik'] = this.hargaListrik;
    data['Tegangan1'] = this.tegangan1;
    data['Tegangan2'] = this.tegangan2;
    data['Tegangan3'] = this.tegangan3;
    data['Tegangantotal'] = this.tegangantotal;
    data['TimeStamp'] = this.timeStamp;
    data['energy1'] = this.energy1;
    data['energy2'] = this.energy2;
    data['energy3'] = this.energy3;
    data['energytotal'] = this.energytotal;
    data['power1'] = this.power1;
    data['power2'] = this.power2;
    data['power3'] = this.power3;
    data['powerUtama'] = this.powerUtama;
    return data;
  }
}
