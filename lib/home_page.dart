import 'package:flutter/material.dart';
import 'package:unity_test_study/bloc_provider.dart';
import 'package:unity_test_study/person_bloc.dart';
import 'package:unity_test_study/person_state.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.get(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Persons List'),
        actions: [
          StreamBuilder<PersonState>(
            stream: bloc.stream,
            builder: (context, snapshot) {
              final isEnabled = bloc.state is PersonListState &&
                  (bloc.state as PersonListState).data.isNotEmpty;

              return IconButton(
                onPressed: isEnabled ? () => bloc.add(PersonEvent.clear) : null,
                icon: const Icon(Icons.refresh_outlined),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: StreamBuilder<PersonState>(
          stream: bloc.stream,
          builder: (context, snapshot) {
            if (bloc.state is PersonErrorState) {
              return _ErrorWidget();
            } else if (bloc.state is PersonLoadingState) {
              return const CircularProgressIndicator();
            }

            return _ListWidget();
          },
        ),
      ),
    );
  }
}

class _ErrorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.get(context);
    final textError = (bloc.state as PersonErrorState).error.toString();

    return Text(textError ?? 'Unknown Error');
  }
}

class _ListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.get(context);
    final personList = (bloc.state as PersonListState).data;

    if (personList.isEmpty) {
      return TextButton(
        onPressed: () => bloc.add(PersonEvent.fetch),
        child: const Text('Fetch persons'),
      );
    }

    return ListView.builder(
      itemCount: personList.length,
      itemBuilder: (context, index) {
        final person = personList[index];

        return ListTile(
          title: Text(person.name),
          subtitle: Text(person.isOlder ? 'Adult' : 'Minor'),
        );
      },
    );
  }
}
