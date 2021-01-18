import 'package:coba2/ui/mainpage/main_page.dart';
import 'package:coba2/ui/viewpage/login.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home:
          MainPages(), // tadi kan posisinya gini ? nah cursornya arahin ke yang ada merahnya uler
      // terus klik ctrl + .  atau yang ada icon lampu
    );
  }
}
