import 'dart:convert';

import 'package:coba2/network/api/url_api.dart';
import 'package:coba2/network/model/payment_model.dart';
import 'package:coba2/ui/viewpage/choose_payment.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../network/model/cart_model.dart';
import 'package:http/http.dart' as http;

class CartPage extends StatefulWidget {
  final VoidCallback method;
  CartPage(this.method);
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  NumberFormat price = NumberFormat("#,##0", "EN_US");
  TextEditingController payment = TextEditingController();
  TextEditingController notes = TextEditingController();
  var loading;
  var deviceID;
  List<CartModel> cartModel = [];
  DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  getdeviceInfo() async {
    AndroidDeviceInfo androidDeviceInfo = await deviceInfoPlugin.androidInfo;
    setState(() {
      deviceID = androidDeviceInfo.androidId;
    });
    print("Android ID : " + androidDeviceInfo.androidId);
    getCart(deviceID);
    cartTotalPrice();
    cartTotalItem();
  }

  getCart(String deviceID) async {
    loading = true;
    cartModel.clear();
    final response = await http.get(BASEURL.getKeranjang + deviceID);
    if (response.statusCode == 200) {
      setState(() {
        loading = false;
        final data = jsonDecode(response.body);
        for (Map i in data) {
          cartModel.add(CartModel.fromJson(i));
        }
      });
    }
  }

  deleteMenuKeranjang(String idProduk) async {
    final response = await http.post(BASEURL.deleteMenuKeranjang, body: {
      "deviceID": deviceID,
      "produkid": idProduk,
    });
    final data = jsonDecode(response.body);
    int value = data['value'];
    String message = data['message'];
    if (value == 1) {
      setState(() {
        // Navigator.pop(context);
        widget.method();
        refresh();
      });
    } else {
      print(message);
    }
  }

  updateQuantity(CartModel model, String tipe) async {
    final response = await http.post(BASEURL.updateQuantity,
        body: {"cartId": model.cartid, "tipe": tipe});
    final data = jsonDecode(response.body);
    int value = data['value'];
    String message = data['message'];
    if (value == 1) {
      // loading();
      print(message);
      refresh(); // udah tidak sementara
    } else {
      print(message);
    }
  }

