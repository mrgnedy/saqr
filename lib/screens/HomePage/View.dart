import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:saqr/ApiRequestes.dart';
import 'package:saqr/ServiceProvider/serviceProvidersPage.dart';
import 'package:saqr/Utillity/ApiUtillity.dart';
import 'package:saqr/models/categoryModel.dart';
import 'package:saqr/screens/LoginPage/View.dart';
import 'package:saqr/screens/NotifcationPage/View.dart';
import 'package:saqr/screens/SubCategory.dart/View1.dart';
import 'package:saqr/screens/SubCategory.dart/View2.dart';
import 'package:saqr/sharedUi/home_cell.dart';
import 'package:saqr/widgets/Drawer.dart';
import 'package:saqr/widgets/commnDesgin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '../../dataUser.dart';
import '../../notifcationClass.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  CategoryModel _data = new CategoryModel();
  ApiRequests _apiRequests = new ApiRequests();
  Animation _containerRadiusAnimation,
      _containerSizeAnimation,
      _containerColorAnimation;
  AnimationController _containerAnimationController;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  DataUser _dataUser = DataUser.instance;
  bool _isLoading = true;
  NotifcationClss _notifcationClss = new NotifcationClss();
  bool loading = false;
  @override
  void initState() {
    // TODO: implement initState
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
        ColorTween(begin: Colors.white, end: Colors.white).animate(
            CurvedAnimation(
                curve: Curves.ease, parent: _containerAnimationController));

    _containerAnimationController.forward();
    if (_dataUser.getKey(ISLOGING).toString() == "null") {
      print("----------------notLogin-------------");
    } else {
      print("----------------Login-------------");
      _notifcationClss.initalvalues();
    }

    _getcategory();
  }

  double height;
  @override
  void setState(fn) {
    // TODO: implement setState
    if (this.mounted) super.setState(fn);
  }

  @override
  void dispose() {
    super.dispose();
    _containerAnimationController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        appBar: _appBar(),
        body: Center(
            child: AnimatedBuilder(
                animation: _containerAnimationController,
                builder: (context, index) {
                  return _body();
                })),
        drawer: drawer(context),
      ),
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
            mainText("الخدمات"),
            Center(
              child: _isLoading
                  ? LOADING()
                  : _data == null
                      ? NoInterNetConnection()
                      : Wrap(
                          children: List.generate(_data.data.length, (idx) {
                          return InkWell(
                            onTap: () {
                              if (_data.data[idx].isSelect == 2) {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return SubCategory1(data: _data.data[idx]);
                                }));
                              } else if (_data.data[idx].isSelect == 1) {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return SubCategory2(data: _data.data[idx]);
                                }));
                              } else {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return ServiesProvidersPage(
                                      categoryid: _data.data[idx].id,
                                      subcategoryid: null,
                                      check: 0,
                                      price: _data.data[idx].price);
                                }));
                              }
                            },
                            child: HomeCell(
                              name: _data.data[idx].name,
                              image:
                                  ImageCategoryBaseUrl + _data.data[idx].image,
                            ),
                          );
                        })),
            ),
          ],
        ),
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
            color: Colors.black,
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
        child: _dataUser.getKey(ISLOGING).toString() == "true"
            ? Container(
                color: Colors.black,
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
              )
            : Container(),
      ),
    );
  }

  _getcategory() {
    _apiRequests.getCatergory().then((value) {
      print(value);
      setState(() {
        _data = value;
        _isLoading = false;
      });
      _apiRequests.getSettings().then((value2) {
        print("settings");
        print(value2);
      });
    });
  }

  List<String> names = [
    "النقل",
    "معدات  ثقيلة",
    "نقل جماعي",
    "ليموزين",
    "حاويات نظافة",
    "السطحات",
    "مباه التحلية",
    "منازل",
    "صرف صحي"
  ];
  List<String> images = [
    "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcT9TX-4w3v1astfbWXrQOExgkLC2MXJJq8IPotm4RlDsIc1Asjk&usqp=CAU",
    "https://a7.pnghunt.com/preview/100/850/549/mobile-crane-heavy-machinery-tadano-limited-mode-of-transport-crane.jpg",
    "https://www.emaratalyoum.com/polopoly_fs/1.380657.1462697555!/image/image.jpg",
    "https://argaamplus.s3.amazonaws.com/1cd594d5-711c-4002-ba42-4588d398f269.jpg",
    "https://lh3.googleusercontent.com/proxy/CwVUZNikY111Fud8UA29Tf_pjVA9jx945VppByugPRa5vrpwAMIOol4bc7PVOVBY5T2xSdlC5CKzfpYS51R_6zeXnqV_RKl8gn8mOaxuq1bJ1HKQwzCgjKEY4ZQv",
    "https://www.st7aa.com/wp-content/uploads/2018/09/4h9-c5aQ54922L.jpg",
    "https://alborsaanews.com/app/uploads/2018/04/1528024561_281_65535_rrrrrr.jpg",
    "https://i.ytimg.com/vi/cvKL_hXcXNI/maxresdefault.jpg",
    "https://lh3.googleusercontent.com/proxy/rRTbi6AvbWn8e-EUA9tv2Q4qNz6P1Xy9ajZZiH1LMZ2M0W5dcPmX9tFwzUqa6Os4Z05kHGSUvZv5_1l4Pg1g526IBJ6cN0fW0CLSvjmrhQkqD1lbJfOPDuU1vqbVji6JlDdsSw"
  ];
  Future<bool> _onBackPressed() {
    return showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return loading
              ? Center(
                  child: CupertinoActivityIndicator(
                    animating: true,
                    radius: 17,
                  ),
                )
              : CupertinoAlertDialog(
                  content: new Text("هل متاكد من الخروج ؟",
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'thins',
                          color: Colors.black)),
                  actions: <Widget>[
                    new FlatButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: new Text(
                        "لا",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    new FlatButton(
                      onPressed: () async {
                        SystemChannels.platform
                            .invokeMethod('SystemNavigator.pop');
//                       setState(() {
//                         loading = true;
//                       });
//    _apiRequests.logout().then((value) {
//     setState(() {
//                         loading = false;
//                       });
// if(value==true){

//                   Navigator.pushAndRemoveUntil(context,
//                       MaterialPageRoute(builder: (context) {
//                     return LoginPage();
//                   }), (Route<dynamic> route) => false);
// }else{
// showInSnackBar("لا يمكن الخروج",Colors.red,_scaffoldKey);
// }

                        //  });
                      },
                      //  SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
                      child: new Text(
                        "نعم",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                );
        });
  }
}
