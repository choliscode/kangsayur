<<<<<<< HEAD
import 'dart:convert';

import 'package:coba2/ui/viewpage/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../network/api/url_api.dart';
import '../../network/model/pref_model.dart';
import '../../network/model/user_model.dart';
import 'package:flutter/material.dart';
=======
import 'package:coba2/network/model/pref_model.dart';
import 'package:coba2/ui/viewpage/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
>>>>>>> 39d07bdcb9a1a31194ce646fdb299ed3b7371a9f

class AccountPages extends StatefulWidget {
  @override
  _AccountPagesState createState() => _AccountPagesState();
}

class _AccountPagesState extends State<AccountPages> {
<<<<<<< HEAD
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
=======
  Widget textField({@required String hintText, InputDecoration decoration}) {
    return Material(
      elevation: 4,
>>>>>>> 39d07bdcb9a1a31194ce646fdb299ed3b7371a9f
      shadowColor: Colors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
<<<<<<< HEAD
        enabled: false,
=======
>>>>>>> 39d07bdcb9a1a31194ce646fdb299ed3b7371a9f
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
<<<<<<< HEAD
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
        padding: EdgeInsets.all(20),
        children: [
          Container(
            height: 350,
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, i) {
                final x = list[i];
                return Container(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      containerProfile("Nama : ", x.nama),
                      containerProfile("Phone : ", x.phone),
                      containerProfile("Alamat : ", x.alamat),
                    ]));
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
          height: 55,
          padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
          child: Container(
            child: InkWell(
              onTap: () {
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
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.red,
                ),
                child: Center(child: Text('Keluar', style: TextStyle(color: Colors.white, fontSize: 16),)),
              ),
            ),
          )),
    );
  }

  containerProfile(String title, subtitle) {
    return Column(
      children: [
        Container(
            padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
            height: 75,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[200]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  subtitle,
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ],
            )),
        SizedBox(
          height: 15,
        )
      ],
=======
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Akun Saya"),
      ),
      body: ListView(
        children: [
          Container(
            height: 380,
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                textField(hintText: 'Username'),
                textField(
                  hintText: 'Password',
                ),
                textField(
                  hintText: 'No.Telfon',
                ),
                textField(
                  hintText: 'Alamat',
                ),
              ],
            ),
          ),
          Container(
              height: 50,
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
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
                                      signOut();
                                    });
                                  },
                                  child: Text("Ok")),
                            ],
                          ));
                },
              )),
        ],
      ),
>>>>>>> 39d07bdcb9a1a31194ce646fdb299ed3b7371a9f
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
