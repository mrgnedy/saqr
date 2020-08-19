import 'package:flutter/material.dart';
import 'package:saqr/ApiRequestes.dart';
import 'package:saqr/Utillity/ApiUtillity.dart';
import 'package:saqr/widgets/commnDesgin.dart';

class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  double w;
  double h;
  TextEditingController _nameController;
  TextEditingController _phonenumberController;
  TextEditingController _messageController;
  ApiRequests _apiRequests = new ApiRequests();
  bool _isloading = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _nameController = new TextEditingController();
    _phonenumberController = new TextEditingController();
    _messageController = new TextEditingController();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phonenumberController.dispose();
    _messageController.dispose();
    // TODO: implement dispose
    super.dispose();
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
    );
  }

  Widget _body() {
    return Container(
      width: w,
      height: h,
      padding: EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Align(alignment: Alignment.topRight, child: mainText("اتصل بنا")),
            _nameTextFaild(),
            _divider(),
            _mobildTextFaild(),
            _divider(),
            _messageTextFaild(),
            _divider(),
            _divider(),
            _isloading ? LOADING() : _contactUsBtn(),
          ],
        ),
      ),
    );
  }

  Widget _contactUsBtn() {
    return InkWell(
        onTap: () {
          _sendrequest();
        },
        child: commnBtnDesign("إرسال", w));
  }

  Widget _nameTextFaild() {
    return Container(
      width: w > 400 ? w * .7 : 400 * .7,
      child: TextFormField(
        textAlign: TextAlign.right,
        controller: _nameController,
        decoration: textFormInputDecoration("اسم المستخدم"),
      ),
    );
  }

  Widget _messageTextFaild() {
    return Container(
      width: 400 * .7,
      child: TextFormField(
        controller: _messageController,
        minLines: 8,
        maxLines: 10,
        textAlign: TextAlign.right,
        decoration: textFormInputDecoration("شكوتك او اقتراحك"),
      ),
    );
  }

  Widget _mobildTextFaild() {
    return Container(
      width: 400 * .7,
      child: TextFormField(
        controller: _phonenumberController,
        textAlign: TextAlign.right,
        keyboardType: TextInputType.number,
        decoration: textFormInputDecoration("رقم الجوال"),
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

  Widget _divider() {
    return SizedBox(
      height: 20,
    );
  }

  _sendrequest() {
    if (_nameController.text.isEmpty) {
      showInSnackBar(
          "رجاء قم بإدخال اسم المستخدم", Colors.grey[GREYDEGREE], _scaffoldKey);
      return;
    } else if (_nameController.text.length < 6) {
      showInSnackBar("رجاء قم بإدخال اسم مستخدم صحيح", Colors.grey[GREYDEGREE],
          _scaffoldKey);
      return;
    } else if (_phonenumberController.text.isEmpty) {
      showInSnackBar(
          "رجاء قم بإدخال رقم الجوال", Colors.grey[GREYDEGREE], _scaffoldKey);
      return;
    } else if (_phonenumberController.text.length < 10) {
      showInSnackBar("رجاء قم بإدخال رقم جوال صحيح", Colors.grey[GREYDEGREE],
          _scaffoldKey);
      return;
    } else if (_messageController.text.isEmpty) {
      showInSnackBar("رجاء قم بإدخال شكوتك او اقتراحك", Colors.grey[GREYDEGREE],
          _scaffoldKey);
      return;
    } else if (_messageController.text.length < 20) {
      showInSnackBar(" رجاء قم بإدخال شكوتك او اقتراحك ولا تقل عن 20 حرف",
          Colors.grey[GREYDEGREE], _scaffoldKey);
      return;
    } else {
      setState(() {
        _isloading = true;
      });

      _apiRequests
          .sendFeedBack(_nameController.text, _phonenumberController.text,
              _messageController.text)
          .then((value) {
        setState(() {
          _isloading = false;
          _nameController.text = "";
          _phonenumberController.text = "";
          _messageController.text = "";
        });
        if (value == null) {
          showInSnackBar(
              "رجاء تحقق من الاتصال بالانترنت", Colors.red, _scaffoldKey);
        } else if (value == false) {
          showInSnackBar("حدث خطأ ما ", Colors.red, _scaffoldKey);
        } else {
          showInSnackBar("تم ارسال اقتراحك بنجاح", Colors.green, _scaffoldKey);
        }
      });
    }
  }
}
