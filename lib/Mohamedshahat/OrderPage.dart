import 'package:flutter/material.dart';

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  double h;
  double w;
  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        width: w,
        height: h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/mm.jpeg'), fit: BoxFit.cover)),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
             _staticWedget(),
             Container(color: Colors.white,child:Table(children: [
  TableRow(children: [
    Text("item 1"),
    Text("item 2"),
  ]),
  TableRow(children:[
    Text("item 3"),
    Text("item 4"),
  ]),
]) ,)



             
            ],
          ),
        ),
      ),
    );
  }
  _staticWedget(){
 return    Container(
                  width: w * .9,
                  padding: EdgeInsets.all(8),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.white54,
                      border: Border.all(width: 1, color: Colors.black45),
                      borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Expanded(
                              child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white,
                            ),
                            child: TextFormField(
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 1.5),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          )),
                          Text(
                            " :   رقم الفاتورة",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: "black",
                                fontSize: 17),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Expanded(
                              child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white,
                            ),
                            child: TextFormField(
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 1.5),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          )),
                          Text(
                            "    :      التاريخ    ",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: "black",
                                fontSize: 20),
                          )
                        ],
                      )
                    ],
                  ));
            
            
            
  }
}
