import 'dart:convert';

import 'package:coba2/network/api/url_api.dart';
import 'package:coba2/network/model/pref_model.dart';
import 'package:coba2/ui/mainpage/main_page.dart';
import 'package:coba2/ui/viewpage/regis.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();

  String userId;
  bool login;
  getPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      userId = sharedPreferences.getString(PrefProfile.userID);
      login = sharedPreferences.getBool(PrefProfile.login);
      userId != null ? sessionLogin() : sessionLogout();
    });
  }

  sessionLogin() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => MainPages()));
  }

  sessionLogout() {}

  loginSubmit() async {
    final response = await http.post(BASEURL.login, body: {
      "password": password.text,
      "phone": phone.text,
    });
    final data = jsonDecode(response.body);
    int value = data['value'];
    String pesan = data['message'];
    String userID = data['userID'];
    String nama = data['nama'];
    String phones = data['phone'];
    String alamat = data['alamat'];
    String status = data['status'];
    String createdDate = data['createdDate'];
    if (value == 1) {
      print(pesan);
      setState(() {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => AlertDialog(
                  title: Text("$pesan"),
                  content: Text("Selamat berbelanja :)"),
                  actions: [
                    FlatButton(
                        onPressed: () {
                          setState(() {
                            // Navigator.pop(context);
                            sessionLogin();
                          });
                        },
                        child: Text("Ok")),
                  ],
                ));
        savePref(userID, nama, phones, alamat, createdDate, status);
      });
    } else {
      print(pesan);
    }
  }

  savePref(
    String userID,
    String nama,
    String phones,
    String alamat,
    String createdDate,
    String status,
  ) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      sharedPreferences.setString(PrefProfile.userID, userID);
      sharedPreferences.setString(PrefProfile.nama, nama);
      sharedPreferences.setString(PrefProfile.phone, phones);
      sharedPreferences.setString(PrefProfile.alamat, alamat);
      sharedPreferences.setString(PrefProfile.createdDate, createdDate);
      sharedPreferences.setString(PrefProfile.status, status);
      sharedPreferences.setBool(PrefProfile.login, true);
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
          title: Text('Yuk Belanja Sayur'),
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Kang Sayur Online',
                      style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.w500,
                          fontSize: 30),
                    )),
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Masuk',
                      style: TextStyle(fontSize: 20),
                    )),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: phone,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'No.Telfon',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    obscureText: true,
                    controller: password,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                ),
                // FlatButton(
                //   onPressed: () {
                //     //forgot password screen
                //   },
                //   textColor: Colors.blue,
                //   child: Text('Lupa Password'),
                // ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.blue,
                      child: Text('Masuk'),
                      onPressed: loginSubmit,
                    )),
                Container(
                    child: Row(
                  children: <Widget>[
                    Text('Jika Belom Punya Akun'),
                    FlatButton(
                      textColor: Colors.blue,
                      child: Text(
                        'Registrasi',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => Regis()));
                      },
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ))
              ],
            )));
  }
}
