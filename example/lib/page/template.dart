import 'package:flutter/material.dart';

class Template extends StatefulWidget {
  @override
  _Template createState() => _Template();
}

class _Template extends State<Template> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Template'),
        ),
        body: Text('Template'));
  }
}
