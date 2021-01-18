import 'package:coba2/network/model/pref_model.dart';
import 'package:coba2/ui/mainpage/account_page.dart';
import 'package:coba2/ui/mainpage/home_paga.dart';
import 'package:coba2/ui/mainpage/order_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainPages extends StatefulWidget {
  @override
  _MainPagesState createState() => _MainPagesState();
}

class _MainPagesState extends State<MainPages> {
  int selectIndex = 0;

  String userID;
  getPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      userID = sharedPreferences.getString(PrefProfile.userID);
      print(userID);
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
      body: Stack(
        children: [
          Offstage(
            offstage: selectIndex != 0,
            child: TickerMode(
              enabled: selectIndex == 0,
              child: Homepage(),
            ),
          ),
          Offstage(
            offstage: selectIndex != 1,
            child: TickerMode(
              enabled: selectIndex == 1,
              child: OrderPages(),
            ),
          ),
          Offstage(
            offstage: selectIndex != 2,
            child: TickerMode(
              enabled: selectIndex == 2,
              child: AccountPages(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: GestureDetector(
              onTap: () {
                setState(() {
                  selectIndex = 0;
                });
              },
              child: Icon(
                Icons.home,
                color: Colors.green,
              ),
            ),
<<<<<<< HEAD
            // ignore: deprecated_member_use
            title: Text("Home"),
=======
            label: "Home",
>>>>>>> 39d07bdcb9a1a31194ce646fdb299ed3b7371a9f
          ),
          BottomNavigationBarItem(
            icon: GestureDetector(
              onTap: () {
                setState(() {
                  selectIndex = 1;
                });
              },
              child: Icon(
                Icons.assignment,
                color: Colors.green,
              ),
            ),
<<<<<<< HEAD
            // ignore: deprecated_member_use
            title: Text("Pemesanan"),
=======
            label: "Pemesanan",
>>>>>>> 39d07bdcb9a1a31194ce646fdb299ed3b7371a9f
          ),
          BottomNavigationBarItem(
            icon: GestureDetector(
              onTap: () {
                setState(() {
                  selectIndex = 2;
                });
              },
              child: Icon(
                Icons.account_circle,
                color: Colors.green,
              ),
            ),
<<<<<<< HEAD
            // ignore: deprecated_member_use
            title: Text("Profile"),
=======
            label: "Profil",
>>>>>>> 39d07bdcb9a1a31194ce646fdb299ed3b7371a9f
          ),
        ],
      ),
    );
  }
}
