import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:saqr/ApiRequestes.dart';
import 'package:saqr/Utillity/ApiUtillity.dart';
import 'package:saqr/models/categoryModel.dart';
import 'package:saqr/screens/HomePage/View.dart';
import 'package:saqr/screens/NotifcationPage/View.dart';
import 'package:saqr/widgets/Drawer.dart';
import 'package:saqr/widgets/commnDesgin.dart';

class AddService extends StatefulWidget {
  final Data data;
  final int catid;
  final int price;

  AddService({this.data, this.catid, this.price});

  @override
  _AddServiceState createState() => _AddServiceState();
}

class _AddServiceState extends State<AddService>  with TickerProviderStateMixin{
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
    Animation _containerRadiusAnimation,
      _containerSizeAnimation,
      _containerColorAnimation;
  AnimationController _containerAnimationController;
  ApiRequests _apiRequests = new ApiRequests();
  TextEditingController _profisstion = new TextEditingController();
  double w;
  double h;
  String _idString = "صورة الهوية";
  String _fronCarString = "صورة المركبة من الامام";
  String _backCarString = "صورة المركبة من الخلف";
  String _licensString = "صورة الرخصة";
  File _idImage;
  File _frontCar;
  File _backCar;
  File _liceneImage;
  int _catId;
  int _subCatId;
  double height;
  TextEditingController _carNumber;
  List<String> _locations = new List<String>();
  List<String>rofitions = new List<String>();
  List<int> _ids = new List<int>();
  bool _isLoading = false;
  List<Asset> images = List<Asset>();
  @override
  void dispose() {
    // TODO: implement dispose
     _containerAnimationController?.dispose();
    _carNumber.dispose();
    super.dispose();
  }

  @override
  void initState() {
      _containerAnimationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 3500));

    _containerRadiusAnimation = BorderRadiusTween(
            begin: BorderRadius.circular(100.0),
            end: BorderRadius.circular(0.0))
        .animate(CurvedAnimation(
            curve: Curves.slowMiddle, parent: _containerAnimationController));

    _containerSizeAnimation = Tween(begin: 0.0, end: 2.0).animate(
        CurvedAnimation(
            curve: Curves.ease, parent: _containerAnimationController));

    _containerColorAnimation =
        ColorTween(begin: Colors.teal[700], end: Colors.white).animate(
            CurvedAnimation(
                curve: Curves.ease, parent: _containerAnimationController));

    _containerAnimationController.forward();
    // TODO: implement initState
    _carNumber = new TextEditingController();
    if (widget.data != null) {
      _catId = widget.data.id;
      for (int i = 0; i < widget.data.subCategories.length; i++) {
        _locations.add(widget.data.subCategories[i].name);
        _ids.add(widget.data.subCategories[i].id);
      }
    } else {
      _catId = widget.catid;
    }

    super.initState();
  }

  String lable_servic_name = "اسم الخدمة";
  String lable_service_location = "الموقع";
  String lable_service_profition="المهنة";
  double lat;
  double long;

