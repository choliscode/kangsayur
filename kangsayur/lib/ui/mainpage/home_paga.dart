import 'dart:convert';

import 'package:coba2/network/api/url_api.dart';
import 'package:coba2/network/model/produk_model.dart';
import 'package:coba2/ui/viewpage/detail_produk.dart';
import 'package:coba2/ui/viewpage/keranjang.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  NumberFormat price = NumberFormat('#,##0', 'EN_US');
  DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  var deviceID;
  getdeviceInfo() async {
    AndroidDeviceInfo androidDeviceInfo = await deviceInfoPlugin.androidInfo;
    deviceID = androidDeviceInfo.androidId;
    print("Android ID : " + androidDeviceInfo.androidId);
    getProduct();
    cartTotalItem();
    getMenuCategory();
  }

  TextEditingController searchMenuController = TextEditingController();
  // pemanggilan method di class ke 2
  List<ProductModel> productModel = [];
  List<ProductModel> productSearch = [];
  List<Getcategoryproduct> categoryProduct = [];
  var loading;
  getProduct() async {
    loading = true;
    productModel.clear();
    final response = await http.get(BASEURL.getProduk);
    if (response.statusCode == 200) {
      setState(() {
        loading = false;
        final data = jsonDecode(response.body);
        for (Map i in data) {
          productModel.add(ProductModel.fromJson(i));
        }
      });
    }
  }

  searchMenu(String text) {
    productSearch.clear();
    if (text.isEmpty) {
      setState(() {});
    }
    productModel.forEach((element) {
      if (element.nama.toLowerCase().contains(text)) {
        productSearch.add(element);
      }
    });
    setState(() {});
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

  getMenuCategory() async {
    loading = true;
    categoryProduct.clear();
    final response = await http.get(BASEURL.getcategoryproduct);
    if (response.statusCode == 200) {
      setState(() {
        loading = false;
        final data = jsonDecode(response.body);
        for (Map i in data) {
          categoryProduct.add(Getcategoryproduct.fromJson(i));
        }
      });
    }
  }

  bool filter = false;
  var index;
  Future<void> refresh() async {
    getdeviceInfo();
    setState(() {
      filter = false;
      searchMenuController.clear();
    });
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
    // disini juga bisa tapi lebih baik setelah class ke 2
    return Scaffold(
        appBar: AppBar(
<<<<<<< HEAD
          automaticallyImplyLeading: false,
=======
>>>>>>> 39d07bdcb9a1a31194ce646fdb299ed3b7371a9f
            title: Text(
              'Selamat Datang',
            ),
            actions: <Widget>[
              Stack(
                children: [
                  IconButton(
                      icon: const Icon(Icons.shopping_cart),
                      tooltip: 'Show Snackbar',
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CartPage(cartTotalItem)));
                      }),
                  Positioned(
                    right: 11,
                    top: 11,
                    child: totalItem == '0'
                        ? SizedBox()
                        : Container(
                            padding: EdgeInsets.all(2),
                            decoration: new BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            constraints: BoxConstraints(
                              minWidth: 14,
                              minHeight: 14,
                            ),
                            child: Text(
                              "$totalItem",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 8,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                  )
                ],
              )
            ]),
        body: RefreshIndicator(
          onRefresh: refresh,
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.all(20),
            children: <Widget>[
              TextField(
                  controller: searchMenuController,
                  onChanged: searchMenu,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.blueAccent,
                  ),
                  decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      prefixIcon: Icon(Icons.search),
                      hintText: "Cari Belanjaan Mu Disini",
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blueAccent, width: 32.0),
                          borderRadius: BorderRadius.circular(25.0)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 32.0),
                          borderRadius: BorderRadius.circular(25.0)))),
              Container(
                margin: EdgeInsets.only(top: 15),
              ),
              Text(
                'List Menu',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categoryProduct.length,
                  itemBuilder: (context, i) {
                    final categoryProducts = categoryProduct[i];
                    return InkWell(
                      onTap: () {
                        setState(() {
                          filter = true;
                          index = i;
                          print("$filter,  $index");
                        });
                      },
                      child: Container(
                          margin: EdgeInsets.only(right: 20),
                          height: 50,
                          width: 50,
                          child: Column(
                            children: [
                              Image.network(BASEURL.imageCategory +
                                  categoryProducts.gambar),
                              Text(categoryProducts.namaKategori)
                            ],
                          )),
                    );
                  },
                ),
              ),
              searchMenuController.text.isNotEmpty
                  ? GridView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 0,
                      ),
                      itemCount: productSearch.length,
                      itemBuilder: (context, i) {
                        final x = productSearch[i];
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailProduk(
                                          model: x,
                                        )));
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1, color: Colors.grey[300])),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.network(
<<<<<<< HEAD
                                  BASEURL.imageProduct + x.gambar,
=======
                                  'https://www.pngitem.com/pimgs/m/173-1738766_burger-king-menu-double-cheeseburger-png-download-food.png',
>>>>>>> 39d07bdcb9a1a31194ce646fdb299ed3b7371a9f
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.cover,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "${x.nama}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                Text(
                                  "Rp. " + price.format(int.parse(x.harga)),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.green),
                                ),
                              ],
                            ),
                          ),
                        );
                      })
                  : filter
                      ? categoryProduct[index].produk.length == 0
                          ? Center(
                              child: Text("Menu belum tersedia"),
                            )
                          : GridView.builder(
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 0,
                              ),
                              itemCount: categoryProduct[index].produk.length,
                              itemBuilder: (context, i) {
                                final y = categoryProduct[index].produk[i];
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => DetailProduk(
                                                  model: y,
                                                  method: cartTotalItem,
                                                )));
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(right: 10),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1, color: Colors.grey[300])),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Image.network(
                                          BASEURL.imageProduct + y.gambar,
                                          height: 100,
                                          width: 100,
                                          fit: BoxFit.cover,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "${y.nama}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                        Text(
                                          "Rp. " +
                                              price.format(int.parse(y.harga)),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: Colors.green),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              })
                      : GridView.builder(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 0,
                          ),
                          itemCount: productModel.length,
                          itemBuilder: (context, i) {
                            final x = productModel[i];
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DetailProduk(
                                              model: x,
                                              method: cartTotalItem,
                                            )));
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1, color: Colors.grey[300])),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.network(
                                      BASEURL.imageProduct + x.gambar,
                                      height: 100,
                                      width: 100,
                                      fit: BoxFit.cover,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "${x.nama}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    Text(
                                      "Rp. " + price.format(int.parse(x.harga)),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Colors.green),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          })
            ],
          ),
        ));
  }
}
