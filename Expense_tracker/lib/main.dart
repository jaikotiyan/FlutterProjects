import 'package:flutter/material.dart';
import 'package:expense_tracker_app/widgets/expenditure.dart';


void main() {
  runApp(
    MaterialApp(
      theme: ThemeData().copyWith(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(174, 15, 90, 201),
        ),
      ),
      home: const Expenses(),
    ),
  );
}
