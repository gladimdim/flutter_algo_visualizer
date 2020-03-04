import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_algo_visualizer/moldable.dart';

class PowerSet extends Moldable {
  final String shortName = 'Powerset of a set.';
  final String taskDescription = '''
      The power set of a set is the set of all its subsets. Write a function that, given a set, generates its power set.
      For example, given the set {1, 2, 3}, it should return {{}, {1}, {2}, {3}, {1, 2}, {1, 3}, {2, 3}, {1, 2, 3}}
    ''';

  PowerSet(List initialValue) {
    _list = initialValue;
  }

  Widget view = PowerSetView();

  List _list = List();

  Widget build(context, callback) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            powerSet.toString(),
          ),
          Text('Lengh of power set: ${powerSet.length.toString()}'),
        ],
      ),
    );
  }

  addValue(int value) {
    _list.add(value);
  }

  List get powerSet {
    var result = [];
    for (var i = 0; i < pow(2, _list.length); i++) {
      List r2 = [];
      for (var j = 0; j < _list.length; j++) {
        if ((i >> j) % 2 == 1) {
          r2.add(_list[j]);
        }
      }
      result.add(r2);
    }

    return result;
  }

  List<List> dedup(List<List> input) {
    Function eq = const ListEquality().equals;
    List<List> result = [];
    for (var i = 0; i < input.length; i++) {
      List iValue = input[i];
      var notEqual = true;
      for (var r = 0; r < result.length; r++) {
        List rValue = result[r];
        if (eq(rValue, iValue)) {
          notEqual = false;
          break;
        }
      }

      if (notEqual) {
        result.add(input[i]);
      }
    }

    return result;
  }
}

class PowerSetView extends StatefulWidget {
  @override
  _PowerSetViewState createState() => _PowerSetViewState();
}

class _PowerSetViewState extends State<PowerSetView> {
  PowerSet powerSet = PowerSet(List());
  var counter = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        powerSet.build(context, () {}),
        SizedBox(
          height: 120,
        ),
        Text(powerSet.taskDescription),
        RaisedButton(
          child: Text('Add to set: ${counter + 1}'),
          onPressed: () {
            setState(() {
              var r = Random().nextInt(10);
              counter++;
              powerSet.addValue(counter);
            });
          },
        ),
        RaisedButton(
          child: Text('Reset'),
          onPressed: () {
            setState(() {
              powerSet = PowerSet(List());
              counter = 0;
            });
          },
        )
      ],
    );
  }
}
