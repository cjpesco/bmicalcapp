import 'package:flutter/material.dart';

import 'ui/home.dart';

void main() => runApp(
      MaterialApp(
        home: BmiCalcApp(),
        theme: ThemeData.dark().copyWith(
          primaryColor: Color(0xFF0A0E21),
          scaffoldBackgroundColor: Color(0xFF0A0E21),
        ),
      ),
    );
