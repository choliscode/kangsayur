import 'dart:convert';

import 'package:coba2/network/api/url_api.dart';
import 'package:coba2/network/model/produk_model.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart'; // wajib diimport setiap buat file baru
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class DetailProduk extends StatefulWidget {
  final ProductModel model;
  final VoidCallback method;
  DetailProduk({this.model, this.method});
  @override
  _DetailProdukState createState() => _DetailProdukState();
}

class _DetailProdukState extends State<DetailProduk> {
  String deviceID;
  DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  getdeviceInfo() async {
    AndroidDeviceInfo androidDeviceInfo = await deviceInfoPlugin.androidInfo;
    setState(() {
      deviceID = androidDeviceInfo.androidId;
    });
    print("Android ID : " + deviceID);
    // getProduct();
  }

  final price = NumberFormat('#,##0', 'EN_US');

  // method menambahkan menu ke dalam keranjang
  addCart() async {
    final response = await http.post(BASEURL.addKeranjang, body: {
      "deviceID": deviceID,
      "produkid": widget.model.produkId,
    });
    final data = jsonDecode(response.body);
    int value = data['value'];
    String pesan = data['message'];
    if (value == 1) {
      print(pesan);
      setState(() {
        // Navigator.pop(context);
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Informasi"),
                content: Text(pesan),
                actions: <Widget>[
                  FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                      setState(() {
                        widget.method();
                        Navigator.pop(context);
                      });
                    },
                    child: Text("Ok"),
                  ),
                ],
              );
            });
      });
    } else {
      setState(() {
        // Navigator.pop(context);
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Informasi"),
                content: Text(pesan),
                actions: <Widget>[
                  FlatButton(
                    onPressed: () {
                      // Navigator.pop(context);
                      setState(() {
                        Navigator.pop(context);
                      });
                    },
                    child: Text("Ok"),
                  ),
                ],
              );
            });
      });
    }
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    getdeviceInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.model.nama,
          style: TextStyle(color: Colors.green),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.green),
        elevation: 1,
      ),
      body: ListView(padding: EdgeInsets.all(20), children: [
        Image.network(BASEURL.imageProduct + widget.model.gambar),
        SizedBox(
          height: 20,
        ),
        Text(
          widget.model.deskripsi,
          style: TextStyle(fontSize: 20),
          textAlign: TextAlign.justify,
        ),
      ]),
      bottomNavigationBar: Container(
        padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                addCart();
              },
              child: Container(
                width: MediaQuery.of(context).size.width / 2,
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(5)),
                child: Center(
                    child: Text(
                  "Tambakan Ke Keranjang",
                  style: TextStyle(color: Colors.white),
                )),
              ),
            ),
            Text(
              "Rp " + price.format(int.parse(widget.model.harga)),
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
