import 'package:flutter/material.dart';
import 'dart:math';

class ChangeColor extends StatefulWidget {
  const ChangeColor({Key? key}) : super(key: key);

  @override
  State<ChangeColor> createState() => _ChangeColorState();

  Color getColor() {
    return _ChangeColorState().getColor();
  }
}

class _ChangeColorState extends State<ChangeColor> {
  var colorIdx = 0;

  var colors = [
    Colors.cyan,
    Colors.redAccent,
    Colors.lightGreenAccent,
    Colors.yellow,
    Colors.grey,
    Colors.purpleAccent,
    Colors.teal
  ];

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //     floatingActionButton: FloatingActionButton.extended(
    //       label: Text('Change Color'),
    //       onPressed: _changeColor,
    //       tooltip: 'Increment',
    //       icon: const Icon(Icons.swap_horizontal_circle_outlined),
    //       backgroundColor: Colors.black87,
    //     )
    // );
    return TextButton(
        onPressed: _changeColor,
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
          // backgroundColor: Colors.teal,
        ),
        child: Column(children: [
          Icon(
            Icons.swap_horizontal_circle_outlined,
            color: Colors.black,
          ),
          Text(
            'Change Color',
            style: TextStyle(color: Colors.black),
          ),
        ]));
  }

  void _changeColor() {
    setState(() {
      var rng = Random();
      colorIdx = rng.nextInt(colors.length);
    });
    print('button presssed');
  }

  Color getColor() {
    return colors[colorIdx];
  }
}