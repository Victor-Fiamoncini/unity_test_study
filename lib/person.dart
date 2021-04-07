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

  factory Person.fromMap(Map map) {
    return Person(
      name: map['name'] as String,
      age: map['age'] as int,
      height: map['height'] as double,
      weight: map['weight'] as double,
    );
  }

  double get imc {
    final imcResult = (weight / math.pow(height, 2)) * 100;

    return imcResult.roundToDouble() / 100;
  }

  bool get isOlder => age >= 18;
}
