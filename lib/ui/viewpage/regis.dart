import 'dart:convert';

import 'package:coba2/network/api/url_api.dart';
import 'package:coba2/ui/viewpage/login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Regis extends StatefulWidget {
  @override
  _RegisState createState() => _RegisState();
}

class _RegisState extends State<Regis> {
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController password = TextEditingController();

  bool secureText = true;
  showHide() {
    setState(() {
      secureText = !secureText;
    });
  }

  registerSubmit() async {
    final response = await http.post(BASEURL.registrasi, body: {
      "name": name.text,
      "password": password.text,
      "phone": phone.text,
      "alamat": address.text,
    });
    final data = jsonDecode(response.body);
    int value = data['value'];
    String pesan = data['message'];
    if (value == 1) {
      print(pesan);
      setState(() {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Login()));
      });
    } else {
      print(pesan);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Isi Data Diri Anda'),
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
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: Row(
                      children: <Widget>[
                        Text('Isi Biodata Anda'),
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    )),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: name,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Nama',
                    ),
                  ),
                ),
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
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: address,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'No.Rumah',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    controller: password,
                    obscureText: secureText,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          showHide();
                        },
                        icon: Icon(secureText
                            ? Icons.visibility_off
                            : Icons.visibility),
                      ),
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                ),
                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    margin: EdgeInsets.only(top: 20),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.blue,
                      child: Text('Masuk'),
                      onPressed: registerSubmit,
                    )),
              ],
            )));
  }
}
