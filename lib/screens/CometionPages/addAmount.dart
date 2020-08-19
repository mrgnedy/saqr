import 'package:flutter/material.dart';
import 'package:saqr/ApiRequestes.dart';
import 'package:saqr/Utillity/ApiUtillity.dart';
import 'package:saqr/widgets/Drawer.dart';
import 'package:saqr/widgets/commnDesgin.dart';

import 'countinueAddComtion.dart';

class AddCopmmtionAmount extends StatefulWidget {
  @override
  _AddCopmmtionAmountState createState() => _AddCopmmtionAmountState();
}

class _AddCopmmtionAmountState extends State<AddCopmmtionAmount> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  ApiRequests _apiRequests = new ApiRequests();
  double w;
  double h;
  TextEditingController _amountController;

  bool _isLoading = false;
  @override
  void dispose() {
    // TODO: implement dispose
    _amountController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _amountController = new TextEditingController();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: _appBar(),
      body: _body(),
      drawer: drawer(context),
    );
  }

  Widget _body() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.all(8.0),
      // alignment: Alignment.centerRight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          mainText("عمولة التطبيق"),
          _divider(),
          Center(child: _amountTextFaild()),
          _divider(),
          _isLoading
              ? LOADING()
              : InkWell(
                  onTap: () {
                    _vaildate();
                  },
                  child: Center(child: commnBtnDesign(" التالي  ", w))),
        ],
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
    );
  }

  Widget _amountTextFaild() {
    return Container(
      width: w > 400 ? w * .7 : 400 * .7,
      child: TextFormField(
        controller: _amountController,
        textAlign: TextAlign.right,
        keyboardType: TextInputType.number,
        decoration: textFormInputDecoration(" المبلغ "),
      ),
    );
  }

  Widget _divider() {
    return SizedBox(
      height: 20,
    );
  }

  void _vaildate() {
    if (_amountController.text.isEmpty) {
      showInSnackBar(
          "رجاء قم بادخل المبلغ", Colors.grey[GREYDEGREE], _scaffoldKey);
      return;
    } else {
      setState(() {
        _isLoading = true;
      });
      _apiRequests.addCmmtionamount(_amountController.text).then((value) {
        print("----------------------valeie-------------------");
        print(value);
        setState(() {
          _isLoading = false;
        });
        if (value != null) {
          if (value == false) {
            showInSnackBar(
                "حدث خطا ما حاول مره اخري", Colors.red, _scaffoldKey);
          } else {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ContanueAddComtion(data: value);
            }));
            print("true");
          }
        } else {
          showInSnackBar(
              "تاكد من الاتصال بالانترنت ", Colors.orange, _scaffoldKey);
        }
      });
    }
  }
}
