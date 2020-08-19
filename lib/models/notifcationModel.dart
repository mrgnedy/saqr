
  class NotifcationModel {
  String msg;
  List<Data> data;


  NotifcationModel({
    this.msg, this.data,
    
    
    
    
    
    });

  NotifcationModel.fromJson(Map<String, dynamic> json) {
print("----------------------mahmoud------------------------------");
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
  Notfication notfication;

  Order order;
  Servce servce;
  String catName;
  String subCatName;

  Data(
      {this.notfication,
      this.order,
      this.servce,
      this.catName,
      this.subCatName});

  Data.fromJson(Map<String, dynamic> json) {
    print("----------------mahmoud------------------");
    notfication = json['notfication'] != null
        ? new Notfication.fromJson(json['notfication'])
        : null;
    order = json['order'] != null ? new Order.fromJson(json['order']) : null;
    servce =
        json['servce'] != null ? new Servce.fromJson(json['servce']) : null;
    catName = json['catName'];
    subCatName = json['subCatName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.notfication != null) {
      data['notfication'] = this.notfication.toJson();
    }
    if (this.order != null) {
      data['order'] = this.order.toJson();
    }
    if (this.servce != null) {
      data['servce'] = this.servce.toJson();
    }
    data['catName'] = this.catName;
    data['subCatName'] = this.subCatName;
    return data;
  }
}

class Notfication {
  int id;
  int userId;
  String content;
  int type;
  String createdAt;
  String updatedAt;
  User user;

  Notfication(
      {this.id,
      this.userId,
      this.content,
      this.type,
      this.createdAt,
      this.updatedAt,
      this.user});

  Notfication.fromJson(Map<String, dynamic> json) {
    print("----------------mahmoud-------------");
    id = json['id'];
    userId = json['user_id'];
    content = json['content'].toString();
    type = json['type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['content'] = this.content;
    data['type'] = this.type;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}

class User {
  int id;
  String name;
  Null email;
  String phone;
  String imageProfile;
  Null imageId;
  int code;
  int active;
  int type;
  int isProvider;
  Null emailVerifiedAt;
  String deviceToken;
  String apiToken;
  int onAvailable;
  String createdAt;
  String updatedAt;

  User(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.imageProfile,
      this.imageId,
      this.code,
      this.active,
      this.type,
      this.isProvider,
      this.emailVerifiedAt,
      this.deviceToken,
      this.apiToken,
      this.onAvailable,
      this.createdAt,
      this.updatedAt});

  User.fromJson(Map<String, dynamic> json) { print("----------------mahmoud-------------");
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    imageProfile = json['imageProfile'];
    imageId = json['imageId'];
    code = json['code'];
    active = json['active'];
    type = json['type'];
    isProvider = json['is_provider'];
    emailVerifiedAt = json['email_verified_at'];
    deviceToken = json['device_token'];
    apiToken = json['api_token'];
    onAvailable = json['onAvailable'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['imageProfile'] = this.imageProfile;
    data['imageId'] = this.imageId;
    data['code'] = this.code;
    data['active'] = this.active;
    data['type'] = this.type;
    data['is_provider'] = this.isProvider;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['device_token'] = this.deviceToken;
    data['api_token'] = this.apiToken;
    data['onAvailable'] = this.onAvailable;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Order {
  int id;
  int serviceId;
  int userId;
  dynamic price;
  int status;
  int acceptPrice;
  String addressTo;
  double longTo;
  double latTo;
  String addressFrom;
  double longFrom;
  double latFrom;
  String createdAt;
  String updatedAt;

  Order(
      {this.id,
      this.serviceId,
      this.userId,
      this.price,
      this.status,
      this.acceptPrice,
      this.addressTo,
      this.longTo,
      this.latTo,
      this.addressFrom,
      this.longFrom,
      this.latFrom,
      this.createdAt,
      this.updatedAt});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceId = json['service_id'];
    userId = json['user_id'];
    price = json['price'];
    status = json['status'];
    acceptPrice = json['acceptPrice'];
    addressTo = json['addressTo'];
    longTo = json['longTo'];
    latTo = json['latTo'];
    addressFrom = json['addressFrom'];
    longFrom = json['longFrom'];
    latFrom = json['latFrom'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['service_id'] = this.serviceId;
    data['user_id'] = this.userId;
    data['price'] = this.price;
    data['status'] = this.status;
    data['acceptPrice'] = this.acceptPrice;
    data['addressTo'] = this.addressTo;
    data['longTo'] = this.longTo;
    data['latTo'] = this.latTo;
    data['addressFrom'] = this.addressFrom;
    data['longFrom'] = this.longFrom;
    data['latFrom'] = this.latFrom;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
class Servce {
  int id;
  String address;
  double long;
  double lat;
  String imageId;
  String imagelicense;
  String imageFrontCar;
  String imageBackCar;
  String plateNumber;
  int isAvailable;
  int userId;
  int categoryId;
  int subCategoryId;
  String createdAt;
  String updatedAt;

  Servce(
      {this.id,
      this.address,
      this.long,
      this.lat,
      this.imageId,
      this.imagelicense,
      this.imageFrontCar,
      this.imageBackCar,
      this.plateNumber,
      this.isAvailable,
      this.userId,
      this.categoryId,
      this.subCategoryId,
      this.createdAt,
      this.updatedAt});

  Servce.fromJson(Map<String, dynamic> json) { print("----------------mahmoud-------------");
    id = json['id'];
    address = json['address'];
    long = json['long'];
    lat = json['lat'];
    imageId = json['imageId'];
    imagelicense = json['Imagelicense'];
    imageFrontCar = json['ImageFrontCar'];
    imageBackCar = json['ImageBackCar'];
    plateNumber = json['PlateNumber'];
    isAvailable = json['is_available'];
    userId = json['user_id'];
    categoryId = json['category_id'];
    subCategoryId = json['subCategory_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['address'] = this.address;
    data['long'] = this.long;
    data['lat'] = this.lat;
    data['imageId'] = this.imageId;
    data['Imagelicense'] = this.imagelicense;
    data['ImageFrontCar'] = this.imageFrontCar;
    data['ImageBackCar'] = this.imageBackCar;
    data['PlateNumber'] = this.plateNumber;
    data['is_available'] = this.isAvailable;
    data['user_id'] = this.userId;
    data['category_id'] = this.categoryId;
    data['subCategory_id'] = this.subCategoryId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}