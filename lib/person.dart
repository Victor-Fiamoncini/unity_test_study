import 'dart:math' as math;

import 'package:meta/meta.dart';

class Person {
  final String name;
  final int age;
  final double height;
  final double weight;

  Person({
    @required this.name,
    @required this.age,
    @required this.height,
    @required this.weight,
  });

  double get imc {
    final result = (weight / math.pow(height, 2)) * 100;

    return result.roundToDouble() / 100;
  }
}
