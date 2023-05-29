import 'package:ecomatesg/home_page.dart';
import 'package:ecomatesg/sign_in.dart';
import 'package:ecomatesg/sign_up.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(App());
}

class App extends StatelessWidget {

  static const Color cornsilk = Color(0xFFfefae0);
  static const Color teaGreen = Color(0xFFCCD5AE);
  static const Color buff = Color(0xFFD4A373);
  static const Color papayaWhip = Color(0xfffaedcd);

  // const App({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "EcoMateSG App",
      theme:  ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: HomePage(),
    );
  }
}
