import 'dart:ui';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:receipt_spliterator/utils/color_generator.dart';

class User {
  final int id;
  final String name;
  final String shortName;
  final Color color = generateColor();

  User(this.id, this.name, this.shortName);

  @override
  String toString() {
    return 'User{id: $id, name: $name, color: $color}';
  }
}