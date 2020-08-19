import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:saqr/ApiRequestes.dart';
import 'package:saqr/ServiceProvider/reviewsPage.dart';
import 'package:saqr/Utillity/ApiUtillity.dart';
import 'package:saqr/models/serviceprovider.dart';
import 'package:saqr/screens/HomePage/View.dart';
import 'package:saqr/screens/NotifcationPage/View.dart';
import 'package:saqr/sharedUi/MapScreen.dart';
import 'package:saqr/widgets/commnDesgin.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:url_launcher/url_launcher.dart';
import '../dataUser.dart';

class ServiceProviderDetails extends StatefulWidget {
  final Data data;
  ServiceProviderDetails({this.data});

  @override
  _ServiceProviderDetailsState createState() => _ServiceProviderDetailsState();
}

class _ServiceProviderDetailsState extends State<ServiceProviderDetails> {
  DataUser _dataUser = DataUser.instance;
  bool _isLoading = false;
  String phoneNumber;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  ApiRequests _apiRequests = new ApiRequests();
  int isavelable = 0;
  int isnotavelable = 0;
  String _comment;
  double rating = 0.0;
  ////////////////
  ///
  String lable_service_location_start = "نقطة البداية";
  String lable_service_location_end = " نقطة النهاية";
  double latstart;
  double longstart;
  double latend;
  double longend;

