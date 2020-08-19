class ReviewModel {
  String msg;
  List<Data> data;

  ReviewModel({this.msg, this.data});

  ReviewModel.fromJson(Map<String, dynamic> json) {
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
  Rate rate;
  String nameCustomer;
  String imageProfileCustomer;
  String nameProvider;
  dynamic rateAvg;

  Data(
      {this.rate,
      this.nameCustomer,
      this.imageProfileCustomer,
      this.nameProvider,
      this.rateAvg});

  Data.fromJson(Map<String, dynamic> json) {
    rate = json['rate'] != null ? new Rate.fromJson(json['rate']) : null;
    nameCustomer = json['nameCustomer'];
    imageProfileCustomer = json['imageProfileCustomer'];
    nameProvider = json['nameProvider'];
    rateAvg = json['rateAvg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.rate != null) {
      data['rate'] = this.rate.toJson();
    }
    data['nameCustomer'] = this.nameCustomer;
    data['imageProfileCustomer'] = this.imageProfileCustomer;
    data['nameProvider'] = this.nameProvider;
    data['rateAvg'] = this.rateAvg;
    return data;
  }
}

class Rate {
  int id;
  int userId;
  int serviceId;
  dynamic rate;
  String review;
  String createdAt;
  String updatedAt;

  Rate(
      {this.id,
      this.userId,
      this.serviceId,
      this.rate,
      this.review,
      this.createdAt,
      this.updatedAt});

  Rate.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    serviceId = json['service_id'];
    rate = json['rate'];
    review = json['review'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['service_id'] = this.serviceId;
    data['rate'] = this.rate;
    data['review'] = this.review;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}