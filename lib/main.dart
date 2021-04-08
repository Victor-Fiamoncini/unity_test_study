import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:unity_test_study/bloc_provider.dart';
import 'package:unity_test_study/home_page.dart';
import 'package:unity_test_study/person_bloc.dart';
import 'package:unity_test_study/person_repository.dart';

void main() {
  runApp(App());
}

Bloc makePersonBloc() {
  final repository = PersonRepository(
    client: Client(),
    url: 'https://5ecafaf138df960016511b4c.mockapi.io/api/v1/person',
  );

  return PersonBloc(repository: repository);
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(bloc: makePersonBloc(), child: HomePage()),
    );
  }
}
