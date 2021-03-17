import 'package:flutter/material.dart';

import 'bmicalcapppage.dart';

class BmiCalcApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI CALCULATOR'),
        centerTitle: true,
      ),
      body: BmiCalcAppPage(),
    );
  }
}
