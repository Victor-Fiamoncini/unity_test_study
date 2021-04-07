import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:unity_test_study/person_repository.dart';

class ClientMock extends Mock implements Client {}

void main() {
  PersonRepository sut;
  ClientMock client;

  const defaultBody =
      '[{"id":"1","name":"Xander Ledner","age":2800,"height":13575,"weight":40867}]';

  void mockResponse({String body = defaultBody}) {
    when(client.get(any)).thenAnswer((_) async => Response(body, 200));
  }

  setUp(() {
    client = ClientMock();
    sut = PersonRepository(client: client);

    mockResponse();
  });

  test('Should get a list os persons', () async {
    final persons = await sut.getPersons();

    expect(persons.isNotEmpty, equals(true));
    expect(persons.first.name, isA<String>());
  });
}
