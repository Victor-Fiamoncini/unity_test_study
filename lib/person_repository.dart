import 'dart:convert';

import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:unity_test_study/person.dart';

class PersonRepository {
  final Client client;
  final String url;

  PersonRepository({@required this.client, @required this.url});

  Future<List<Person>> getPersons() async {
    final response = await client.get(Uri.tryParse(url));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as List;

      return json.map((personMap) => Person.fromMap(personMap as Map)).toList();
    }

    throw Exception('Error to get persons');
  }
}
