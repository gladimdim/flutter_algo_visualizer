import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_algo_visualizer/moldable.dart';

class NumberValue<T> {
  T value;

  NumberValue(this.value);

  Widget build(BuildContext context) {
    return Text(value.toString());
  }
}

class Median implements Moldable {
  List left = [];
  List right = [];

  void addNumber(int number) {
    var numberValue = NumberValue(number);
    if (left.isEmpty && right.isEmpty) {
      right.add(numberValue);
      return;
    }
    if (numberValue.value < median.value) {
      left.add(numberValue);
      left.sort((a, b) => a.value.compareTo(b.value));
      if (left.length - right.length >= 1) {
        right.insert(0, left.last);
        left.removeLast();
      }
    } else {
      right.add(numberValue);
      right.sort((a, b) => a.value.compareTo(b.value));
      if (right.length - left.length > 1) {
        left.add(right.first);
        right.removeAt(0);
      }
    }
  }

  NumberValue get median {
    if (left.isEmpty && right.isEmpty) {
      return null;
    }

    if (right.length - left.length == 0) {
      return NumberValue<double>((left.last.value + right.first.value) / 2.0);
    } else {
      return right.first;
    }
  }

  Widget _buildNumber(element, last, lSize, rSize, {bIsRight = false}) {
    var style;
    var decoration;
    if (lSize == rSize && last == element) {
      style = TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0);
      decoration = BoxDecoration(
        border: Border.all(
          color: Colors.yellow,
          style: BorderStyle.solid,
          width: 3,
        ),
      );
    } else if (bIsRight && element == last) {
      style = TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0);
      decoration = BoxDecoration(
        border: Border.all(
          color: Colors.yellow,
          style: BorderStyle.solid,
          width: 3,
        ),
      );
    }
    return Container(
      decoration: decoration,
      child: Text(
        element.value.toString(),
        style: style,
      ),
    );
  }

  Widget build(BuildContext context, Function action) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 4,
                child: Container(
                  color: Colors.red,
                  child: Column(
                    children: left.reversed.map(
                      (l) {
                        return _buildNumber(
                            l, left.last, left.length, right.length);
                      },
                    ).toList(),
                  ),
                ),
              ),
              Expanded(
                flex: 8,
                child: Column(
                  children: [
                    if (left.isNotEmpty &&
                        right.isNotEmpty &&
                        left.length == right.length)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('('),
                          left.last.build(context),
                          Text(' + '),
                          right.first.build(context),
                          Text(') / 2 = '),
                          median.build(context),
                        ],
                      ),
                    if (median != null) median.build(context),
                  ],
                ),
              ),
              Expanded(
                  flex: 4,
                  child: Container(
                    color: Colors.green,
                    child: Column(
                      children: right.map(
                        (l) {
                          return _buildNumber(
                            l,
                            right.first,
                            left.length,
                            right.length,
                            bIsRight: true,
                          );
                        },
                      ).toList(),
                    ),
                  )),
            ],
          ),
        ),
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Text(
                '''Compute the running median of a sequence of numbers. \n\nThat is, given a stream of numbers, print out the median of the list so far on each new element.
                  \n\nRecall that the median of an even-numbered list is the average of the two middle numbers.
                  \n\nFor example, given the sequence [2, 1, 5, 7, 2, 0, 5], your algorithm should print out:(2, 1.5, 2, 3.5, 2, 2, 2)''',
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: FlatButton(
            color: Colors.yellow,
            child: Text('Add random number'),
            onPressed: () {
              var i = Random().nextInt(200);
              addNumber(i);
              action();
            },
          ),
        ),
      ],
    );
  }
}

class MedianView extends StatefulWidget {
  @override
  _MedianViewState createState() => _MedianViewState();
}

class _MedianViewState extends State<MedianView> {
  final Moldable median = Median();
  final Moldable median2 = Median();
  final Moldable median3 = Median();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: median.build(
            context,
            () {
              setState(() {});
            },
          ),
        ),
        Expanded(
          flex: 1,
          child: median2.build(
            context,
            () {
              setState(() {});
            },
          ),
        ),
      ],
    );
  }
}
