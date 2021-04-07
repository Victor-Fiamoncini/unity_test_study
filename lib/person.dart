import 'dart:math' as math;

import 'package:meta/meta.dart';

class Person {
  final int id;
  final String name;
  final int age;
  final double height;
  final double weight;

  Person({
    @required this.id,
    @required this.name,
    @required this.age,
    @required this.height,
    @required this.weight,
  });

  factory Person.fromMap(Map map) {
    return Person(
      id: int.tryParse(map['name'].toString()),
      name: map['name'] as String,
      age: map['age'] as int,
      height: double.tryParse(map['height'].toString()),
      weight: double.tryParse(map['weight'].toString()),
    );
  }

  double get imc {
    final imcResult = (weight / math.pow(height, 2)) * 100;

    return imcResult.roundToDouble() / 100;
  }

  bool get isOlder => age >= 18;
}