  var sumPrice = "0";
  cartTotalPrice() async {
    final response = await http.get(BASEURL.totalCart + deviceID);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      String total = data['total'];
      setState(() {
        loading = false;
        sumPrice = total;
      });
      // print(sumPrice);
    } else {
      setState(() {
        loading = true;
      });
    }
  }

  var totalItem = "0";
  cartTotalItem() async {
    final response = await http.get(BASEURL.totalItem + deviceID);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      String totalItems = data['total'];
      setState(() {
        loading = false;
        totalItem = totalItems;
      });
      // print(sumPrice);
    } else {
      setState(() {
        loading = true;
      });
    }
  }

  // getPref() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   setState(() {

  //   });
  // }

  Future<void> refresh() {
    return getdeviceInfo();
  }

  String paymentId;
  PaymentAPI _paymentMethodModel;
  choosePaymentMethod() async {
    _paymentMethodModel = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => ChoosePayment()));
    setState(() {
      payment = TextEditingController(text: _paymentMethodModel.paymentName);
      paymentId = _paymentMethodModel.paymentId;
    });
  }

  DateTime tgl = DateTime.now();
  String pilihTanggal;

  Future<Null> _selectDateStart(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: tgl,
      firstDate: DateTime(1992),
      lastDate: DateTime(2099),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData(
            colorScheme: ColorScheme.fromSwatch(
                primarySwatch: Colors.orange,
                primaryColorDark: Colors.white,
                accentColor: Colors.white),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.accent),
          ),
          child: child,
        );
      },
    );
    if (picked != null && picked != tgl) {
      setState(() {
        tgl = picked;
        pilihTanggal = DateFormat('yyyy-MM-dd').format(tgl);
      });
    } else {}
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    getdeviceInfo();
    print(paymentId != null ? paymentId : "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.5,
          iconTheme: IconThemeData(color: Colors.green),
          title: createHeader(),
        ),
        resizeToAvoidBottomPadding: false,
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.grey.shade100,
        body: Builder(
          builder: (context) {
            return RefreshIndicator(
              onRefresh: refresh,
              child: ListView(
                physics: ClampingScrollPhysics(),
                children: <Widget>[
                  datePicker(),
                  createCartList(),
                  chooseNotes(),
                  choosePayment(),
                ],
              ),
            );
          },
        ),
        bottomNavigationBar: footer(context));
  }

  choosePayment() {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Pilih Metode Pembayaran"),
          SizedBox(
            height: 8,
          ),
          InkWell(
            onTap: choosePaymentMethod,
            child: Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 0.5),
                    borderRadius: BorderRadius.circular(5)),
                height: 45,
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: TextField(
                  controller: payment,
                  decoration: InputDecoration(
                      suffixIcon: Icon(Icons.payment),
                      border: InputBorder.none,
                      hintText: "Silahkan pilih metode pembayaran",
                      hintStyle: TextStyle(color: Colors.black)),
                  enabled: false,
                )),
          ),
        ],
      ),
    );
  }

  chooseNotes() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Tambahkan Catatan"),
          SizedBox(
            height: 8,
          ),
          Container(
              decoration: BoxDecoration(
                  border: Border.all(width: 0.5),
                  borderRadius: BorderRadius.circular(5)),
              height: 80,
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: TextField(
                controller: notes,
                maxLines: 5,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Cth : Address, Notes, etc",
                    hintStyle: TextStyle(color: Colors.black)),
              )),
        ],
      ),
    );
  }

  datePicker() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Pilih Tanggal Pengiriman"),
          SizedBox(
            height: 8,
          ),
          InkWell(
            onTap: (){
              _selectDateStart(context);
            },
                      child: Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 0.5),
                    borderRadius: BorderRadius.circular(5)),
                height: 45,
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: DateFormat('dd-MM-yyyy').format(tgl),
                      hintStyle: TextStyle(color: Colors.black)),
                  enabled: false,
                )),
          ),
        ],
      ),
    );
  }

  footer(BuildContext context) {
    return Container(
      height: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 30),
                child: Text(
                  "Total",
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 30),
                child: sumPrice == null
                    ? Text("Rp 0")
                    : Text(
                        "Rp " + price.format(int.parse(sumPrice)),
                      ),
              ),
            ],
          ),
          Container(
            height: 40,
            margin: EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Colors.green, borderRadius: BorderRadius.circular(5)),
            child: Center(
              child: Text(
                "CHECKOUT",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
      margin: EdgeInsets.only(top: 16),
    );
  }

  createHeader() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Shopping Cart",
            style: TextStyle(color: Colors.green),
          ),
          Text(
            totalItem == null ? "" : "$totalItem Items",
            style: TextStyle(fontSize: 16, color: Colors.green),
          ),
        ],
      ),
    );
  }

  createCartList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      primary: false,
      itemBuilder: (context, position) {
        final x = cartModel[position];
        return Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 16, right: 16, top: 5),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(16))),
              child: Row(
                children: <Widget>[
                  Container(
                    margin:
                        EdgeInsets.only(right: 8, left: 8, top: 0, bottom: 8),
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(14)),
                        color: Colors.blue.shade200,
                        image: DecorationImage(
                            image:
                                NetworkImage(BASEURL.imageProduct + x.gambar),
                            fit: BoxFit.cover)),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(right: 8, top: 4),
                            child: Text(
                              x.nama,
                              maxLines: 2,
                              softWrap: true,
                            ),
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Rp " + price.format(int.parse(x.harga)),
                                  // style: CustomTextStyle.textFormFieldBlack
                                  //     .copyWith(color: Colors.green),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      x.qty == "1"
                                          ? SizedBox()
                                          : InkWell(
                                              onTap: () {
                                                setState(() {
                                                  updateQuantity(x, "kurang");
                                                });
                                              },
                                              child: Icon(
                                                Icons.remove,
                                                size: 24,
                                                color: Colors.grey.shade700,
                                              ),
                                            ),
                                      Container(
                                        color: Colors.grey.shade200,
                                        padding: const EdgeInsets.only(
                                            bottom: 2, right: 12, left: 12),
                                        child: Text(x.qty
                                            // style:
                                            //     CustomTextStyle.textFormFieldSemiBold,
                                            ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            updateQuantity(x, "tambah");
                                          });
                                        },
                                        child: Icon(
                                          Icons.add,
                                          size: 24,
                                          color: Colors.grey.shade700,
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    flex: 100,
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: () {
                  setState(() {
                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) => AlertDialog(
                              title: Text("Information .. "),
                              content: Text(
                                  "Apakah anda yakin ingin menghapus menu dari keranjang ?"),
                              actions: [
                                FlatButton(
                                    onPressed: () {
                                      setState(() {
                                        // Navigator.pop(context);
                                        // deleteMenuKeranjang(x.produkId);
                                        Navigator.pop(context);
                                      });
                                    },
                                    child: Text("No")),
                                FlatButton(
                                    onPressed: () {
                                      setState(() {
                                        // Navigator.pop(context);
                                        deleteMenuKeranjang(x.produkId);
                                        Navigator.pop(context);
                                      });
                                    },
                                    child: Text("Yes")),
                              ],
                            ));
                  });
                },
                child: Container(
                  width: 24,
                  height: 24,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(right: 10, top: 8),
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 20,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      color: Colors.green),
                ),
              ),
            )
          ],
        );
      },
      itemCount: cartModel.length,
    );
  }

  // createCartListItem() {
  //   return ListView.builder(
  //     itemCount: cartModel.length,
  //     itemBuilder: (context, i) {

  //     },
  //   );
  // }
}
