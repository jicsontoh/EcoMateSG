import 'package:ecomatesg/FirebaseHelper/firestore.dart';
import 'package:ecomatesg/Icons/change_color.dart';
import 'package:ecomatesg/scan_qr.dart';
import 'package:ecomatesg/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:circular_chart_flutter/circular_chart_flutter.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';

import 'main.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, this.currPoints, this.name }) : super(key: key);

  final double? currPoints;
  final String? name;

  @override
  State<HomePage> createState() => _HomePageState(currPoints, name);
}

class _HomePageState extends State<HomePage> {
  static const textColour = Color.fromARGB(255, 44, 82, 105);
  final int maxPoints = 100;
  double currPoints = 0;
  String loggedInUserName = "";
  double deviceHeight(BuildContext context) => MediaQuery.of(context).size.height;
  double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;
  final GlobalKey<AnimatedCircularChartState> _chartKey = new GlobalKey<AnimatedCircularChartState>();

  _HomePageState(double? points, String? name) {
    if (points != null) {
      currPoints = points;
    }

    if (name != null) {
      loggedInUserName = name;
    }
  }

  Future<void> fetchUserCurrPoints() async {
    Map<String, dynamic>? user = await FirestoreCollectionHelper.getLoggedInUser();
    setState(() {
      currPoints = (user?["PlasticBagSavings"] + user?["TransportSavings"]) ?? 0;
    });
  }



