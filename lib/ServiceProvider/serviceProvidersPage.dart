import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:saqr/ApiRequestes.dart';
import 'package:saqr/ServiceProvider/serviceProviderDetails.dart';
import 'package:saqr/Utillity/ApiUtillity.dart';
import 'package:saqr/dataUser.dart';
import 'package:saqr/models/serviceprovider.dart';
import 'package:saqr/screens/AddService/addservice.dart';
import 'package:saqr/screens/NotifcationPage/View.dart';
import 'package:saqr/sharedUi/MapSecreenSearch.dart';
import 'package:saqr/sharedUi/maptest/home_page.dart';
import 'package:saqr/sharedUi/providerServiceCell.dart';
import 'package:saqr/widgets/commnDesgin.dart';

class ServiesProvidersPage extends StatefulWidget {
  final int categoryid;
  final int subcategoryid;
  final int check;
  final int price;
  ServiesProvidersPage(
      {this.categoryid, this.subcategoryid, this.check, this.price});
  @override
  _ServiesProvidersPageState createState() => _ServiesProvidersPageState();
}

class _ServiesProvidersPageState extends State<ServiesProvidersPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  ServiceProviderModel _data = new ServiceProviderModel();
  ServiceProviderModel _searchData = new ServiceProviderModel();
  ApiRequests _apiRequests = new ApiRequests();
  bool _isLoading = true;
  DataUser _dataUser = DataUser.instance;
  double lat;
  double long;
TextEditingController _searchController = new TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    _getprovidersservices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        appBar: _appBar(),
        body: _body(),
        floatingActionButton: _floatingActionBar());
  }

  Widget _body() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.all(8.0),
      alignment: Alignment.topRight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          mainText("مقدمين الخدمة"),
          Center(child: _searchTextFormFaild()),
          _isLoading
              ? LOADING()
              : _data == null ? NoInterNetConnection() : _servicProvidersList(),
        ],
      ),
    );
  }

  _servicProvidersList() {
    print("user id ");
    print(_dataUser.getKey(Id).toString());
    return _data.data.length == 0
        ? Center(child: NoDataFound())
        : Expanded(
            child: ListView.builder(
                itemCount: _data.data.length,
                shrinkWrap: true,
                itemBuilder: (context, idx) {
                  print(_data.data[idx].userId.toString());
                  print(_dataUser.getKey(Id).toString());
                  print(_data.data[idx].userId.toString() ==
                      _dataUser.getKey(Id).toString());
                  print("---------------------");
                  if (_data.data[idx].userId.toString() ==
                      _dataUser.getKey(Id).toString()) {
                    return Container();
                  } else {
                    return _dataWiget(_data.data[idx]);
                  }
                }),
          );
  }

  Widget _searchTextFormFaild() {
    return Container(
      width: MediaQuery.of(context).size.width > 400
          ? MediaQuery.of(context).size.width * .82
          : 400 * .82,
      child: TextFormField(
        textAlign: TextAlign.right,
        controller: _searchController,
        decoration: _textFormInputDecoration(widget.categoryid==26?"المهنة":"الاسم"),
      ),
    );
  }

  _floatingActionBar() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: widget.check != 0
            ? Container()
            : InkWell(
                onTap: () {
                  _dataUser.getKey(ISLOGING).toString() == "null"
                      ? drawShowDialog(context)
                      : Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                          return AddService(
                              catid: widget.categoryid, price: widget.price);
                        }));
               
                },
                child: FloatingActionButton(
                  onPressed: null,
                  child: Icon(
                    FontAwesomeIcons.plus,
                    color: Colors.white,
                    size: 30,
                  ),
                  backgroundColor: Colors.teal[700],
                ),
              ),
      ),
    );
  }

  InputDecoration _textFormInputDecoration(String hinttext) {
    return InputDecoration(
      prefixIcon: _data == null
          ? Container()
          : IconButton(
              icon: Icon(Icons.search),
              onPressed: () async {
            
                _getSearch();
              },
            ),
      contentPadding: EdgeInsets.all(8),
      hintText: hinttext,
      hintStyle: TextStyle(fontFamily: "thin", color: Colors.grey),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey, width: 1.5),
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey, width: 1.5),
        borderRadius: BorderRadius.circular(12),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red, width: 1.5),
        borderRadius: BorderRadius.circular(12),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red, width: 1.5),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  Widget _appBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      automaticallyImplyLeading: false,
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 40,
            color: Colors.grey[GREYDEGREE],
            child: Center(
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 25,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    // _scaffoldKey.currentState.openDrawer();
                  },
                ),
              ),
            ),
          ),
        )
      ],
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: _dataUser.getKey(ISLOGING).toString() == "null"
            ? Container()
            : Container(
                color: Colors.grey[GREYDEGREE],
                child: IconButton(
                  color: Colors.white,
                  icon: Icon(Icons.notifications),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return NotifcationPage();
                    }));
                  },
                ),
              ),
      ),
    );
  }

  _dataWiget(Data data) {
    return InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return ServiceProviderDetails(data: data);
          }));
        },
        child: ProviderServiceCell(data: data));
  }

  _getprovidersservices() {
    _apiRequests
        .getProvidersServices(
            widget.categoryid.toString(), widget.subcategoryid.toString())
        .then((value) {
      print(value);
      setState(() {
        _data = value;
        _isLoading = false;
      });
    });
  }

  _getSearch() {
    if(_searchController.text.isEmpty){
           showInSnackBar(
              widget.categoryid==26?"رجاء ادخل المهنة": "رجاء ادخل الاسم", Colors.orange, _scaffoldKey);
              return ;
    }
    _apiRequests.getsearchData(_searchController.text,widget.categoryid,widget.subcategoryid).then((value) {
      print(value);
      setState(() {
        _searchData = value;
        _isLoading = false;
        if (value == null) {
          showInSnackBar(
              "تاكد من الاتصال بالانترنت ", Colors.orange, _scaffoldKey);
          return;
        } else if (value.data.length == 0) {
          showInSnackBar(" لا يوجد مزودين خدمة ", Colors.green, _scaffoldKey);
          return;
        } else {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return Home__Page(data: value.data);
          }));
        }
      });
    });
  }
}
