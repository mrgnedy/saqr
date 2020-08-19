class CommtionAmountModel {
  String msg;
  Data data;

  CommtionAmountModel({this.msg, this.data});

  CommtionAmountModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  Commission commission;
  dynamic com;

  Data({this.commission, this.com});

  Data.fromJson(Map<String, dynamic> json) {
    commission = json['commission'] != null
        ? new Commission.fromJson(json['commission'])
        : null;
    com = json['com'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.commission != null) {
      data['commission'] = this.commission.toJson();
    }
    data['com'] = this.com;
    return data;
  }
}

class Commission {
  String amountMony;
  int userId;
  int serviceId;
  String updatedAt;
  String createdAt;
  int id;

  Commission(
      {this.amountMony,
      this.userId,
      this.serviceId,
      this.updatedAt,
      this.createdAt,
      this.id});

  Commission.fromJson(Map<String, dynamic> json) {
    amountMony = json['amountMony'];
    userId = json['user_id'];
    serviceId = json['service_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amountMony'] = this.amountMony;
    data['user_id'] = this.userId;
    data['service_id'] = this.serviceId;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