  @override
  void initState() {
    // TODO: implement initState
    if (widget.data.isAvailable == 1) {
      setState(() {
        isavelable = 1;
      });
    } else {
      setState(() {
        isnotavelable = 1;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: _appBar(),
      body: _body(),
    );
  }

  Widget _body() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.all(8.0),
      alignment: Alignment.topRight,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            mainText("تفاصيل مقدم الخدمة"),
            _servicProviderDetails(),
            _isLoading
                ? LOADING()
                : InkWell(
                    onTap: () {
                      _dataUser.getKey(ISLOGING).toString() == "null"
                          ? drawShowDialog2(context)
                          : _vaildate();
                    },
                    child: Center(
                        child: commnBtnDesign(
                            "إرسال طلب", MediaQuery.of(context).size.width))),
                            SizedBox(height: 20,),
            _isLoading
                ? LOADING()
                : InkWell(
                    onTap: () {
                      _showRatingDialog(context);
                    },
                    child: Center(
                        child: commnBtnDesign(
                            "تقييم", MediaQuery.of(context).size.width)),
                  )
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

  _servicProviderDetails() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: <Widget>[
          _providerImage(),
          _lable("  :  اسم مقدم الخدمة", widget.data.userName ?? "-", context),
          
          SingleChildScrollView(
            
            scrollDirection: Axis.horizontal,
            child:_lable("  : رقم الجوال", widget.data.phone ?? "-", context),),
          _lable("  : الخدمات", widget.data.subCatName ?? widget.data.catName,
              context),
          _ratingWedget(),
          widget.data.job == null || widget.data.job.toString().length == 0
              ? Container()
              : _lable("  : المهنة", widget.data.job.toString(), context),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              commnBtnDesignavelable("متاح", MediaQuery.of(context).size.width,
                  isavelable == 1 ? Colors.teal[400] : Colors.white),
              commnBtnDesignavelable(
                  "غير متاح",
                  MediaQuery.of(context).size.width,
                  isnotavelable == 1 ? Colors.grey[400] : Colors.white),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Wrap(
              children: List.generate(widget.data.imgs.length, (idx) {
            return _carImage(widget.data.imgs[idx].image);
          })),
          widget.data.categoryId == 16 ||
                  widget.data.categoryId == 20 ||
                  widget.data.categoryId == 29
              ? SizedBox(
                  height: 15,
                )
              : Container(),
          widget.data.categoryId == 16 ||
                  widget.data.categoryId == 20 ||
                  widget.data.categoryId == 29
              ? _servic_location_start()
              : Container(),
          widget.data.categoryId == 16 ||
                  widget.data.categoryId == 20 ||
                  widget.data.categoryId == 29
              ? SizedBox(
                  height: 15,
                )
              : Container(),
          widget.data.categoryId == 16 ||
                  widget.data.categoryId == 20 ||
                  widget.data.categoryId == 29
              ? _servic_location_end()
              : Container(),
          widget.data.categoryId == 16 ||
                  widget.data.categoryId == 20 ||
                  widget.data.categoryId == 29
              ? SizedBox(
                  height: 15,
                )
              : Container(),
          _location("  : الموقع", widget.data.address ?? "-", context),
        ],
      ),
    );
  }

  _carImage(String url) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: CachedNetworkImage(
          fit: BoxFit.fill,
          imageUrl: UserDeetailsImagesURL + url,
          placeholder: (context, url) => LOADING(),
          height: MediaQuery.of(context).size.width * .2,
          width: MediaQuery.of(context).size.width * .2,
          errorWidget: (context, url, error) => Icon(
            Icons.error,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  _providerImage() {
    return Center(
      child: ClipOval(
        child: CachedNetworkImage(
          fit: BoxFit.fill,
          imageUrl: ImageUserUrl + widget.data.imageProfile,
          placeholder: (context, url) => LOADING(),
          height: MediaQuery.of(context).size.width * .3,
          width: MediaQuery.of(context).size.width * .3,
          errorWidget: (context, url, error) => Icon(
            Icons.error,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  _location(String lable, String value, BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.location_on),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return MapScreeen(
                  lat: widget.data.lat,
                  long: widget.data.long,
                  name: widget.data.userName,
                );
              }));
            },
          ),
          Expanded(
            child: Text(
              value ?? "-",
              textAlign: TextAlign.right,
              // overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: Colors.grey, fontFamily: "thin", fontSize: 17),
            ),
          ),
          Text(
            lable ?? "-",
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: Colors.black, fontFamily: "black", fontSize: 18),
          ),
        ],
      ),
    );
  }

  _lable(String lable, String value, BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          lable != "  : رقم الجوال"
              ? Container()
              : Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(FontAwesomeIcons.whatsapp),
                      onPressed: () {
                        _launchURL(value);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.call),
                      onPressed: () async {
                        var telephoneUrl =
                            "tel://${widget.data.phone.toString()}";
                        if (await canLaunch(telephoneUrl)) {
                          launch(telephoneUrl);
                        } else {}
                      },
                    ),
                  ],
                ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                value ?? "-",
                textAlign: TextAlign.right,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Colors.grey, fontFamily: "black", fontSize: 18),
              ),
              Text(
                lable ?? "-",
                textAlign: TextAlign.right,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Colors.black, fontFamily: "black", fontSize: 18),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showRatingDialog(BuildContext context) {
    // We use the built in showDialog function to show our Rating Dialog
    // String lang2 = translator.currentLanguage;
    // String title = lang == "ar" ? "إرسال التقييم الخاص بك" : "Submit Your Rate";
    // String desc = lang == "ar"
    //     ? "اضغط على نجمة لتعيين تقييمك"
    //     : "Tap a star to set your rating";

    // var lang = AppLocalizations.of(context).locale.languageCode;
    // print(lang);
    showDialog(
        context: context,
        barrierDismissible: true, // set to false if you want to force a rating
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setSta) {
              return AlertDialog(
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Center(
                        child: CachedNetworkImage(
                          imageUrl: ImageUserUrl + widget.data.imageProfile,
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          height: 70,
                          width: 70,
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error, color: Colors.black),
                          fit: BoxFit.fill,
                        ),
                      ),
                      SmoothStarRating(
                          allowHalfRating: true,
                          // onRatingChanged: (v) {
                          //   rating = v;
                          //   setSta(() {
                          //     rating = v;
                          //   });
                          // },
                          onRated: (v) {
                            rating = v;
                            setSta(() {
                              rating = v;
                            });
                          },
                          starCount: 5,
                          rating: rating,
                          size: 40.0,
                          color: Colors.black,
                          borderColor: Colors.black,
                          spacing: 0.0),
                      SizedBox(
                        height: 10,
                      ),
                      Form(
                        key: formKey,
                        child: Container(
                          height: 70,
                          width: MediaQuery.of(context).size.width,
                          child: TextFormField(
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "من فضلك ادخل نص الرسالة";
                                } else {
                                  _comment = value;
                                }
                                return null;
                              },
                              decoration: new InputDecoration(
                                focusColor: Theme.of(context).primaryColor,
                                hoverColor: Theme.of(context).primaryColor,
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 0.0, horizontal: 10.0),
                                fillColor: const Color(0xffffffff),
                                border: new OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: new BorderSide(
                                        color: Theme.of(context).primaryColor)),
                                hintText: "نص الرسالة",
                              ),
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.text,
                              maxLines: 5),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(50)),
                        width: MediaQuery.of(context).size.width,
                        child: InkWell(
                          onTap: () {
                            print(_comment);
                            print(rating);
                            // print(providerDetails.id);
                            _sendRate();
                          },
                          child: Center(
                            child: Text(
                              "ارسال",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "black",
                                  fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //   actions: <Widget>[
                //  ],
              );
            },
          );
        });
  }

  int rate;
  _sendRate() async {
    // var lang = AppLocalizations.of(context).locale.languageCode;

    FormState formState = formKey.currentState;
    if (formState.validate()) {
      formState.save();
      setState(() {
        rate = rating.toInt();
      });
      _apiRequests.sendrating(rate, _comment, widget.data.id).then((value) {
        if (value == null) {
          setState(() {
            Navigator.of(context, rootNavigator: true).pop();
            showInSnackBar(
                "تاكد من الاتصال بالانترنت", Colors.red, _scaffoldKey);
          });
        } else if (value == true) {
          setState(() {
            Navigator.of(context, rootNavigator: true).pop();
            showInSnackBar("تم ارسال تقييمك بنجاح", Colors.green, _scaffoldKey);
          });
        }
      });
      // var body = jsonEncode({
      //   "rating": rate,
      //   "comments": _comment,
      //   "providerId": widget.providerDetails.id,
      // });
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // Map<String, String> head = ({
      //   "content-type": "application/json",
      //   "charset": "utf-8",
      //   "Authorization": prefs.getString('token')
      // });
      // print(prefs.getString('token'));
      // await util
      //     .post('UserProviderRatings', body: body, headers: head)
      //     .then((result) {
      //   print(body.toString());
      //   if (result.statusCode == 200) {
      //     setState(() {
      //       setState(() {
      //         Navigator.of(context, rootNavigator: true).pop();

      //         showInSnackBar(
      //             context,
      //             lang == 'ar'
      //                 ? 'تم ارسال تقييمك بنجاح'
      //                 : "Your rating has been sent successfully");
      //       });
      //       print('ok');
      //     });
      //   }
      // });

    }
  }

  _ratingWedget() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
  
    IconButton(
      icon: Icon(
        Icons.visibility,
        color: Colors.black,
      ),
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return RewiewsPage(
            id: widget.data.id,
          );
        }));
      },
    )   ,   SizedBox(
      width: 20,
    ),
    RatingBar(
      // initialRating: (widget.data.userAverageRatings != null)

      //     ? widget.data.userAverageRatings.toDouble()

      //     : 0.0,

      initialRating:
          widget.data.totalRate == null ? 0 : widget.data.totalRate*1.0,

      //  minRating: 1,
      itemSize: 20,
      direction: Axis.horizontal,

      allowHalfRating: true,

      itemCount: 5,

      // itemPadding: EdgeInsets.symmetric(
      //     horizontal: 4.0),

      itemBuilder: (context, _) => Icon(
        Icons.star,
        color: Colors.amber,
      ),

      ignoreGestures: true,

      unratedColor: Colors.grey,

      onRatingUpdate: (rating) {
        print("mahmoud");

        // print(widget.data.userAverageRatings);
      },
    ),
    SizedBox(
      width: 20,
    ),
    Text(
      " :  التعليقات",
      style:
          TextStyle(color: Colors.black, fontFamily: "black", fontSize: 18),
    ),
    
        ],
      );
  }

  Widget _servic_location_end() {
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
            lable_service_location_end,
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
                    lable_service_location_end = result.address.toString();
                    latend = result.latLng.latitude;
                    longend = result.latLng.longitude;
                  });
                }),
            null),
      ),
    ));
  }

  _launchURL(String value) async {
    String url = 'whatsapp://send?phone=/$value';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget _servic_location_start() {
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
            lable_service_location_start,
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
                    lable_service_location_start = result.address.toString();
                    latstart = result.latLng.latitude;
                    longstart = result.latLng.longitude;
                  });
                }),
            null),
      ),
    ));
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

  void _vaildate() {
    bool check = widget.data.categoryId == 16 ||
        widget.data.categoryId == 20 ||
        widget.data.categoryId == 29;
    if (widget.data.categoryId == 16 ||
        widget.data.categoryId == 20 ||
        widget.data.categoryId == 29) {
      if (latstart == null) {
        showInSnackBar(
            "برجاء قم بادخال نقطة البداية", Colors.red, _scaffoldKey);
        return;
      }
      if (latend == null) {
        showInSnackBar("برجاء قم بادخال النهاية", Colors.red, _scaffoldKey);
        return;
      }
    }

    setState(() {
      _isLoading = true;
    });
    _apiRequests
        .sendRequest(
            widget.data.id.toString(),
            !check ? null : lable_service_location_end,
            !check ? null : latend.toString(),
            !check ? null : longend.toString(),
            !check ? null : lable_service_location_start,
            !check ? null : latstart.toString(),
            !check ? null : longstart.toString())
        .then((value) {
      print("----------------------valeie-------------------");
      print(value);
      setState(() {
        _isLoading = false;
      });
      if (value == true) {
        showInSnackBar("تم ارسال طلبك بنجاح", Colors.green, _scaffoldKey);
        // Navigator.pushAndRemoveUntil(context,
        //     MaterialPageRoute(builder: (context) {
        //   return HomePage();
        // }), (Route<dynamic> route) => false);
      } else if (value == false) {
        showInSnackBar("حدث خطأ ما حاول مره اخري", Colors.red, _scaffoldKey);
      } else {
        showInSnackBar(
            "تاكد من الاتصال بالانترنت ", Colors.orange, _scaffoldKey);
      }
    });
  }
}