  Future<void> _logout() async {
    try {
      await FirebaseAuth.instance.signOut();

      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      }
    } catch (e) {
      print('Error logging out: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Home Page',
        home: Scaffold(
          appBar: AppBar(
            title: const Text(
              'EcoMateSG',
              style: TextStyle(color: textColour, fontFamily: 'NotoSans'),
            ),
            backgroundColor: App.cornsilk,
            actions: [
              PopupMenuButton(
                color: App.cornsilk,
                icon: Icon(
                  Icons.more_vert,
                  color: Colors.black,
                ),
                itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                  PopupMenuItem(
                    child: ListTile(
                      leading: Icon(Icons.settings, color: textColour,),
                      title: Text('Settings', style: TextStyle(color: textColour, fontFamily: 'NotoSans'),),
                    ),
                    onTap: () {
                      // To be implemented
                    },
                  ),
                  PopupMenuItem(
                    child: ListTile(
                      leading: Icon(Icons.person, color: textColour,),
                      title: Text('Profile', style: TextStyle(color: textColour, fontFamily: 'NotoSans'),),
                    ),
                    onTap: () {
                      // To be implemented
                    },
                  ),
                  PopupMenuItem(
                    child: ListTile(
                      leading: Icon(Icons.support, color: textColour,),
                      title: Text('Support', style: TextStyle(color: textColour, fontFamily: 'NotoSans'),),
                    ),
                    onTap: () {
                      // To be implemented
                    },
                  ),
                  PopupMenuItem(
                    child: ListTile(
                      leading: Icon(Icons.logout, color: textColour,),
                      title: Text('Logout', style: TextStyle(color: textColour, fontFamily: 'NotoSans'),),
                    ),
                    onTap: _logout,
                  ),
                ],
              ),
            ],
          ),
          body: buildContent(),
        )
    );
  }

  Widget buildContent() {
    return Container(
      color: App.teaGreen,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: deviceHeight(context) * 0.02,
                left: deviceWidth(context) * 0.04,
              ),
              child: Text('Hello $loggedInUserName!',
                  style: TextStyle(
                      fontSize: 22,
                      color: textColour,
                      fontFamily: 'NotoSans')),
            ),

          // Top Dashboard
          Container(
            decoration: BoxDecoration(
              border: Border.all(width: 2, color: Colors.black38),
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              color: App.papayaWhip
            ),
            width: deviceWidth(context) * 0.9,
            height: deviceHeight(context) * 0.28,
            margin: EdgeInsets.all(deviceWidth(context) * 0.06),
            padding: EdgeInsets.only(
              top: deviceHeight(context) * 0.02,
            bottom: deviceHeight(context) * 0.1,
            left: deviceWidth(context) * 0.08,
            right: deviceWidth(context) * 0.08,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const Text('Carbon Emission:',
                        textAlign: TextAlign.left,
                        style: TextStyle(color: textColour,
                            fontFamily: 'NotoSans')),
                    const Row(
                      children: [
                        Icon(
                          Icons.energy_savings_leaf,
                          color: Colors.greenAccent,
                        ),
                        Text('10kg',
                            style: TextStyle(color: textColour,
                                fontFamily: 'NotoSans')),
                      ],
                    ),
                    SizedBox(
                      height: deviceHeight(context) * 0.05,
                    ),
                    const Text('Total Points:',
                        style: TextStyle(color: textColour,
                            fontFamily: 'NotoSans')),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        Text('88',
                            textAlign: TextAlign.left,
                            style: TextStyle(color: textColour,
                                fontFamily: 'NotoSans')),
                      ],
                    )
                  ],
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: deviceWidth(context) * 0.3,
                      height: deviceWidth(context) * 0.3,
                      child: CircularProgressIndicator(
                        value: currPoints / maxPoints,
                        semanticsLabel: 'Circular progress indicator',
                      ),
                    ),
                    Center(
                      child: Text(
                        '${currPoints}/${maxPoints}', // Replace with the desired text
                        style: TextStyle(
                          fontSize: 24, // Adjust the font size as needed
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )
              ]
            ),
          ),
        Container(
            padding: EdgeInsets.only(
              left: deviceWidth(context) * 0.04
            ),
            child: const Text('Track Emissions:',
                style: TextStyle(fontSize: 18, color: textColour,
                    fontFamily: 'NotoSans')),
          ),
        // Track Emissions
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: () {
                print("Click event on Container");
                Navigator.push(
                  context, MaterialPageRoute(builder: (context) => const ScanQRPage()),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: App.papayaWhip,
                  border: Border.all(width: 2, color: Colors.black38),
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                ),
                width: deviceWidth(context) * 0.33,
                height: deviceWidth(context) * 0.33,
                // alignment: Alignment.topCenter,
                margin: EdgeInsets.only(
                  top: deviceHeight(context) * 0.02,
                  bottom: deviceHeight(context) * 0.05,
                  left: deviceWidth(context) * 0.03,
                  right: deviceWidth(context) * 0.03,
                ),
                padding: EdgeInsets.only(
                  top: deviceHeight(context) * 0.02,
                  bottom: deviceHeight(context) * 0.02,
                  left: deviceWidth(context) * 0.05,
                  right: deviceWidth(context) * 0.05,
                ),
                child: Column(
                  children: [
                    Icon(Icons.leave_bags_at_home_rounded,
                      size: deviceWidth(context) * 0.1,
                    ),
                    SizedBox(height: deviceHeight(context) * 0.02,),
                    const Text('Plastic Bag',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: textColour,
                            fontFamily: 'NotoSans')),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                print("Click event on Container");
                Navigator.push(
                  context, MaterialPageRoute(builder: (context) => const ScanQRPage()),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: App.papayaWhip,
                  border: Border.all(width: 2, color: Colors.black38),
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                ),
                width: deviceWidth(context) * 0.33,
                height: deviceWidth(context) * 0.33,
                // alignment: Alignment.topCenter,
                margin: EdgeInsets.only(
                  top: deviceHeight(context) * 0.02,
                  bottom: deviceHeight(context) * 0.05,
                  left: deviceWidth(context) * 0.03,
                  right: deviceWidth(context) * 0.03,
                ),
                padding: EdgeInsets.only(
                  top: deviceHeight(context) * 0.02,
                  bottom: deviceHeight(context) * 0.02,
                  left: deviceWidth(context) * 0.05,
                  right: deviceWidth(context) * 0.05,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.directions_bus_rounded,
                      size: deviceWidth(context) * 0.1,
                    ),
                    SizedBox(height: deviceHeight(context) * 0.01,),
                    const Text('Public Transport',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: textColour,
                            fontFamily: 'NotoSans')),
                  ],
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }


}
