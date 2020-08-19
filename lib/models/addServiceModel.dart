class AddServiceModel {
  String msg;
  Data data;

  AddServiceModel({this.msg, this.data});

  AddServiceModel.fromJson(Map<String, dynamic> json) {
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
  Service service;
  List<ImgServices> imgServices;

  Data({this.service, this.imgServices});

  Data.fromJson(Map<String, dynamic> json) {
    service =
        json['service'] != null ? new Service.fromJson(json['service']) : null;
    if (json['imgServices'] != null) {
      imgServices = new List<ImgServices>();
      json['imgServices'].forEach((v) {
        imgServices.add(new ImgServices.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.service != null) {
      data['service'] = this.service.toJson();
    }
    if (this.imgServices != null) {
      data['imgServices'] = this.imgServices.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Service {
  String address;
  String long;
  String lat;
  String plateNumber;
  String categoryId;
  String subCategoryId;
  int userId;
  String updatedAt;
  String createdAt;
  int id;

  Service(
      {this.address,
      this.long,
      this.lat,
      this.plateNumber,
      this.categoryId,
      this.subCategoryId,
      this.userId,
      this.updatedAt,
      this.createdAt,
      this.id});

  Service.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    long = json['long'];
    lat = json['lat'];
    plateNumber = json['PlateNumber'];
    categoryId = json['category_id'];
    subCategoryId = json['subCategory_id'];
    userId = json['user_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['long'] = this.long;
    data['lat'] = this.lat;
    data['PlateNumber'] = this.plateNumber;
    data['category_id'] = this.categoryId;
    data['subCategory_id'] = this.subCategoryId;
    data['user_id'] = this.userId;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}

class ImgServices {
  int id;
  String image;
  int serviceId;
  String createdAt;
  String updatedAt;

  ImgServices(
      {this.id, this.image, this.serviceId, this.createdAt, this.updatedAt});

  ImgServices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    serviceId = json['service_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['service_id'] = this.serviceId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}