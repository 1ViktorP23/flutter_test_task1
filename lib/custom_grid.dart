import 'package:flutter/material.dart';

class CustomGrid {
  final double row;
  final double column;

  const CustomGrid({this.row = 1, this.column = 1});

  static final double rowsCount = 8;

  static final List<Color> colors = [
    Colors.red,
    Colors.blue,
    Colors.yellow,
    Colors.purple,
    Colors.orange,
    Colors.green,
    Colors.greenAccent,
    Colors.brown,
  ];

  static final List<CustomGrid> boxes = [
    CustomGrid(row: 1, column: 1),
    CustomGrid(row: 3, column: 3),
    CustomGrid(row: 6, column: 3),
    CustomGrid(row: 8, column: 1),
    CustomGrid(row: 8, column: 8),
    CustomGrid(row: 6, column: 6),
    CustomGrid(row: 3, column: 6),
    CustomGrid(row: 1, column: 8),
  ];
}
