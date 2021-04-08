import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:unity_test_study/person.dart';
import 'package:unity_test_study/person_bloc.dart';
import 'package:unity_test_study/person_repository.dart';
import 'package:unity_test_study/person_state.dart';

class PersonRepositoryMock extends Mock implements PersonRepository {}

void main() {
  PersonBloc sut;
  PersonRepositoryMock repository;
  Person person;

  setUp(() {
    repository = PersonRepositoryMock();
    sut = PersonBloc(repository: repository);
    person = Person(id: 1, name: 'Victor', age: 18, height: 1.77, weight: 64.4);
  });

  tearDown(() {
    sut.close();
  });

  test('Should emit a list of persons', () async {
    when(repository.getPersons()).thenAnswer((_) async => [person]);

    sut.add(PersonEvent.fetch);

    await expectLater(
      sut.stream,
      emitsInOrder([
        isA<PersonLoadingState>(),
        isA<PersonListState>(),
      ]),
    );
  });

  test('Should throw if Blog throws', () async {
    when(repository.getPersons()).thenThrow(Exception());

    sut.add(PersonEvent.fetch);

    await expectLater(
      sut.stream,
      emitsInOrder([
        isA<PersonLoadingState>(),
        isA<PersonErrorState>(),
      ]),
    );
  });
}
