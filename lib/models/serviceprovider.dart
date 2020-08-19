class ServiceProviderModel {
  String msg;
  List<Data> data;

  ServiceProviderModel({this.msg, this.data});

  ServiceProviderModel.fromJson(Map<String, dynamic> json) {
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
  String userName;
  String phone;
  String imageProfile;
  int categoryId;
  String catName;
  String subCatName;
  int subCategoryId;
  List<Imgs> imgs;
  String job;
  dynamic totalRate;

  Data(
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
      this.userName,
      this.phone,
      this.imageProfile,
      this.categoryId,
      this.catName,
      this.subCatName,
      this.subCategoryId,
      this.imgs,this.job,this.totalRate});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    address = json['address'];
    long = json['long']==null?null:double.parse (json['long'].toString());
    lat = json['lat']==null?null:double.parse (json['lat'].toString());
    imageId = json['imageId'];
    imagelicense = json['Imagelicense'];
    imageFrontCar = json['ImageFrontCar'];
    imageBackCar = json['ImageBackCar'];
    plateNumber = json['PlateNumber'];
    isAvailable = json['onAvailable'];
    userId = json['user_id'];
    userName = json['userName'];
    phone = json['phone'];
    imageProfile = json['imageProfile'];
    categoryId = json['category_id'];
    catName = json['catName'];
    subCatName = json['subCatName'];
    subCategoryId = json['subCategory_id'];
    job=json["job"];
    totalRate=json["totalRate"];
    if (json['imgs'] != null) {
      imgs = new List<Imgs>();
      json['imgs'].forEach((v) {
        imgs.add(new Imgs.fromJson(v));
      });
    }
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
    data['userName'] = this.userName;
    data['phone'] = this.phone;
    data['imageProfile'] = this.imageProfile;
    data['category_id'] = this.categoryId;
    data['catName'] = this.catName;
    data['subCatName'] = this.subCatName;
    data['subCategory_id'] = this.subCategoryId;
    if (this.imgs != null) {
      data['imgs'] = this.imgs.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Imgs {
  int id;
  String image;
  int serviceId;
  String createdAt;
  String updatedAt;

  Imgs({this.id, this.image, this.serviceId, this.createdAt, this.updatedAt});

  Imgs.fromJson(Map<String, dynamic> json) {
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
