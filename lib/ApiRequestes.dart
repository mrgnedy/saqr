import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:multi_image_picker/src/asset.dart';
import 'package:saqr/dataUser.dart';
import 'package:saqr/models/BankAcountsModel.dart';
import 'package:saqr/models/aboutusModel.dart';
import 'package:saqr/models/addServiceModel.dart';
import 'package:saqr/models/categoryModel.dart';
import 'package:saqr/models/comtionAmountModel.dart';
import 'package:saqr/models/myordersModel.dart';
import 'package:saqr/models/notifcationModel.dart';
import 'package:saqr/models/profileModel.dart';
import 'package:saqr/models/serviceprovider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

import 'Utillity/ApiUtillity.dart';
import 'models/reviewModel.dart';

class ApiRequests {
  DataUser _dataUser = DataUser.instance;
  Future<CategoryModel> getCatergory() async {
    // SharedPreferences pref = await SharedPreferences.getInstance();

    final url = 'http://saaqr.site/api/getCategory';
    try {
      final response = await http.get(url, headers: {
        // 'Authorization':
        //     'Bearer ${token}', //'Bearer Ae1yIjbfO75e3K670cq8knv6VBBYaj6C0yXfVgmNidOZteaxoAZB68MWpr5j44IXwD5SSVmjF2q8d9VKkn86tUDHQHaRcw06uRm8', //$token',
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      });
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        print(responseData);
        if (responseData["msg"] == "success") {
          print("data");

          var data = CategoryModel.fromJson(responseData);

          return data;
        } else {
          // print(responseData.toString());
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      print("----------------discution function-------------");
      print(e);
      return null;
    }
  }

  Future<BankAcountsModel> getAcounts() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString(Token);

    final url = 'http://saaqr.site/api/getAccounts';
    try {
      final response = await http.get(url, headers: {
        'Authorization':
            'Bearer ${token}', //'Bearer Ae1yIjbfO75e3K670cq8knv6VBBYaj6C0yXfVgmNidOZteaxoAZB68MWpr5j44IXwD5SSVmjF2q8d9VKkn86tUDHQHaRcw06uRm8', //$token',
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      });
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        print(responseData);
        if (responseData["msg"] == "success") {
          print("data");

          var data = BankAcountsModel.fromJson(responseData);

          return data;
        } else {
          // print(responseData.toString());
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      print("----------------discution function-------------");
      print(e);
      return null;
    }
  }

  Future logout() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString("token");
    String id = pref.getString(Id);
    final url = 'http://saaqr.site/api/logout';
    try {
      final response = await http.post(url, body: {
        "user_id": id
      }, headers: {
        'Authorization': 'Bearer $token',
        "Accept": "application/json",
      });
      if (response.statusCode == 200) {
        return true;
      } else if ((response.statusCode == 401) || (response.statusCode == 403)) {
        print('asdasdasdasdasdasd');
        return 'unAuthorized';
      } else {
        //  final responseData = json.decode(response.body);
        print("-----------wrong info");
        // print(responseData);
        return null;
      }
    } catch (e) {
      print("-----------error frindrequest function -------");
      print(e);
      return null;
    }

//    retur    RoomsModel modelro;
//        modelro.fromJson(responseData).data;
  }

