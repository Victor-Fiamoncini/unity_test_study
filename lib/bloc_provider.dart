import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:unity_test_study/person_bloc.dart';

class BlocProvider extends InheritedWidget {
  final PersonBloc bloc;

  const BlocProvider({
    @required this.bloc,
    @required Widget child,
  }) : super(child: child);

  static PersonBloc get(BuildContext context) {
    final provider = context.dependOnInheritedWidgetOfExactType<BlocProvider>();

    if (provider != null) {
      return provider.bloc;
    }

    throw Exception('Bloc not found');
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return (oldWidget as BlocProvider).bloc.state != bloc.state;
  }
}
