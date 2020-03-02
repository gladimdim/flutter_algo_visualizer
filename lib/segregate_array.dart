import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_algo_visualizer/moldable.dart';

class SegregateRGB extends Moldable {
  String taskDescription = '''
  Given an array of strictly the characters 'R', 'G', and 'B', segregate the values of the array so that all the Rs come first, the Gs come second, and the Bs come last. You can only swap elements of the array.
  Do this in linear time and in-place.
  For example, given the array ['G', 'B', 'R', 'R', 'B', 'R', 'G'], it should become ['R', 'R', 'R', 'G', 'G', 'B', 'B'].
  ''';

  String shortName = 'Segregate array to: R, G, B';

  Widget build(BuildContext context, Function callback) {
    return Row(
      children: _values.map((l) {
        return Text(l);
      }).toList(),
    );
  }

  List _values = ['B', 'G', 'R', 'R', 'G', 'G', 'R', 'B', 'G', 'R'];
  Map<String, int> _pointers = {
    'R': 0,
    'G': 0,
    'B': 0,
  };

  void addLetter(letter) {
    _values.add(letter);
    segregate();
  }

  void segregate() {
    for (var i = 0; i < _values.length; i++) {
      var letter = _values[i];
      _values.insert(_pointers[letter], letter);
      _pointers[letter]++;
      if (letter == 'R') {
        _pointers['G']++;
        _pointers['B']++;
      }
      if (letter == 'G') {
        _pointers['B']++;
      }
      _values.removeAt(i + 1);
    }
  }

  void shuffle() {
    var random = new Random();
    for (var i = 0; i < _values.length; i++) {
      var r = random.nextInt(_values.length);
      var temp = _values[i];
      _values[i] = _values[r];
      _values[r] = temp;
    }
  }

  Widget view = SegregateRGBView();
}

class SegregateRGBView extends StatefulWidget {
  @override
  _SegregateRGBViewState createState() => _SegregateRGBViewState();
}

class _SegregateRGBViewState extends State<SegregateRGBView> {
  SegregateRGB rgb = SegregateRGB();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 4,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
            ),
            child: Text(rgb.taskDescription),
          ),
        ),
        Expanded(
          flex: 6,
          child: rgb.build(context, () {
            setState(() {});
          }),
        ),
        Expanded(
          flex: 1,
          child: RaisedButton(
            color: Colors.blue,
            child: Text('Segregate'),
            onPressed: () {
              rgb.segregate();
              setState(() {});
            },
          ),
        ),
        Expanded(
          flex: 1,
          child: RaisedButton(
            color: Colors.red,
            child: Text('Shuffle'),
            onPressed: () {
              setState(() {
                rgb = SegregateRGB();
                rgb.shuffle();
              });
            },
          ),
        ),
      ],
    );
  }
}