  Future<MyOrdersModel> getMyOrders() async {
    final url = 'http://saaqr.site/api/myOrders';
    SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString(Token);
    String id = pref.getString(Id).toString();
    print(id);
    try {
      print("----------------getnotifcation--------------");
      final response = await http.post(url, body: {
        "user_id": id.toString(),
      }, headers: {
        // 'Authorization':
        //     'Bearer ${token}', //'Bearer Ae1yIjbfO75e3K670cq8knv6VBBYaj6C0yXfVgmNidOZteaxoAZB68MWpr5j44IXwD5SSVmjF2q8d9VKkn86tUDHQHaRcw06uRm8', //$token',
        // 'Content-Type': 'application/json',
        'Accept': 'application/json'
      });
      print("----------------befor");
      final responseData = json.decode(response.body);
      print("----------------after");
      print(responseData);
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        print(responseData);
        if (responseData["msg"] == "success") {
          print("data");

          var data = MyOrdersModel.fromJson(responseData);
          return data;
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<NotifcationModel> getNotifcation() async {
    final url = 'http://saaqr.site/api/getNotfy';
    SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString(Token);
    String id = pref.getString(Id).toString();
    print(id);
    try {
      print("----------------getnotifcation--------------");
      final response = await http.post(url, body: {
        "user_id": id.toString(),
      }, headers: {
        // 'Authorization':
        //     'Bearer ${token}', //'Bearer Ae1yIjbfO75e3K670cq8knv6VBBYaj6C0yXfVgmNidOZteaxoAZB68MWpr5j44IXwD5SSVmjF2q8d9VKkn86tUDHQHaRcw06uRm8', //$token',
        // 'Content-Type': 'application/json',
        'Accept': 'application/json'
      });
      print("----------------befor");
      final responseData = json.decode(response.body);
      print("----------------after");
      print(responseData);
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        print(responseData);
        if (responseData["msg"] == "success") {
          print("data");

          var data = NotifcationModel.fromJson(responseData);
          return data;
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<ServiceProviderModel> getsearchData(
      String text, int categoryid, int subcategoryid) async {
    final url = 'http://saaqr.site/api/searchNamejob';
    print(text);
    print(categoryid);
    print(subcategoryid);
    try {
      final response = await http.post(url, body: {
        "category_id": categoryid.toString(),
        if (subcategoryid != null) "subCategory_id": subcategoryid.toString(),
        (subcategoryid != null ? "name" : "job"): text
      }, headers: {
        'Accept': 'application/json'
      });
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print("---------------search result");
        print(responseData);
        if (responseData["msg"] == "success") {
          print("data");

          var data = ServiceProviderModel.fromJson(responseData);
          return data;
        } else {
          return null;
        }
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<ReviewModel> getReviews(String id) async {
    final url = 'http://saaqr.site/api/getRate';

    try {
      final response = await http.post(url, body: {
        "service_id": id,
      }, headers: {
        'Accept': 'application/json'
      });
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        print(responseData);
        if (responseData["msg"] == "success") {
          print("data");

          var data = ReviewModel.fromJson(responseData);
          return data;
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<ServiceProviderModel> getProvidersServices(
      String catid, String subcatid) async {
    final url = 'http://saaqr.site/api/getServices';
    print(catid);
    print(subcatid);
    try {
      final response = await http.post(url, body: {
        "category_id": catid,
        (subcatid.toString() != "null" ? "subCategory_id" : "jdshj"): subcatid
      }, headers: {
        'Accept': 'application/json'
      });
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        print(responseData);
        if (responseData["msg"] == "success") {
          print("data");

          var data = ServiceProviderModel.fromJson(responseData);
          return data;
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future priceOrder(String price, String orderid, int status) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString(Token);

    final url = 'http://saaqr.site/api/addPriceOrder';
    try {
      final response = await http.post(url, body: {
        'order_id': orderid,
        'price': price,
        "is_price": status.toString()
      }, headers: {
        'Authorization':
            'Bearer ${token}', //'Bearer Ae1yIjbfO75e3K670cq8knv6VBBYaj6C0yXfVgmNidOZteaxoAZB68MWpr5j44IXwD5SSVmjF2q8d9VKkn86tUDHQHaRcw06uRm8', //$token',
        // 'Content-Type': 'application/json',
        'Accept': 'application/json'
      });

      final responseData = json.decode(response.body);
      print(responseData);
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print(responseData);
        if (responseData["msg"] == "success") {
          return true;
        } else if (responseData["msg"].toString() == "false") {
          print("----------------false0-------------");
          return false;
        }
      }
    } catch (e) {
      print("-----------------error login------------");
      print(e);
      return null;
    }
  }

  Future acceptPrice(String status, String orderid) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString(Token);

    final url = 'http://saaqr.site/api/acceptancePrice';
    try {
      final response = await http.post(url, body: {
        'order_id': orderid,
        'acceptPrice': status,
      }, headers: {
        'Authorization':
            'Bearer ${token}', //'Bearer Ae1yIjbfO75e3K670cq8knv6VBBYaj6C0yXfVgmNidOZteaxoAZB68MWpr5j44IXwD5SSVmjF2q8d9VKkn86tUDHQHaRcw06uRm8', //$token',
        // 'Content-Type': 'application/json',
        'Accept': 'application/json'
      });

      final responseData = json.decode(response.body);
      print(responseData);
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print(responseData);
        if (responseData["msg"] == "success") {
          return true;
        } else if (responseData["msg"].toString() == "false") {
          print("----------------false0-------------");
          return false;
        }
      }
    } catch (e) {
      print("-----------------error login------------");
      print(e);
      return null;
    }
  }

  Future deleteorder(String notifcationid) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString(Token);

    final url = 'http://saaqr.site/api/destroyOrder';
    try {
      final response = await http.post(url, body: {
        'order_id': notifcationid,
      }, headers: {
        'Authorization':
            'Bearer ${token}', //'Bearer Ae1yIjbfO75e3K670cq8knv6VBBYaj6C0yXfVgmNidOZteaxoAZB68MWpr5j44IXwD5SSVmjF2q8d9VKkn86tUDHQHaRcw06uRm8', //$token',
        // 'Content-Type': 'application/json',
        'Accept': 'application/json'
      });

      // final responseData = json.decode(response.body);
      // print(responseData);
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print(responseData);
        if (responseData["msg"] == "success") {
          return true;
        } else if (responseData["msg"].toString() == "false") {
          print("----------------false0-------------");
          return false;
        }
      }
    } catch (e) {
      print("-----------------error login------------");
      print(e);
      return null;
    }
  }

  Future deleteNotifcaton(String notifcationid) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString(Token);

    final url = 'http://saaqr.site/api/destroyNotfy';
    try {
      final response = await http.post(url, body: {
        'id': notifcationid,
      }, headers: {
        'Authorization':
            'Bearer ${token}', //'Bearer Ae1yIjbfO75e3K670cq8knv6VBBYaj6C0yXfVgmNidOZteaxoAZB68MWpr5j44IXwD5SSVmjF2q8d9VKkn86tUDHQHaRcw06uRm8', //$token',
        // 'Content-Type': 'application/json',
        'Accept': 'application/json'
      });

      // final responseData = json.decode(response.body);
      // print(responseData);
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print(responseData);
        if (responseData["msg"] == "success") {
          return true;
        } else if (responseData["msg"].toString() == "false") {
          print("----------------false0-------------");
          return false;
        }
      }
    } catch (e) {
      print("-----------------error login------------");
      print(e);
      return null;
    }
  }

  Future acceptorder(String status, String orderid) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString(Token);

    final url = 'http://saaqr.site/api/acceptanceOrder';
    try {
      final response = await http.post(url, body: {
        'order_id': orderid,
        'status': status,
      }, headers: {
        'Authorization':
            'Bearer ${token}', //'Bearer Ae1yIjbfO75e3K670cq8knv6VBBYaj6C0yXfVgmNidOZteaxoAZB68MWpr5j44IXwD5SSVmjF2q8d9VKkn86tUDHQHaRcw06uRm8', //$token',
        // 'Content-Type': 'application/json',
        'Accept': 'application/json'
      });

      final responseData = json.decode(response.body);
      print(responseData);
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print(responseData);
        if (responseData["msg"] == "success") {
          return true;
        } else if (responseData["msg"].toString() == "false") {
          print("----------------false0-------------");
          return false;
        }
      }
    } catch (e) {
      print("-----------------error login------------");
      print(e);
      return null;
    }
  }

  Future addCmmtionamount(String amount) async {
    // SharedPreferences pref = await SharedPreferences.getInstance();
    SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString(Token);
    // print(password);

    final url = 'http://saaqr.site/api/addAmountMony';
    try {
      final response = await http.post(url, body: {
        'amountMony': amount,
      }, headers: {
        'Authorization':
            'Bearer ${token}', //'Bearer Ae1yIjbfO75e3K670cq8knv6VBBYaj6C0yXfVgmNidOZteaxoAZB68MWpr5j44IXwD5SSVmjF2q8d9VKkn86tUDHQHaRcw06uRm8', //$token',
        // 'Content-Type': 'application/json',
        'Accept': 'application/json'
      });

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        if (responseData["msg"] == "success") {
          final responseData = json.decode(response.body);
          var _data = CommtionAmountModel.fromJson(responseData);

          return _data;
        } else if (responseData["msg"].toString() == "false") {
          print("----------------false0-------------");
          return false;
        }
      }
    } catch (e) {
      print("-----------------error login------------");
      print(e);
      return null;
    }
  }

  Future login(String phone, String password, String googletoken) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    print(password);

    final url = 'http://saaqr.site/api/login';
    try {
      final response = await http.post(
        url,
        body: {
          'phone': phone,
          'password': password,
          'device_token': googletoken,
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        if (responseData["msg"] == "success") {
          final responseData = json.decode(response.body);
          var _data = ProfoileModel.fromJson(responseData);
          print("----------------after-------------------");

          pref.setString(Token, _data.data.apiToken.toString());
          pref.setString(Is_Coworker, _data.data.isProvider.toString());
          pref.setString(Isverfied, _data.data.active.toString());
          pref.setString(Profile_Image, _data.data.imageProfile.toString());
          pref.setString(Name, _data.data.name.toString());
          pref.setString(PhoneNumber, _data.data.phone.toString());
          pref.setString(Isverfied, "1");
          pref.getString(Token);
          pref.setString(Id, _data.data.id.toString());
          _dataUser.setKey({'key': Id, 'value': pref.getString(Id)});
          _dataUser.setKey(
              {'key': Is_Coworker, 'value': pref.getString(Is_Coworker)});
          _dataUser.setKey({'key': Token, 'value': pref.getString(Token)});
          _dataUser
              .setKey({'key': Isverfied, 'value': pref.getString(Isverfied)});
          _dataUser.setKey(
              {'key': Profile_Image, 'value': pref.getString(Profile_Image)});
          _dataUser.setKey({'key': Name, 'value': pref.getString(Name)});
          _dataUser.setKey(
              {'key': PhoneNumber, 'value': pref.getString(PhoneNumber)});
          _dataUser.setKey({'key': ISLOGING, 'value': "true"});

          if (_data.data.active != 1) {
            print("needActivekkkjk");
            return "needActive";
          } else {
            print("true");

            return true;
          }
        } else if (responseData["msg"].toString() == "false") {
          print("----------------false0-------------");
          return false;
        }
      }
    } catch (e) {
      print("-----------------error login------------");
      print(e);
      return null;
    }
  }

  Future addServicefun(
      String addres,
      double lat,
      double long,
      File imageId,
      File imagelicense,
      File imageFrontCar,
      File imageBackCar,
      String plateNumber,
      int category_id,
      int subCategory_id,
      List<Asset> images,
      String job) async {
    print("hhhhhhhhhhhhhhhhhhhhh");
    SharedPreferences pref = await SharedPreferences.getInstance();
    // print(imagefile.path.split('/').last);
    String token = pref.getString(Token);
    String email = pref.getString(Id);
    print("hhhhhhhhhhhhhhhhhhhhh");
    print(email);
    print(token);
    print(addres);
    print(long);
    print(lat);
    print(job);
    print(category_id);
    print(subCategory_id);

    print("Bearer $token");
    Dio dio = new Dio();

    FormData formData = FormData();
    formData.fields..add(MapEntry('api_token', token));
    formData.fields..add(MapEntry('address', addres));
    formData.fields..add(MapEntry('long', long.toString()));
    formData.fields..add(MapEntry('lat', lat.toString()));
    plateNumber.toString() == "null" ? null : formData.fields
      ..add(MapEntry('PlateNumber', plateNumber.toString()));
    formData.fields..add(MapEntry('category_id', category_id.toString()));
    if (subCategory_id.toString() != "null") {
      print("subcat");
      formData.fields
        ..add(MapEntry('subCategory_id', subCategory_id.toString()));
    }

    job.toString() == "null" ? null : formData.fields
      ..add(MapEntry('job', job.toString()));
    print(imageId == null);
    if (imageId != null) {
      print("------------------------------------");
      print("-------------image id --------------------");
      formData.files.add(MapEntry(
        'imageId',
        await MultipartFile.fromFile(imageId.path,
            filename: imageId.path.split('/').last),
      ));
    }

    if (imagelicense != null) {
      print("------------------------------------");
      print("-------------image licence --------------------");
      formData.files.add(MapEntry(
        'Imagelicense',
        await MultipartFile.fromFile(imagelicense.path,
            filename: imagelicense.path.split('/').last),
      ));
    }

    if (imageFrontCar != null) {
      formData.files.add(MapEntry(
        'ImageFrontCar',
        await MultipartFile.fromFile(imageFrontCar.path,
            filename: imageFrontCar.path.split('/').last),
      ));
    }

    if (imageBackCar != null) {
      formData.files.add(MapEntry(
        'ImageBackCar',
        await MultipartFile.fromFile(imageBackCar.path,
            filename: imageBackCar.path.split('/').last),
      ));
    }

    if (images != null) if (images.length > 0) {
      for (var i = 0; i < images.length; i++) {
        ByteData byteData = await images[i].getByteData();
        List<int> imageData = byteData.buffer.asUint8List();
        var result = await FlutterImageCompress.compressWithList(
          imageData,
          minHeight: 800,
          minWidth: 800,
          quality: 96,
          // rotate: 135,
        );
        String filename = images[i].name;
        formData.files.add(MapEntry(
          'images[$i]',
          MultipartFile.fromBytes(result, filename: filename),
        ));
      }
    }

    try {
      final response = await dio.post(
        "http://saaqr.site/api/addServices",
        data: formData,
        onSendProgress: (int sent, int total) {
          print("$sent $total");
        },
        options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status < 500;
            }),
      );
      print("-------------------");
      print(response.data);
      if (response.data["msg"].toString() == "success") {
        // final responseData = json.decode(response.data);
        // var _data = AddServiceModel.fromJson(response.data);
        print("----------------after-------------------");

        pref.setString(Is_Coworker, "1");
        _dataUser.setKey({'key': Is_Coworker, 'value': "1"});
        return true;
      } else if (response.data["msg"].toString() == "false") {
        print("----------------false0-------------");
        return false;
      }
    } catch (e) {
      print("-------add room function error");
      print(e);
      return null;
    }
  }

  Future editProfile(String name, String phone, File imagefile) async {
    print("hhhhhhhhhhhhhhhhhhhhh");
    SharedPreferences pref = await SharedPreferences.getInstance();
    String id = pref.getString(Id);
    print(id);
    // print(imagefile.path.split('/').last);

    Dio dio = new Dio();

    FormData formData = FormData();
    formData.fields..add(MapEntry('user_id', id));
    formData.fields..add(MapEntry('name', name));
    formData.fields..add(MapEntry('phone', phone));
    if (imagefile != null) {
      formData.files.add(MapEntry(
        'imageProfile',
        await MultipartFile.fromFile(imagefile.path,
            filename: imagefile.path.split('/').last),
      ));
    }

    try {
      final response = await dio.post(
        "http://saaqr.site/api/editUser",
        data: formData,
        onSendProgress: (int sent, int total) {
          print("$sent $total");
        },
        options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status < 500;
            }),
      );
      print("-------------------");
      print(response.data);
      if (response.data["msg"].toString() == "success") {
        // final responseData = json.decode(response.data);
        var _data = ProfoileModel.fromJson(response.data);
        print("----------------after-------------------");

        pref.setString(Token, _data.data.apiToken.toString());
        pref.setString(Is_Coworker, _data.data.isProvider.toString());
        pref.setString(Isverfied, _data.data.active.toString());
        pref.setString(Profile_Image, _data.data.imageProfile.toString());
        pref.setString(Name, _data.data.name.toString());
        pref.setString(PhoneNumber, _data.data.phone.toString());

        pref.setString(Id, _data.data.id.toString());
        _dataUser
            .setKey({'key': Is_Coworker, 'value': pref.getString(Is_Coworker)});
        _dataUser.setKey({'key': Token, 'value': pref.getString(Token)});
        _dataUser
            .setKey({'key': Isverfied, 'value': pref.getString(Isverfied)});
        _dataUser.setKey(
            {'key': Profile_Image, 'value': pref.getString(Profile_Image)});
        _dataUser.setKey({'key': Name, 'value': pref.getString(Name)});
        _dataUser
            .setKey({'key': PhoneNumber, 'value': pref.getString(PhoneNumber)});
        _dataUser.setKey({'key': Id, 'value': pref.getString(Id)});
        _dataUser.setKey({'key': ISLOGING, 'value': "true"});

        return true;
      } else if (response.data["msg"].toString() == "false") {
        print("----------------false0-------------");
        return false;
      }
    } catch (e) {
      print("-------add room function error");
      print(e);
      return null;
    }
  }

  Future regester(String name, String phone, String password,
      String deviceToken, File imagefile) async {
    print("hhhhhhhhhhhhhhhhhhhhh");
    print(phone);
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(imagefile.path.split('/').last);

    Dio dio = new Dio();

    FormData formData = FormData();

    formData.fields..add(MapEntry('name', name));
    formData.fields..add(MapEntry('phone', phone));
    formData.fields..add(MapEntry('password', password));
    formData.fields..add(MapEntry('device_token', deviceToken));

    formData.files.add(MapEntry(
      'imageProfile',
      await MultipartFile.fromFile(imagefile.path,
          filename: imagefile.path.split('/').last),
    ));

    try {
      final response = await dio.post(
        "http://saaqr.site/api/register",
        data: formData,
        onSendProgress: (int sent, int total) {
          print("$sent $total");
        },
        options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status < 500;
            }),
      );
      print("-------------------");
      print(response.data);
      if (response.data["msg"].toString() == "success") {
        // final responseData = json.decode(response.data);
        var _data = ProfoileModel.fromJson(response.data);
        print("----------------after-------------------");

        pref.setString(Token, _data.data.apiToken.toString());
        pref.setString(Is_Coworker, _data.data.isProvider.toString());
        pref.setString(Isverfied, _data.data.active.toString());
        pref.setString(Profile_Image, _data.data.imageProfile.toString());
        pref.setString(Name, _data.data.name.toString());
        pref.setString(PhoneNumber, _data.data.phone.toString());

        pref.setString(Id, _data.data.id.toString());
        if (_data.data.active != 1) {
          print("needActivekkkjk");
          return "needActive";
        } else {
          print("true");
          return true;
        }
      } else if (response.data["msg"].toString() == "false") {
        print("----------------false0-------------");
        return false;
      }
    } catch (e) {
      print("-------add room function error");
      print(e);
      return null;
    }
  }

  Future countinueAddAmount(File imagefile, String acountNumber) async {
    print("hhhhhhhhhhhhhhhhhhhhh");
    SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString(Token);
    print(imagefile.path.split('/').last);

    Dio dio = new Dio();

    FormData formData = FormData();
    formData.fields..add(MapEntry('api_token', token));
    formData.fields..add(MapEntry('accountNumber', "name"));
    // formData.fields..add(MapEntry('phone', phone));

    formData.files.add(MapEntry(
      'imageRecepit',
      await MultipartFile.fromFile(imagefile.path,
          filename: imagefile.path.split('/').last),
    ));

    try {
      final response = await dio.post(
        "http://saaqr.site/api/addCommission",
        data: formData,
        onSendProgress: (int sent, int total) {
          print("$sent $total");
        },
        options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status < 500;
            }),
      );
      print("-------------------");
      print(response.data);
      if (response.data["msg"].toString() == "success") {
        print("true");
        return true;
      } else if (response.data["msg"].toString() == "false") {
        print("----------------false0-------------");
        return false;
      }
    } catch (e) {
      print("-------add room function error");
      print(e);
      return null;
    }
  }

  Future<bool> changepassword(String password, String phone2) async {
    print("get joinde room function ");
    SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString(Token);
    String phone = pref.getString(PhoneNumber);
    print("hhhhhhhhhhhhhhhhhhhhhhh");
    print(token);
    print("hhhhhhhhhhhhhhhhhhhhhhhq2");

    final url = 'http://saaqr.site/api/resetPassword';
    try {
      final response = await http.post(url, body: {
        "phone": phone2 == null ? phone : phone2,
        "password": password.toString(),
      }, headers: {
        // 'Authorization':
        //     'Bearer ${token}', // 'Bearer Ae1yIjbfO75e3K670cq8knv6VBBYaj6C0yXfVgmNidOZteaxoAZB68MWpr5j44IXwD5SSVmjF2q8d9VKkn86tUDHQHaRcw06uRm8', //$token',
        // 'Content-Type': 'application/json',
        'Accept': 'application/json'
      });
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        print(responseData);
        if (responseData["msg"] == "success") {
          print("data");

          // var data = CategoryModel.fromJson(responseData);
          return true;
        } else {
          print(responseData.toString());
          return false;
        }
      } else {
        return null;
      }
    } catch (e) {
      print("----------------discution function-------------");
      print(e);
      return null;
    }
  }

  Future<bool> sendPhoneCode(String phone) async {
    final url = 'http://saaqr.site/api/reset';
    try {
      final response = await http.post(url, body: {
        "phone": phone,
      }, headers: {
        //Ae1yIjbfO75e3K670cq8knv6VBBYaj6C0yXfVgmNidOZteaxoAZB68MWpr5j44IXwD5SSVmjF2q8d9VKkn86tUDHQHaRcw06uRm8', //$token',
        // 'Content-Type': 'application/json',
        'Accept': 'application/json'
      });
      print("--------------------------------");
      print(json.decode(response.body));
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        if (responseData["msg"] == "success") {
          // pref.setString(Confirmed, "1");

          return true;
        } else {
          return false;
        }
      }
    } catch (e) {
      print("-----------------error login------------");
      print(e);
      return null;
    }
  }

  Future<bool> resendverfiyedCode() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    print("in unction");
    // print(message);
    String phone = pref.getString(PhoneNumber);
    final url = 'http://saaqr.site/api/reset';
    try {
      final response = await http.post(url, body: {
        "phone": phone,
      }, headers: {
        //Ae1yIjbfO75e3K670cq8knv6VBBYaj6C0yXfVgmNidOZteaxoAZB68MWpr5j44IXwD5SSVmjF2q8d9VKkn86tUDHQHaRcw06uRm8', //$token',
        // 'Content-Type': 'application/json',
        'Accept': 'application/json'
      });
      print("--------------------------------");
      print(json.decode(response.body));
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        if (responseData["msg"] == "success") {
          // pref.setString(Confirmed, "1");

          return true;
        } else {
          return false;
        }
      }
    } catch (e) {
      print("-----------------error login------------");
      print(e);
      return null;
    }
  }

  Future<bool> sendforgetPasswordVerfiyedCode(String code, String phone) async {
    final url = 'http://saaqr.site/api/activcodeuser';
    try {
      final response = await http.post(url, body: {
        "code": code,
        "phone": phone
      }, headers: {
        // 'Authorization':
        //     'Bearer ${token}', //Ae1yIjbfO75e3K670cq8knv6VBBYaj6C0yXfVgmNidOZteaxoAZB68MWpr5j44IXwD5SSVmjF2q8d9VKkn86tUDHQHaRcw06uRm8', //$token',
        // 'Content-Type': 'application/json',
        'Accept': 'application/json'
      });
      print("--------------------------------");
      print(json.decode(response.body));
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        if (responseData["msg"] == "success") {
          return true;
        } else {
          return false;
        }
      }
    } catch (e) {
      print("-----------------error login------------");
      print(e);
      return null;
    }
  }

  Future<bool> sendverfiyedCode(String code) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    print("in unction");
    // print(message);
    String phone = pref.getString(PhoneNumber);
    final url = 'http://saaqr.site/api/activcodeuser';
    try {
      final response = await http.post(url, body: {
        "code": code,
        "phone": phone
      }, headers: {
        // 'Authorization':
        //     'Bearer ${token}', //Ae1yIjbfO75e3K670cq8knv6VBBYaj6C0yXfVgmNidOZteaxoAZB68MWpr5j44IXwD5SSVmjF2q8d9VKkn86tUDHQHaRcw06uRm8', //$token',
        // 'Content-Type': 'application/json',
        'Accept': 'application/json'
      });
      print("--------------------------------");
      print(json.decode(response.body));
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        if (responseData["msg"] == "success") {
          pref.setString(Isverfied, "1");
          pref.getString(Token);
          _dataUser.setKey(
              {'key': Is_Coworker, 'value': pref.getString(Is_Coworker)});
          _dataUser.setKey({'key': Token, 'value': pref.getString(Token)});
          _dataUser
              .setKey({'key': Isverfied, 'value': pref.getString(Isverfied)});
          _dataUser.setKey(
              {'key': Profile_Image, 'value': pref.getString(Profile_Image)});
          _dataUser.setKey({'key': Name, 'value': pref.getString(Name)});
          _dataUser.setKey(
              {'key': PhoneNumber, 'value': pref.getString(PhoneNumber)});
          _dataUser.setKey({'key': Id, 'value': pref.getString(Id)});
          _dataUser.setKey({'key': ISLOGING, 'value': "true"});
          return true;
        } else {
          return false;
        }
      }
    } catch (e) {
      print("-----------------error login------------");
      print(e);
      return null;
    }
  }

  Future<Settings> getSettings() async {
    // SharedPreferences pref = await SharedPreferences.getInstance();

    final url = 'http://saaqr.site/api/setting';
    try {
      final response = await http.get(url, headers: {
        // 'Authorization':
        //     'Bearer ${token}', //'Bearer Ae1yIjbfO75e3K670cq8knv6VBBYaj6C0yXfVgmNidOZteaxoAZB68MWpr5j44IXwD5SSVmjF2q8d9VKkn86tUDHQHaRcw06uRm8', //$token',
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      });
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        print(responseData);
        if (responseData["msg"] == "success") {
          print("data");

          var data = Settings.fromJson(responseData);
          _dataUser.setKey({'key': TERMS, 'value': data.data[0].conditions});
          _dataUser.setKey({'key': WhoWe, 'value': data.data[0].who});
          return data;
        } else {
          // print(responseData.toString());
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      print("----------------discution function-------------");
      print(e);
      return null;
    }
  }

  Future<bool> sendRequest(
      String serviceid,
      String addressto,
      String latto,
      String longto,
      String addressfrom,
      String latfrom,
      String longfrom) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    // print("in change");
    // print(message);
    String token = pref.getString(Token);
    final url = 'http://saaqr.site/api/addOrder';
    try {
      final response = await http.post(url,
          body: jsonEncode({
            "service_id": serviceid,
            "addressTo": addressto,
            "longTo": latto,
            "latTo": longto,
            "addressFrom": addressfrom,
            "longFrom": longfrom,
            "latFrom": latfrom,
          }),
          headers: {
            'Authorization':
                'Bearer ${token}', //Ae1yIjbfO75e3K670cq8knv6VBBYaj6C0yXfVgmNidOZteaxoAZB68MWpr5j44IXwD5SSVmjF2q8d9VKkn86tUDHQHaRcw06uRm8', //$token',
            'Content-Type': 'application/json',
            'Accept': 'application/json'
          });
      print("--------------------------------");
      print(json.decode(response.body));
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        if (responseData["msg"] == "success") {
          return true;
        } else {
          return false;
        }
      } else {
        return null;
      }
    } catch (e) {
      print("-----------------error login------------");
      print(e);
      return null;
    }
  }

  Future<bool> sendFeedBack(
      String name, String mobileNumber, String message) async {
    // SharedPreferences pref = await SharedPreferences.getInstance();
    // print("in change");
    // print(message);
    // String token = pref.getString(Token);
    final url = 'http://saaqr.site/api/contact';
    try {
      final response = await http.post(url,
          body: jsonEncode(
              {"name": name, "phone": mobileNumber, "message": message}),
          headers: {
            // 'Authorization':
            //     'Bearer ${token}', //Ae1yIjbfO75e3K670cq8knv6VBBYaj6C0yXfVgmNidOZteaxoAZB68MWpr5j44IXwD5SSVmjF2q8d9VKkn86tUDHQHaRcw06uRm8', //$token',
            'Content-Type': 'application/json',
            'Accept': 'application/json'
          });
      print("--------------------------------");
      print(json.decode(response.body));
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        if (responseData["msg"] == "success") {
          return true;
        } else {
          return false;
        }
      } else {
        return null;
      }
    } catch (e) {
      print("-----------------error login------------");
      print(e);
      return null;
    }
  }

  Future<bool> sendrating(int rate, String comment, int id) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    // print("in change");
    // print(message);
    print("mahmoudslladkhsakjdhkjashdkjsahkjdhaskjhd");
    print(id);
    String token = pref.getString(Token);
    print(token);
    final url = 'http://saaqr.site/api/rate';
    try {
      final response = await http.post(url,
          body: jsonEncode(
              {"service_id": id, "rate": rate.toString(), "review": comment}),
          headers: {
            'Authorization':
                'Bearer ${token}', //Ae1yIjbfO75e3K670cq8knv6VBBYaj6C0yXfVgmNidOZteaxoAZB68MWpr5j44IXwD5SSVmjF2q8d9VKkn86tUDHQHaRcw06uRm8', //$token',
            'Content-Type': 'application/json',
            'Accept': 'application/json'
          });
      print("--------------------------------");
      print(json.decode(response.body));
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        if (responseData["msg"] == "success") {
          return true;
        } else {
          return false;
        }
      } else {
        return null;
      }
    } catch (e) {
      print("-----------------error login------------");
      print(e);
      return null;
    }
  }

  // Future<void> save Data(ProfoileModel data) async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   pref.setString(Token, data.data.apiToken.toString());
  //   pref.setString(Is_Coworker, data.data.isProvider.toString());
  //   pref.setString(Isverfied, data.data.active.toString());
  //   pref.setString(Profile_Image, data.data.imageProfile.toString());
  //   pref.setString(Name, data.data.name.toString());
  //   pref.setString(PhoneNumber, data.data.phone.toString());
  // }
}
