import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:saqr/ServiceProvider/serviceProvidersPage.dart';
import 'package:saqr/Utillity/ApiUtillity.dart';
import 'package:saqr/models/categoryModel.dart';
import 'package:saqr/screens/AddService/addservice.dart';
import 'package:saqr/sharedUi/home_cell.dart';
import 'package:saqr/widgets/commnDesgin.dart';

import '../../dataUser.dart';

class SubCategory2 extends StatefulWidget {
  final Data data;
  SubCategory2({this.data});
  @override
  _SubCategory2State createState() => _SubCategory2State();
}

class _SubCategory2State extends State<SubCategory2> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<int> checklist = new List<int>();
  DataUser _dataUser = DataUser.instance;
  @override
  void initState() {
    for (int i = 0; i < widget.data.subCategories.length; i++) {
      checklist.add(0);
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
        floatingActionButton: _floatingActionBar());
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
                  },
                ),
              ),
            ),
          ),
        )
      ],
    );
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
          mainText(widget.data.name.toString()),
          _categoryImage(),
          _subcategoryList(),
        ],
      ),
    );
  }

  _categoryImage() {
    return Center(
      child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: CachedNetworkImage(
            fit: BoxFit.fill,
            width: MediaQuery.of(context).size.width * .9,
            height: MediaQuery.of(context).size.height * .25,
            imageUrl: ImageCategoryBaseUrl + widget.data.image.toString(),
            placeholder: (context, url) => LOADING(),
            errorWidget: (context, url, error) => Icon(
              Icons.error,
              color: Colors.black,
            ),
          )),
    );
  }

  _subcategoryList() {
    return ListView.builder(
        itemCount: widget.data.subCategories.length,
        shrinkWrap: true,
        itemBuilder: (context, idx) {
          return _dataWiget("", widget.data.subCategories[idx]);
        });
  }

  _whichSubCategory(SubCategories subCategori) {
    if (widget.data.name == "النقل الجماعي") {
      return _groupbus(subCategori);
    } else if (widget.data.name == "حاويات نظافة") {
      return garbagrBox(subCategori);
    } else {
      return _sathat(subCategori);
    }
  }

  _groupbus(SubCategories subCategori) {
    if (subCategori.sizeBus == 1) {
      return _dataWiget("باص 45 - 55", subCategori);
    } else {
      return _dataWiget("باص صغير", subCategori);
    }
  }

  garbagrBox(SubCategories subCategori) {
    if (subCategori.sizeClean == 1) {
      return _dataWiget("كبيرة", subCategori);
    } else if (subCategori.sizeClean == 2) {
      return _dataWiget("متوسط", subCategori);
    } else {
      return _dataWiget("صغير", subCategori);
    }
  }

  _sathat(SubCategories subCategori) {
    if (subCategori.sizeSurfaces == 1) {
      return _dataWiget("كبيرة", subCategori);
    } else {
      return _dataWiget("صغير", subCategori);
    }
  }

  _floatingActionBar() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: InkWell(
          onTap: () {
            _dataUser.getKey(ISLOGING).toString() == "null"
                ? drawShowDialog(context)
                : Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return AddService(
                        data: widget.data, price: widget.data.price);
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

  _dataWiget(String s, SubCategories subCategori) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Text(subCategori.name,
              textAlign: TextAlign.right,
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: "thin",
                  fontSize: 18,
                  height: 1.5)),
          IconButton(
              icon:
                  checklist[widget.data.subCategories.indexOf(subCategori)] == 1
                      ? Icon(
                          Icons.check_circle_outline,
                          color: Colors.green,
                        )
                      : Icon(
                          Icons.check_circle_outline,
                          color: Colors.grey,
                        ),
              onPressed: () {
                setState(() {
                  for (int i = 0; i < checklist.length; i++) {
                    checklist[i] = 0;
                  }
                  checklist[widget.data.subCategories.indexOf(subCategori)] = 1;
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ServiesProvidersPage(
                      categoryid: widget.data.id,
                      subcategoryid: subCategori.id,
                    );
                  }));
                  // i];
                });

                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ServiesProvidersPage(
                    categoryid: subCategori.categoryId,
                    subcategoryid: subCategori.id,
                  );
                }));
              }),
        ],
      ),
    );
  }
}
