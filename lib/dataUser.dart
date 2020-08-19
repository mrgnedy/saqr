import 'dart:async';

class DataUser{
  dynamic _data={};
  final StreamController<dynamic> dataUserController = StreamController<dynamic>();
  
  Stream get getStateChange => dataUserController.stream;

  static final DataUser instance = DataUser();
  dynamic getKey(String key)=> (_data[key]!=null?_data[key]:null);
 
  setKey(Map<String,dynamic> data ) {
   _data[data['key']] = data['value'];
   dataUserController.add(_data);
 }

}
