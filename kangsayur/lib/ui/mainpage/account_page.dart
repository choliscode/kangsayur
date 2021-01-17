import 'dart:convert';

import 'package:coba2/network/api/url_api.dart';
import 'package:coba2/network/model/pref_model.dart';
import 'package:coba2/network/model/user_model.dart';
import 'package:coba2/ui/viewpage/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AccountPages extends StatefulWidget {
  @override
  _AccountPagesState createState() => _AccountPagesState();
}

class _AccountPagesState extends State<AccountPages> {
  List<UserModel> list = [];
  var loading, id;

  getPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      id = sharedPreferences.getString(PrefProfile.userID);
    });
    getProfile();
  }

  getProfile() async {
    loading = true;
    list.clear();
    final response = await http.get(BASEURL.profileCustomer + id);
    if (response.statusCode == 200) {
      setState(() {
        loading = false;
        final data = jsonDecode(response.body);
        for (Map i in data) {
          list.add(UserModel.fromJson(i));
        }
      });
    }
  }

  Widget textField({@required String hintText, InputDecoration decoration}) {
    return Material(
      elevation: 0,
      shadowColor: Colors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        enabled: false,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            letterSpacing: 2,
            color: Colors.black54,
            fontWeight: FontWeight.bold,
          ),
          fillColor: Colors.white30,
          filled: true,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none),
        ),
      ),
    );
  }

  signOut() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove(PrefProfile.userID);
    sharedPreferences.remove(PrefProfile.nama);
    sharedPreferences.remove(PrefProfile.phone);
    sharedPreferences.remove(PrefProfile.alamat);
    sharedPreferences.remove(PrefProfile.createdDate);
    sharedPreferences.remove(PrefProfile.status);
    sharedPreferences.remove(PrefProfile.login);

    setState(() {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Login()));
    });
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Akun Saya"),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Container(
            height: 350,
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, i) {
                final x = list[i];
                return Card(
                    child: Container(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Nama : " + x.nama),
                            SizedBox(
                              height: 15,
                            ),
                            Text("No, Telp : " + x.phone),
                            SizedBox(
                              height: 15,
                            ),
                            Text("Alamat : " + x.alamat),
                          ],
                        )));
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
          height: 45,
          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: RaisedButton(
            textColor: Colors.white,
            color: Colors.red,
            child: Text('Keluar'),
            onPressed: () {
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) => AlertDialog(
                        title: Text("Informasi ..."),
                        content: Text("Apakah anda yakin ingin keluar ?"),
                        actions: [
                          FlatButton(
                              onPressed: () {
                                setState(() {
                                  Navigator.pop(context);
                                });
                              },
                              child: Text("Tidak")),
                          FlatButton(
                              onPressed: () {
                                setState(() {
                                  signOut();
                                });
                              },
                              child: Text("Iya")),
                        ],
                      ));
            },
          )),
    );
  }
}

// class HeaderCurvedContainer extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint paint = Paint()..color = Color(0xff555555);
//     Path path = Path()
//       ..relativeLineTo(0, 150)
//       ..quadraticBezierTo(size.width / 2, 225, size.width, 150)
//       ..relativeLineTo(0, -150)
//       ..close();
//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => false;
// }
