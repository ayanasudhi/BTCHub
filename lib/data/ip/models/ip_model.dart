// /// ip : "66.249.75.9"
// /// country : "United States"
// /// cc : "US"
//
// class IpModel {
//   String ip;
//   String country;
//   String cc;
//
//   IpModel({this.ip, this.country, this.cc});
//
//   IpModel.fromJson(Map<String, dynamic> json) {
//     ip = json['ip'];
//     country = json['country'];
//     cc = json['cc'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['ip'] = this.ip;
//     data['country'] = this.country;
//     data['cc'] = this.cc;
//     return data;
//   }
// }