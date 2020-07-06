import 'dart:convert';

class Product {
  String Pname;
  String Pprice;
  String Ploction;
  String Pdescriptin;
  String Pcatogery;
  String qantati;
  String size;
  String ProID;
  String ProPrand;
  String ProPcon;

  Product({
    this.Pname,
    this.Pprice,
    this.Pcatogery,
    this.Pdescriptin,
    this.Ploction,
    this.size,
    this.qantati,
    this.ProID,
    this.ProPrand,
    this.ProPcon,
  });
  Map<String, dynamic> toMap() {
    return {
      'Name': this.Pname,
      "price": this.Pprice,
      'Cat': this.Pcatogery,
      'des': this.Pdescriptin,
      'Loc': this.Ploction,
      'siz': this.size,
      'qan': this.qantati,
      'prand': this.ProPrand,
      'con': this.ProPcon,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
        Pname: map['Name'],
        Ploction: map['Loc'],
        size: map['siz'],
        ProPcon: map['con'],
        Pcatogery: map['Cat'],
        Pdescriptin: map['des'],
        Pprice: map["price"],
        ProPrand: map['prand'],
        qantati: map['qan']);
  }
  static String convertToJson(List<Product> words) {
    List<Map<String, dynamic>> jsonData =
        words.map((word) => word.toMap()).toList();
    return jsonEncode(jsonData);
  }

  static List<Product> fromJSon(String json) {
    List<Map<String, dynamic>> jsonData = jsonDecode(json);

    return jsonData.map((map) => Product.fromMap(map)).toList();
  }
}
