import 'package:coba2/network/model/pref_model.dart';
import 'package:coba2/ui/viewpage/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountPages extends StatefulWidget {
  @override
  _AccountPagesState createState() => _AccountPagesState();
}

class _AccountPagesState extends State<AccountPages> {
  Widget textField({@required String hintText, InputDecoration decoration}) {
    return Material(
      elevation: 4,
      shadowColor: Colors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
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
