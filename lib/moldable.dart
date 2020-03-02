import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_algo_visualizer/median.dart';
import 'package:flutter_algo_visualizer/second_largest_bst_node.dart';

abstract class Moldable {
  Widget build(BuildContext context, Function callback);
  String taskDescription;
  String shortName;
  Widget view;

  Widget appScreen(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(shortName),
      ),
      body: view,
    );
  }

  static List<Moldable> allSubclasses() {
    return [
      Median(),
      BST(50),
    ];
  }

  @override
  String toString() {
    return taskDescription;
  }
}
