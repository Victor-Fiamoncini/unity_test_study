import 'package:test/test.dart';
import 'package:unity_test_study/person.dart';

void main() {
  Person sut;

  setUp(() {
    sut = Person(name: 'Victor', age: 24, height: 1.77, weight: 64.4);
  });

  tearDown(() {});

  test('Should calcalate IMC and give 20.56', () {
    expect(sut.imc, 20.56);
  });

  group('Is Older', () {
    test('Should "isOlder" be true if age is more than 18', () {
      expect(sut.isOlder, true);
    });

    test('Should "isOlder" be true if age is equal than 18', () {
      sut = Person(name: 'Victor', age: 18, height: 1.77, weight: 64.4);

      expect(sut.isOlder, true);
    });
  });
}
