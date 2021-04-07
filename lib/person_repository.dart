import 'dart:convert';

import 'package:http/http.dart';
import 'package:unity_test_study/person.dart';

class PersonRepository {
  final Client client = Client();

  Future<List<Person>> getPersons() async {
    final response = await client.get(
      Uri.tryParse('https://5ecafaf138df960016511b4c.mockapi.io/api/v1/person'),
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as List;

      return json.map((personMap) => Person.fromMap(personMap as Map)).toList();
    }

    throw Exception('Error to get persons');
  }
}
