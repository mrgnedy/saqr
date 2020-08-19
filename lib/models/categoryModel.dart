
 class CategoryModel {
  String msg;
  List<Data> data;

  CategoryModel({this.msg, this.data});

  CategoryModel.fromJson(Map<String, dynamic> json) {
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
  String name;
  String image;
  int commission;
  int price;
  int isSelect;
  List<SubCategories> subCategories;

  Data(
      {this.id,
      this.name,
      this.image,
      this.commission,
      this.price,
      this.isSelect,
      this.subCategories});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    commission = json['commission'];
    price = json['price'];
    isSelect = json['is_select'];
    if (json['subCategories'] != null) {
      subCategories = new List<SubCategories>();
      json['subCategories'].forEach((v) {
        subCategories.add(new SubCategories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['commission'] = this.commission;
    data['price'] = this.price;
    data['is_select'] = this.isSelect;
    if (this.subCategories != null) {
      data['subCategories'] =
          this.subCategories.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubCategories {
  int id;
  String name;
  String image;
  Null sizeBus;
  Null sizeClean;
  Null sizeSurfaces;
  int categoryId;
  String createdAt;
  String updatedAt;

  SubCategories(
      {this.id,
      this.name,
      this.image,
      this.sizeBus,
      this.sizeClean,
      this.sizeSurfaces,
      this.categoryId,
      this.createdAt,
      this.updatedAt});

  SubCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    sizeBus = json['size_bus'];
    sizeClean = json['size_clean'];
    sizeSurfaces = json['size_surfaces'];
    categoryId = json['category_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['size_bus'] = this.sizeBus;
    data['size_clean'] = this.sizeClean;
    data['size_surfaces'] = this.sizeSurfaces;
    data['category_id'] = this.categoryId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}