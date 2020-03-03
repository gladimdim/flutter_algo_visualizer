import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_algo_visualizer/moldable.dart';

class BST extends Moldable {
  String taskDescription =
      'Given the root to a binary search tree, find the second largest node in the tree.';

  String shortName = 'Largest second node in BST';
  BST left;
  BST right;
  Color _color;

  int value;

  BST(this.value) {
    var r = Random().nextInt(255);
    var g = Random().nextInt(255);
    var b = Random().nextInt(255);
    _color = Color.fromRGBO(r, g, b, 1);
  }

  add(int element) {
    if (value == null) {
      value = element;
      return;
    }

    if (value > element) {
      if (left == null) {
        left = BST(element);
        return;
      }
      left.add(element);
      return;
    }

    if (value < element) {
      if (right == null) {
        right = BST(element);
        return;
      }
      right.add(element);
    }
    return;
  }

  Widget build(BuildContext context, Function callback) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: _color,
          style: BorderStyle.solid,
          width: 3,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Center(
              child: RaisedButton(
            child: Text('$value'),
            onPressed: () {
              callback(this);
            },
          )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              if (left != null)
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: left.build(
                          context,
                          (newRoot) {
                            callback(newRoot);
                          },
                        ),
                      )
                    ],
                  ),
                ),
              if (left == null)
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Text(''),
                  ),
                ),
              if (right != null)
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: right.build(
                          context,
                          (newRoot) {
                            callback(newRoot);
                          },
                        ),
                      )
                    ],
                  ),
                ),
              if (right == null)
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Text(''),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  largest() {
    if (right == null) {
      return this.value;
    } else {
      return right.largest();
    }
  }

  secondLargest() {
    if (right == null && left == null) {
      return null;
    }
    if (right.right == null) {
      if (right.left == null) {
        return this.value;
      } else {
        return this.right.left.largest();
      }
    } else {
      return this.right.secondLargest();
    }
  }

  Widget view = SecondLargestNode();
}

class SecondLargestNode extends StatefulWidget {
  @override
  _SecondLargestNodeState createState() => _SecondLargestNodeState();
}

class _SecondLargestNodeState extends State<SecondLargestNode> {
  BST bst = BST(50);

  _onNewRootPressed(BST newRoot) {
    setState(() {
      bst = newRoot;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 9,
          child: bst.build(context, _onNewRootPressed),
        ),
        Expanded(
          flex: 1,
          child: Center(
            child: Text(
              bst.taskDescription,
            ),
          ),
        ),
        if (bst.secondLargest() != null)
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.grey,
              child: Center(
                child: Text(
                  'Second largest node is: ${bst.secondLargest().toString()}',
                ),
              ),
            ),
          ),
        SizedBox(
          height: 64,
        ),
        Expanded(
          flex: 1,
          child: RaisedButton(
            color: Colors.green,
            child: Text('Add random number'),
            onPressed: () {
              var r = Random().nextInt(100);
              bst.add(r);
              setState(() {});
              final snackBar = SnackBar(
                duration: Duration(
                  milliseconds: 200,
                ),
                content: Text('Aded: $r'),
              );
              Scaffold.of(context).showSnackBar(snackBar);
            },
          ),
        ),
        Expanded(
          flex: 1,
          child: RaisedButton(
            color: Colors.red,
            child: Text('Reset'),
            onPressed: () {
              setState(() {
                bst = BST(50);
              });
            },
          ),
        )
      ],
    );
  }
}