// Option 2

  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
        height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldKey,
      appBar: _appBar(),
      body: Center(child: AnimatedBuilder(
          
          
          
           animation: _containerAnimationController,
            builder: (context, index) {
              
              return  _body();})),
      drawer: drawer(context),
      backgroundColor: Colors.white,
    );
  }

  Widget _body() {
    return Container(
           width: _containerSizeAnimation.value * height,
                height: _containerSizeAnimation.value * height,
                decoration: BoxDecoration(
                    borderRadius: _containerRadiusAnimation.value,
                    color: _containerColorAnimation.value),
        padding: EdgeInsets.all(8.0),
        alignment: Alignment.topRight,
        child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
              mainText("إضافة خدمة"),

              ////price for ta7lea because itsprice is constant
              widget.price != null ? _service_price() : Container(),
               ////check if choose or 
              widget.data != null ? _servic_name() : Container(),
                ////check if it house service becouse house service should enter profisstion
              widget.catid==26?_profissonTextFaild():Container(),

              _divider(),
              _servic_location(),
              _divider(),
             _servic_Id(),
          widget.catid==26?Container() :     _divider(),
            widget.catid==26?Container() :   _servic_Licence(),
            widget.catid==26?Container() :   _divider(),
             widget.catid==26?Container() :  _service_CarNumber(),
            widget.catid==26?Container() :   _divider(),
            widget.catid==26?Container() :   _servic_FrontCar(),
           widget.catid==26?Container() :    _divider(),
          widget.catid==26?Container() :     _servic_BackCar(),
              // _divider(),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  "  : صور اضافية",
                  style: TextStyle(
                      color: Colors.grey[GREYDEGREE],
                      fontFamily: "black",
                      fontSize: 20),
                ),
              ),
              _addontherImage(),
              _divider(),

              _isLoading
                  ? LOADING()
                  : InkWell(
                      onTap: () {
                        _vaildate();
                      },
                      child: Center(child: commnBtnDesign(" إضافة خدمة  ", w))),
            ])));
  }

  Widget _divider() {
    return SizedBox(
      height: 20,
    );
  }
 Widget _profissionTextFaild() {
    return Container(
      width: w > 400 ? w * .7 : 400 * .7,
      child: TextFormField(
        controller: _profisstion,
        textAlign: TextAlign.right,
    
        decoration: _textFormInputDecoration2("المهنة"),
      ),
    );
  }
  
  InputDecoration _textFormInputDecoration2(String hinttext) {
    return InputDecoration(
      contentPadding: EdgeInsets.all(8),
      hintText: hinttext,
   
      //  prefixStyle: TextStyle(color: Colors.grey),
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

  _service_price() {
    return Center(
        child: Text("ريال  ${widget.price.toString()} سعر الخدمة موحد و هو",
            style: TextStyle(
              color: Colors.black,
              fontFamily: "thin",
              fontSize: 18,
            )));
  }

  Widget _servic_Id() {
    return Center(
        child: Container(
      width: MediaQuery.of(context).size.width > 400
          ? MediaQuery.of(context).size.width * .8
          : 400 * .8,
      height: 50,
      child: TextFormField(
        textAlign: TextAlign.right,
        readOnly: true,
        decoration: _textFormInputDecoration(
            _idString,
            IconButton(
                icon: Icon(Icons.camera_alt),
                onPressed: () {
                  _dilog(_idString, "صورة الهوية", _idImage, 0);
                }),
            null),
      ),
    ));
  }

  Widget _servic_Licence() {
    return Center(
        child: Container(
      width: MediaQuery.of(context).size.width > 400
          ? MediaQuery.of(context).size.width * .8
          : 400 * .8,
      height: 50,
      child: TextFormField(
        textAlign: TextAlign.right,
        readOnly: true,
        decoration: _textFormInputDecoration(
            _licensString,
            IconButton(
                icon: Icon(Icons.camera_alt),
                onPressed: () {
                  _dilog(_licensString, "صورة الرخصة", _liceneImage, 1);
                }),
            null),
      ),
    ));
  }

  Widget _servic_FrontCar() {
    return Center(
        child: Container(
      width: MediaQuery.of(context).size.width > 400
          ? MediaQuery.of(context).size.width * .8
          : 400 * .8,
      height: 50,
      child: TextFormField(
        textAlign: TextAlign.right,
        readOnly: true,
        decoration: _textFormInputDecoration(
            _fronCarString,
            IconButton(
                icon: Icon(Icons.camera_alt),
                onPressed: () {
                  _dilog(
                      _fronCarString, "صورة المركبة من الامام", _frontCar, 2);
                }),
            null),
      ),
    ));
  }

  Widget _servic_BackCar() {
    return Center(
        child: Container(
      width: MediaQuery.of(context).size.width > 400
          ? MediaQuery.of(context).size.width * .8
          : 400 * .8,
      height: 50,
      child: TextFormField(
        textAlign: TextAlign.right,
        readOnly: true,
        decoration: _textFormInputDecoration(
            _backCarString,
            IconButton(
                icon: Icon(Icons.camera_alt),
                onPressed: () {
                  _dilog(_backCarString, "صورة المركبة من الخلف", _backCar, 3);
                }),
            null),
      ),
    ));
  }

  _dilog(String lable, String value, File file, int index) {
    showDialog(
      context: context,
      child: new SimpleDialog(
        backgroundColor: Colors.grey[800],
        title: Align(
            alignment: Alignment.center,
            child: new Text(
              value,
              style: TextStyle(color: Colors.white, fontFamily: "thin"),
            )),
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 45,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey[200]),
                child: new SimpleDialogOption(
                  child: new Text("كاميرا",
                      style: TextStyle(
                          color: Colors.grey[800],
                          fontFamily: "thin",
                          height: 2)),
                  onPressed: () {
                    Navigator.of(context).pop();

                    getImage(ImageSource.camera, file, index);
                  },
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Container(
                height: 45,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey[200]),
                child: new SimpleDialogOption(
                  child: new Text("ستوديو",
                      style: TextStyle(
                          color: Colors.grey[800],
                          fontFamily: "thin",
                          height: 2)),
                  onPressed: () {
                    Navigator.of(context).pop();

                    getImage(ImageSource.gallery, file, index);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future getImage(ImageSource imageSource, File file, int index) async {
    //      var image = await ImagePicker.pickVideo(source: ImageSource.camera);
    var image = await ImagePicker.pickImage(
        source: imageSource, maxWidth: 1024, maxHeight: 683, imageQuality: 100);
    if (image != null) {
      setState(() {
        // file = image;
        if (index == 0) {
          print("id image");
          print(file == null);
          _idImage = image;
          _idString = image.path.split('/').last;
        } else if (index == 1) {
          _liceneImage = image;
          _licensString = image.path.split('/').last;
        } else if (index == 2) {
          _fronCarString = image.path.split('/').last;
          _frontCar = image;
        } else if (index == 3) {
          _backCar = image;
          _backCarString = image.path.split('/').last;
        }
      });
    }
  }

  Widget _servic_location() {
    return Center(
        child: Container(
      width: MediaQuery.of(context).size.width > 400
          ? MediaQuery.of(context).size.width * .8
          : 400 * .8,
      height: 50,
      child: TextFormField(
        textAlign: TextAlign.right,
        readOnly: true,
        decoration: _textFormInputDecoration(
            lable_service_location,
            IconButton(
                icon: Icon(Icons.location_on),
                onPressed: () async {
                  LocationResult result = await showLocationPicker(
                      context, "AIzaSyBQFncM9uaq-G4j0fb3nMWTRdbzwODGHzM",
                      automaticallyAnimateToCurrentLocation: true,
                      myLocationButtonEnabled: true,
                      layersButtonEnabled: true,
                      requiredGPS: true);
                  print(result.address);
                  setState(() {
                    lable_service_location = result.address.toString();
                    lat = result.latLng.latitude;
                    long = result.latLng.longitude;
                  });
                }),
            null),
      ),
    ));
  }

  Widget _appBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,automaticallyImplyLeading: false,
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
                    Icons.sort,
                    color: Colors.white,
                    size: 25,
                  ),
                  onPressed: () {
                    _scaffoldKey.currentState.openDrawer();
                  },
                ),
              ),
            ),
          ),
        )
      ],
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          color: Colors.grey[GREYDEGREE],
          child: IconButton(
            color: Colors.white,
            icon: Icon(Icons.notifications),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return NotifcationPage();
              }));
            },
          ),
        ),
      ),
    );
  }
