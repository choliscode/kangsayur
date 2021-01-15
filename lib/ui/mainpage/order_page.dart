import 'package:flutter/material.dart';

class OrderPages extends StatefulWidget {
  @override
  _OrderPagesState createState() => _OrderPagesState();
}

class _OrderPagesState extends State<OrderPages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Container(
            padding: EdgeInsets.all(10),
            color: Colors.white,
            height: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Kode Pemesanan",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Icon(Icons.arrow_forward_ios)
                  ],
                ),
                Text(
                  "Tanggal dan jam",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Divider(),
                Text(
                  "Menunggu Pesaanan",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
