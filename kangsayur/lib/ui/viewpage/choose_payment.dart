import 'dart:convert';

import 'package:coba2/network/api/url_api.dart';
import 'package:coba2/network/model/payment_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChoosePayment extends StatefulWidget {
  @override
  _ChoosePaymentState createState() => _ChoosePaymentState();
}

class _ChoosePaymentState extends State<ChoosePayment> {
  var loading;
  List<PaymentAPI> list = [];

  getInfoPayment() async {
    loading = true;
    list.clear();
    final response = await http.get(BASEURL.getPayment);
    if (response.statusCode == 200) {
      setState(() {
        loading = false;
        final data = jsonDecode(response.body);
        for (Map i in data) {
          list.add(PaymentAPI.fromJson(i));
        }
        // print(list[0].paymentName);
      });
    }
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    getInfoPayment();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Choose Payment"),
      ),
      body: ListView(
        physics: ClampingScrollPhysics(),
        padding: EdgeInsets.all(20),
        children: [
          ListView.builder(
            
              shrinkWrap: true,
              itemCount: list.length,
              itemBuilder: (context, i) {
                final x = list[i];
                return InkWell(
                  onTap: (){
                    Navigator.pop(context, x);
                  },
                                  child: Container(
                    margin: EdgeInsets.only(bottom: 15),
                      decoration: BoxDecoration(
                          border: Border.all(width: 0.5),
                          borderRadius: BorderRadius.circular(5)),
                      height: 45,
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: TextField(
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: x.paymentName,
                            hintStyle: TextStyle(color: Colors.black)),
                        enabled: false,
                      )),
                );
              })
        ],
      ),
    );
  }
}
