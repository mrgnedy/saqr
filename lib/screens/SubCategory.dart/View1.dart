import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:saqr/ServiceProvider/serviceProvidersPage.dart';
import 'package:saqr/Utillity/ApiUtillity.dart';
import 'package:saqr/models/categoryModel.dart';
import 'package:saqr/screens/AddService/addservice.dart';

import 'package:saqr/screens/NotifcationPage/View.dart';
import 'package:saqr/sharedUi/home_cell.dart';
import 'package:saqr/widgets/Drawer.dart';
import 'package:saqr/widgets/commnDesgin.dart';

import '../../dataUser.dart';

class SubCategory1 extends StatefulWidget {
  final Data data;

  SubCategory1({this.data});

  @override
  _SubCategory1State createState() => _SubCategory1State();
}

class _SubCategory1State extends State<SubCategory1> {
  // CategoryModel _data = new CategoryModel();
  DataUser _dataUser = DataUser.instance;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    // TODO: implement initState
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        appBar: _appBar(),
        body: _body(),
        floatingActionButton: _floatingActionBar()
        // drawer: drawer(context),
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
            mainText(widget.data.name.toString()),
            Center(
              child: Wrap(
                  children:
                      List.generate(widget.data.subCategories.length, (idx) {
                return InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ServiesProvidersPage(
                        categoryid: widget.data.subCategories[idx].categoryId,
                        subcategoryid: widget.data.subCategories[idx].id,
                      );
                    }));
                  },
                  child: HomeCell(
                    name: widget.data.subCategories[idx].name,
                    image: ImageSubCategoryBaseUrl +
                        widget.data.subCategories[idx].image,
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
    );
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
}
