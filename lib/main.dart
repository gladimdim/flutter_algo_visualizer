import 'package:flutter/material.dart';
import 'package:flutter_algo_visualizer/median.dart';
import 'package:flutter_algo_visualizer/moldable.dart';
import 'package:flutter_algo_visualizer/second_largest_bst_node.dart';
import 'package:flutter_algo_visualizer/segregate_array.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Moldable> elements = [
    Median(),
    SegregateRGB(),
    BST(50),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FractionallySizedBox(
        heightFactor: 1,
        widthFactor: 1,
        child: ListView(
          children: elements.map((element) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Colors.yellow,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 9,
                      child: Container(
                        color: Colors.blue,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              element.shortName,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: IconButton(
                        icon: Icon(Icons.arrow_right),
                        onPressed: () async {
                          await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      element.appScreen(context)));
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
