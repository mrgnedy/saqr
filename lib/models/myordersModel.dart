class MyOrdersModel {
  String msg;
  Data data;

  MyOrdersModel({this.msg, this.data});

  MyOrdersModel.fromJson(Map<String, dynamic> json) {
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
  List<MyOrder> myOrder;
  List<OrdersForProvider> ordersForProvider;

  Data({this.myOrder, this.ordersForProvider});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['myOrder'] != null) {
      myOrder = new List<MyOrder>();
      json['myOrder'].forEach((v) {
        myOrder.add(new MyOrder.fromJson(v));
      });
    }
    if (json['ordersForProvider'] != null) {
      ordersForProvider = new List<OrdersForProvider>();
      json['ordersForProvider'].forEach((v) {
        ordersForProvider.add(new OrdersForProvider.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.myOrder != null) {
      data['myOrder'] = this.myOrder.map((v) => v.toJson()).toList();
    }
    if (this.ordersForProvider != null) {
      data['ordersForProvider'] =
          this.ordersForProvider.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MyOrder {
  Order order;
  String categoyName;
  String categoyImage;
  String subCategoyName;
  String subCategoyImage;
  String userName;
  String providerPhone;

  MyOrder(
      {this.order,
      this.categoyName,
      this.categoyImage,
      this.subCategoyName,
      this.subCategoyImage,
      this.userName,
      this.providerPhone});

  MyOrder.fromJson(Map<String, dynamic> json) {
    order = json['order'] != null ? new Order.fromJson(json['order']) : null;
    categoyName = json['categoyName'];
    categoyImage = json['categoyImage'];
    subCategoyName = json['subCategoyName'];
    subCategoyImage = json['subCategoyImage'];
    userName = json["userName"];
    providerPhone = json["providerPhone"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.order != null) {
      data['order'] = this.order.toJson();
    }
    data['categoyName'] = this.categoyName;
    data['categoyImage'] = this.categoyImage;
    data['subCategoyName'] = this.subCategoyName;
    data['subCategoyImage'] = this.subCategoyImage;
    return data;
  }
}

class Order {
  int id;
  int serviceId;
  int userId;
  int isPrice;
  int price;
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
      this.isPrice,
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
    isPrice = json['is_price'];
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
    data['is_price'] = this.isPrice;
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

class OrdersForProvider {
  List<Order> ordersRequested;
  Service service;
  String categoyName;
  String categoyImage;
  String subCategoyName;
  String subCategoyImage;

  OrdersForProvider(
      {this.ordersRequested,
      this.service,
      this.categoyName,
      this.categoyImage,
      this.subCategoyName,
      this.subCategoyImage});

  OrdersForProvider.fromJson(Map<String, dynamic> json) {
    if (json['ordersRequested'] != null) {
      ordersRequested = new List<Order>();
      json['ordersRequested'].forEach((v) {
        ordersRequested.add(new Order.fromJson(v));
      });
    }
    service =
        json['service'] != null ? new Service.fromJson(json['service']) : null;
    categoyName = json['categoyName'];
    categoyImage = json['categoyImage'];
    subCategoyName = json['subCategoyName'];
    subCategoyImage = json['subCategoyImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.ordersRequested != null) {
      data['ordersRequested'] =
          this.ordersRequested.map((v) => v.toJson()).toList();
    }
    if (this.service != null) {
      data['service'] = this.service.toJson();
    }
    data['categoyName'] = this.categoyName;
    data['categoyImage'] = this.categoyImage;
    data['subCategoyName'] = this.subCategoyName;
    data['subCategoyImage'] = this.subCategoyImage;
    return data;
  }
}

class Service {
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
  String job;
  String createdAt;
  String updatedAt;

  Service(
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
      this.job,
      this.createdAt,
      this.updatedAt});

  Service.fromJson(Map<String, dynamic> json) {
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
    job = json['job'];
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
    data['job'] = this.job;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
