import 'package:flutter/material.dart';
import 'dart:math';

final colorsArray = [Colors.red.shade500, Colors.green.shade500, Colors.yellow.shade500, Colors.blue.shade500, Colors.purple.shade500, Colors.orange.shade500, Colors.indigo.shade500, Colors.deepOrange.shade500, Colors.red.shade900, Colors.green.shade900, Colors.yellow.shade900, Colors.blue.shade900, Colors.purple.shade900, Colors.orange.shade900, Colors.indigo.shade900, Colors.deepOrange.shade900];

final _random = new Random();

int next(int min, int max) => min + _random.nextInt(max - min);

Color generateColor() {
  return colorsArray[next(0, colorsArray.length -1)];
}
