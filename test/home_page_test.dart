import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:unity_test_study/bloc_provider.dart';
import 'package:unity_test_study/home_page.dart';
import 'package:unity_test_study/person.dart';
import 'package:unity_test_study/person_bloc.dart';
import 'package:unity_test_study/person_repository.dart';

class PersonRepositoryMock extends Mock implements PersonRepository {}

void main() {
  PersonRepositoryMock repository;
  PersonBloc bloc;
  Person person;

  setUp(() {
    repository = PersonRepositoryMock();
    bloc = PersonBloc(repository: repository);
    person = Person(id: 1, name: 'Victor', age: 18, height: 1.77, weight: 64.4);
  });

  tearDown(() {
    bloc.close();
  });

  testWidgets('Should show correct states on screen', (tester) async {
    when(repository.getPersons()).thenAnswer((_) async => [person]);

    await tester.pumpWidget(MaterialApp(
      home: BlocProvider(bloc: bloc, child: HomePage()),
    ));

    final textButton = find.byType(TextButton);
    final loading = find.byType(CircularProgressIndicator);
    final personList = find.byType(ListView);

    expect(textButton, findsOneWidget);
    expect(loading, findsNothing);
    expect(personList, findsNothing);

    await tester.tap(textButton);
    await tester.runAsync(() => bloc.stream.first);
    await tester.pump();

    expect(loading, findsOneWidget);

    await tester.runAsync(() => bloc.stream.first);
    await tester.pump();

    expect(personList, findsOneWidget);
  });
}
