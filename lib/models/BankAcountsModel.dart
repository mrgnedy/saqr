class BankAcountsModel {
  String msg;
  List<Data> data;

  BankAcountsModel({this.msg, this.data});

  BankAcountsModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int id;
  String nameAccount;
  String numberAccount;
  String appearance;
  String beneficiary;
  String image;

  Data(
      {this.id,
      this.nameAccount,
      this.numberAccount,
      this.appearance,
      this.beneficiary,
      this.image});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAccount = json['nameAccount'];
    numberAccount = json['numberAccount'];
    appearance = json['appearance'];
    beneficiary = json['beneficiary'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nameAccount'] = this.nameAccount;
    data['numberAccount'] = this.numberAccount;
    data['appearance'] = this.appearance;
    data['beneficiary'] = this.beneficiary;
    data['image'] = this.image;
    return data;
  }
}