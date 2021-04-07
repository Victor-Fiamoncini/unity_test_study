import 'package:test/test.dart';
import 'package:unity_test_study/person_repository.dart';

void main() {
  PersonRepository sut;

  setUp(() {
    sut = PersonRepository();
  });

  tearDown(() {});

  test('Should get a list os persons', () async {
    final persons = await sut.getPersons();

    expect(persons.isNotEmpty, equals(true));
    expect(persons.first.name, isA<String>());
  });
}
