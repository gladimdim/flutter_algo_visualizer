import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_algo_visualizer/median.dart';
import 'package:flutter_algo_visualizer/second_largest_bst_node.dart';
import 'package:flutter_algo_visualizer/segregate_array.dart';

abstract class Moldable {
  /// Method must return Stateless widget.
  /// Callback must be called by your molded view to retrigger state change
  Widget build(BuildContext context, Function callback);

  /// Full description of the algorithmic task
  String taskDescription;

  /// Short name of the algorithm task
  String shortName;

  /// Statefull view. May contain action button to interact with your algorithm solution.
  /// It is used in appScreen method as a body for Scaffold.
  Widget view;

  /// Used for navigation to your solution for algorithm.
  /// Uses view as a default value for the body of Scaffold.
  Widget appScreen(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(shortName),
      ),
      body: view,
    );
  }

  /// Lists of all registered moldable classes
  static List<Moldable> allSubclasses = [
    Median(),
    BST(50),
    SegregateRGB(),
  ];

  @override
  String toString() {
    return shortName;
  }
}
