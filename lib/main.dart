import 'package:flutter/material.dart';
import 'package:startup_namer/ui/random_words_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Startup Name Generator',
      home: RandomWordsList(),
    );
  }
}
