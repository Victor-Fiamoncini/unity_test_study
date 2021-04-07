import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:unity_test_study/person_repository.dart';
import 'package:unity_test_study/person_state.dart';

enum PersonEvent { clear, fetch }

class PersonBloc extends Bloc<PersonEvent, PersonState> {
  final PersonRepository repository;

  PersonBloc({@required this.repository}) : super(PersonListState([]));

  @override
  Stream<PersonState> mapEventToState(PersonEvent event) async* {
    if (event == PersonEvent.clear) {
      yield PersonListState([]);
    } else if (event == PersonEvent.fetch) {
      yield PersonLoadingState();

      try {
        final persons = await repository.getPersons();

        yield PersonListState(persons);
      } catch (e) {
        yield PersonErrorState(e);
      }
    }
  }
}
