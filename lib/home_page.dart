import 'package:ecomatesg/Icons/change_color.dart';
import 'package:ecomatesg/scan_qr.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:circular_chart_flutter/circular_chart_flutter.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const textColour = Color.fromARGB(255, 44, 82, 105);
  double deviceHeight(BuildContext context) => MediaQuery.of(context).size.height;
  double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;
  final GlobalKey<AnimatedCircularChartState> _chartKey = new GlobalKey<AnimatedCircularChartState>();


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Home Page',
        home: Scaffold(
          appBar: AppBar(
            title: const Text('EcoMateSG',
              style: TextStyle(color: textColour,
                fontFamily: 'NotoSans')),
            backgroundColor: Colors.white,
          ),
          body: buildContent(),
        ));
  }

  Widget buildContent() {
    return Container(
      color: Colors.white,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: deviceHeight(context) * 0.02,
                left: deviceWidth(context) * 0.04,
              ),
              child: const Text('Hello, welcome back!',
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
            ),
            // alignment: Alignment.topCenter,
            margin: EdgeInsets.only(top: deviceHeight(context) * 0.02,
                bottom: deviceHeight(context) * 0.05,
                left: deviceWidth(context) * 0.03,
                right: deviceWidth(context) * 0.03,
            ),
            padding: EdgeInsets.only(
              top: deviceHeight(context) * 0.02,
            bottom: deviceHeight(context) * 0.12,
            // left: deviceWidth(context) * 0.1,
            // right: deviceWidth(context) * 0.1,
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text('Carbon Emission:',
                        style: TextStyle(color: textColour,
                            fontFamily: 'NotoSans')),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.energy_savings_leaf,
                          color: Colors.greenAccent,
                        ),
                        Text('10kg',
                            style: TextStyle(color: textColour,
                                fontFamily: 'NotoSans')),
                      ],
                    )
                  ],
                ),
                CircularProgressIndicator(
                  value: 0.5,
                  semanticsLabel: 'Circular progress indicator',
                ),
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
            Container(
              decoration: BoxDecoration(
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
            InkWell(
              onTap: () {
                print("Click event on Container");
                Navigator.push(
                  context, MaterialPageRoute(builder: (context) => const ScanQRPage()),
                );
              },
              child: Container(
                decoration: BoxDecoration(
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