// Widget _profisstion() {
//     return Center(
//       child: Container(
//         width: MediaQuery.of(context).size.width > 400
//             ? MediaQuery.of(context).size.width * .8
//             : 400 * .8,
//         height: 50,
//         child: TextFormField(
//           textAlign: TextAlign.right,
//           readOnly: true,
//           decoration: _textFormInputDecoration(
//               lable_service_profition,
//               PopupMenuButton<String>(
//                 onSelected: choiceAction2,
//                 icon: Icon(
//                   Icons.arrow_drop_down,
//                   color: Colors.grey,
//                   size: 40,
//                 ),
//                 itemBuilder: (BuildContext context) {
//                   return _locations.map((String choice) {
//                     return PopupMenuItem<String>(
//                       value: choice,
//                       child: Column(
//                         children: <Widget>[
//                           Text(
//                             choice,
//                             textAlign: TextAlign.right,
//                             style: TextStyle(color: Colors.black),
//                           ),
//                           Divider()
//                         ],
//                       ),
//                     );
//                   }).toList();
//                 },
//               ),
//               () {}),
//         ),
//       ),
//     );
//   }
  Widget _servic_name() {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width > 400
            ? MediaQuery.of(context).size.width * .8
            : 400 * .8,
        height: 50,
        child: TextFormField(
          textAlign: TextAlign.right,
          readOnly: true,
          decoration: _textFormInputDecoration(
              lable_servic_name,
              PopupMenuButton<String>(
                onSelected: choiceAction,
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: Colors.grey,
                  size: 40,
                ),
                itemBuilder: (BuildContext context) {
                  return _locations.map((String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Column(
                        children: <Widget>[
                          Text(
                            choice,
                            textAlign: TextAlign.right,
                            style: TextStyle(color: Colors.black),
                          ),
                          Divider()
                        ],
                      ),
                    );
                  }).toList();
                },
              ),
              () {}),
        ),
      ),
    );
  }
  Widget _profissonTextFaild() {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width > 400
            ? MediaQuery.of(context).size.width * .8
            : 400 * .8,
        height: 50,
        child: TextFormField(
          textAlign: TextAlign.right,
          controller: _profisstion,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(8),
            hintText: "المهنة",
            hintStyle: TextStyle(fontFamily: "thin", color: Colors.grey),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 1.5),
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 1.5),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
    );
  }
  Widget _service_CarNumber() {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width > 400
            ? MediaQuery.of(context).size.width * .8
            : 400 * .8,
        height: 50,
        child: TextFormField(
          textAlign: TextAlign.right,
          controller: _carNumber,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(8),
            hintText: "رقم اللوحة",
            hintStyle: TextStyle(fontFamily: "thin", color: Colors.grey),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 1.5),
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 1.5),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _textFormInputDecoration(
      String hinttext, Widget icon, Function fun) {
    return InputDecoration(
      contentPadding: EdgeInsets.all(8),
      hintText: hinttext,
      prefixIcon: icon,
      hintStyle: TextStyle(fontFamily: "thin", color: Colors.grey),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey, width: 1.5),
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey, width: 1.5),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  void choiceAction(String value) {
    setState(() {
      lable_servic_name = value;
      _subCatId = _ids.elementAt(_locations.indexOf(value));
    });
  }
  void choiceAction2(String value) {
    setState(() {
      lable_service_profition = value;
      // _subCatId = _ids.elementAt(_locations.indexOf(value));
    });
  }
