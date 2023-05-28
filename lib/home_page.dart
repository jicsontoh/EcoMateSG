import 'package:ecomatesg/Icons/change_color.dart';
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

  var colorIdx = 0;
  var iconIdx = 0;
  var iconIdx2 = 0;
  var iconIdx3 = 0;

  var colors = [
    Colors.cyan,
    Colors.redAccent,
    Colors.lightGreenAccent,
    Colors.yellow,
    Colors.grey,
    Colors.purpleAccent,
    Colors.teal,
    Colors.deepPurple,
    Colors.deepOrange,
  ];

  var icons = [
    Icons.apartment_outlined,
    Icons.app_blocking_rounded,
    Icons.access_alarm_rounded,
    Icons.backpack,
    Icons.backspace_rounded,
    Icons.accessibility,
    Icons.connect_without_contact_sharp,
    Icons.construction_sharp,
    Icons.add_a_photo,
    Icons.ac_unit_outlined
  ];

  var text = [
    'Apartment',
    'Blocking',
    'Alarm',
    'Backpack',
    'Backspace',
    'Accessibility',
    'Connect',
    'Construction',
    'Photo',
    'Aircon',
  ];

  var change = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo App 2',
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
          // Top Dashboard
          Container(
          decoration: BoxDecoration(
            border: Border.all(width: 2, color: Colors.black38),
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
          // alignment: Alignment.topCenter,
          margin: EdgeInsets.only(top: deviceHeight(context) * 0.05,
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                semanticsValue: "Test",
              ),
            ]
          ),
        ),
            const Text('Track Emissions:',
                style: TextStyle(color: textColour,
                    fontFamily: 'NotoSans')),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //   crossAxisAlignment: CrossAxisAlignment.center,
        //   children: [
        //     Column(children: [
        //       Icon(icons[(iconIdx)]),
        //       Container(
        //         child: Text(text[(iconIdx)]),
        //       ),
        //     ]),
        //     Column(children: [
        //       Icon(icons[(iconIdx2)]),
        //       Container(
        //         child: Text(text[(iconIdx2)]),
        //       ),
        //     ]),
        //     Column(children: [
        //       Icon(icons[(iconIdx3)]),
        //       Container(
        //         child: Text(text[(iconIdx3)]),
        //       ),
        //     ])
        //   ],
        // ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   crossAxisAlignment: CrossAxisAlignment.center,
        //   children: [
        //     TextButton(onPressed: _changeColor,
        //         style: ButtonStyle(
        //           shape: MaterialStateProperty.all(
        //               RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
        //           // backgroundColor: Colors.teal,
        //         ),
        //         child: Column(children: [
        //           Icon(
        //             Icons.swap_horizontal_circle_outlined,
        //             color: Colors.black,
        //           ),
        //           Text(
        //             'Change Color',
        //             style: TextStyle(color: Colors.black),
        //           ),
        //         ])),
        //     TextButton(onPressed: _changeWidgets,
        //         style: ButtonStyle(
        //           shape: MaterialStateProperty.all(
        //               RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
        //           // backgroundColor: Colors.teal,
        //         ),
        //         child: Column(children: [
        //           Icon(
        //             Icons.swap_calls,
        //             color: Colors.black,
        //           ),
        //           Text(
        //             'Change Widgets',
        //             style: TextStyle(color: Colors.black),
        //           ),
        //         ])),
        //   ],
        // )
      ]),
    );
  }

  // Widget progressBar() {
  //   return AnimatedCircularChart(
  //     key: _chartKey,
  //     size: _chartSize,
  //     initialChartData: <CircularStackEntry>[
  //       CircularStackEntry(
  //         <CircularSegmentEntry>[
  //           CircularSegmentEntry(
  //             33.33,
  //             Colors.blue[400],
  //             rankKey: 'completed',
  //           ),
  //           CircularSegmentEntry(
  //             66.67,
  //             Colors.blueGrey[600],
  //             rankKey: 'remaining',
  //           ),
  //         ],
  //         rankKey: 'progress',
  //       ),
  //     ],
  //     chartType: CircularChartType.Radial,
  //     percentageValues: true,
  //     holeLabel: '1/3',
  //     labelStyle: TextStyle(
  //       color: Colors.blueGrey[600],
  //       fontWeight: FontWeight.bold,
  //       fontSize: 24.0,
  //     ),
  //   );
  // }

  void _changeWidgets() {
    setState(() {
      var rng = Random();
      var cur = iconIdx;
      iconIdx = rng.nextInt(icons.length);
      iconIdx2 = rng.nextInt(icons.length);
      iconIdx3 = rng.nextInt(icons.length);
      // while(cur == iconIdx) {
      //   iconIdx = rng.nextInt(icons.length);
      // }
    });
  }

  void _changeColor() {
    setState(() {
      var rng = Random();
      var cur = colorIdx;
      while(cur == colorIdx) {
        colorIdx = rng.nextInt(colors.length);
      }
    });
  }


  Widget _buildList() {
    return ListView(
      children: [
        _tile('CineArts at the Empire', '85 W Portal Ave', Icons.theaters),
        _tile('The Castro Theater', '429 Castro St', Icons.theaters),
        _tile('Alamo Drafthouse Cinema', '2550 Mission St', Icons.theaters),
        _tile('Roxie Theater', '3117 16th St', Icons.theaters),
        _tile('United Artists Stonestown Twin', '501 Buckingham Way',
            Icons.theaters),
        _tile('AMC Metreon 16', '135 4th St #3000', Icons.theaters),
        const Divider(),
        _tile('K\'s Kitchen', '757 Monterey Blvd', Icons.restaurant),
        _tile('Emmy\'s Restaurant', '1923 Ocean Ave', Icons.restaurant),
        _tile('Chaiya Thai Restaurant', '272 Claremont Blvd', Icons.restaurant),
        _tile('La Ciccia', '291 30th St', Icons.restaurant),
      ],
    );
  }

  ListTile _tile(String title, String subtitle, IconData icon) {
    return ListTile(
      title: Text(title,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
          )),
      subtitle: Text(subtitle),
      leading: Icon(
        icon,
        color: Colors.blue[500],
      ),
    );
  }
}