/*
File _idImage;
  File _frontCar;
  File _backCar;
  File _liceneImage;
  int _catId;
  int _subCatId;
*/
  void _vaildate() {
    if (widget.data != null) if (_subCatId == null) {
      showInSnackBar(
          "رجاء قم بادخل اسم الخدمة", Colors.grey[GREYDEGREE], _scaffoldKey);
      return;
    }

    if (lat == null || long == null || lable_service_location == "الموقع") {
      showInSnackBar(
          "رجاء قم بادخل الموقع", Colors.grey[GREYDEGREE], _scaffoldKey);
      return;
    }
if( widget.catid!=26){
    if (_idImage == null) {
      showInSnackBar(
          "رجاء قم بادخل صورة الهوية", Colors.grey[GREYDEGREE], _scaffoldKey);
      return;
    } else if (_liceneImage == null) {
      showInSnackBar(
          "رجاء قم بادخل صورة الرخصة", Colors.grey[GREYDEGREE], _scaffoldKey);
      return;
    } else if (_carNumber.text.isEmpty) {
      showInSnackBar(
          "رجاء قم بادخل رقم اللوحة", Colors.grey[GREYDEGREE], _scaffoldKey);
      return;
    } else if (_carNumber.text.length < 4) {
      showInSnackBar(" رجاء قم بادخل رقم اللوحة بطريقة صحيحة",
          Colors.grey[GREYDEGREE], _scaffoldKey);
      return;
    } else if (_frontCar == null) {
      showInSnackBar("رجاء قم بادخل صورة المركبة من الامام",
          Colors.grey[GREYDEGREE], _scaffoldKey);
      return;
    } else if (_backCar == null) {
      showInSnackBar("رجاء قم بادخل صورة المركبة من الخلف",
          Colors.grey[GREYDEGREE], _scaffoldKey);
      return;
    } 
}

    
     if (images.length == 0) {
      showInSnackBar("رجاء قم بادخل صورة  اضافية علي الاقل صورة",
          Colors.grey[GREYDEGREE], _scaffoldKey);
      return;
    } else {
      setState(() {
        _isLoading = true;
      });
      _apiRequests
          .addServicefun(
              lable_service_location,
              lat,
              long,
              _idImage,
              _liceneImage,
              _frontCar,
              _backCar,
              _carNumber.text,
              _catId,
              _subCatId,
              images,_profisstion.text)
          .then((value) {
        print("----------------------valeie-------------------");
        print(value);
        setState(() {
          _isLoading = false;
        });
        if (value == true) {
               showInSnackBar("تم إضافة خدمتك بنجاح", Colors.green, _scaffoldKey);
          // Navigator.pushAndRemoveUntil(context,
          //     MaterialPageRoute(builder: (context) {
          //   return HomePage();
          // }), (Route<dynamic> route) => false);
        } else if (value == false) {
          showInSnackBar("حدث خطا ما", Colors.red, _scaffoldKey);
        } else {
          showInSnackBar(
              "تاكد من الاتصال بالانترنت ", Colors.orange, _scaffoldKey);
        }
      });
    }
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = List<Asset>();
    String error = 'No Error Dectected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 8,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "صقر"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "صقر",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      images = resultList;
      // _error = error;
    });
  }

  _addontherImage() {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12),
      child: Wrap(
        textDirection: TextDirection.rtl,
        //  alignment: WrapAlignment.end,
        children: List.generate(images.length + 1, (idx) {
          if (images.length == 0 && idx == 0) {
            return InkWell(
              onTap: () {
                loadAssets();
              },
              child: DottedBorder(
                borderType: BorderType.Circle,
                color: Colors.grey[GREYDEGREE],
                child: Container(
                    width: 70,
                    height: 70,
                    // color: Colors.blue,
                    margin: EdgeInsets.only(right: 6, left: 6, bottom: 12),
                    child: Container(
                      padding: EdgeInsets.only(top: 8),
                      child: ClipOval(
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.grey[GREYDEGREE],
                          size: 50,
                        ),
                      ),
                    )),
              ),
            );
          } else if (idx == 0) {
            return InkWell(
              onTap: () {
                loadAssets();
              },
              child: DottedBorder(
                borderType: BorderType.Circle,
                color: Colors.grey[GREYDEGREE],
                child: Container(
                    width: 70,
                    height: 70,
                    // color: Colors.blue,
                    margin: EdgeInsets.only(right: 6, left: 6, bottom: 12),
                    child: Container(
                      padding: EdgeInsets.only(top: 8),
                      child: ClipOval(
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.grey[GREYDEGREE],
                          size: 50,
                        ),
                      ),
                    )),
              ),
            );
          } else {
            return Container(
                // color: Colors.red,
                width: 85,
                height: 85,
                margin: EdgeInsets.only(right: 6, left: 6, bottom: 12),
                // decoration: BoxDecoration(
                //   borderRadius:
                //       BorderRadius.circular(12),
                // ),
                child: ClipOval(
                  child: AssetThumb(
                    asset: images[idx - 1],
                    width: 100,
                    height: 100,
                  ),
                ));
          }
        }),
      ),
    );
  }
}
