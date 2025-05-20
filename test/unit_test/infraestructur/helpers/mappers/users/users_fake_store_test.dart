import 'package:fake_store_api_package/infraestructure/helpers/mappers/users/users_fake_store.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('throws TypeError with invalid JSON for the user response', () {
    // Arrange
    // Mock the API response
    final mockResponse = {
      'addresss': {
        'city': 'City',
        'street': 'Street',
        'number': 123,
        'zipcode': '12345',
      },
      'ids': 1,
      'emails': 'email@gmail.com',
      'usernames': 'username',
      'passwords': 'password',
      'names': {'firstnames': 'firstname', 'lastnames': 'lastname'},
      'phones': '633554556',
    };
    //Assert
    expect(
      () => UsersFakeStore.fromJson(mockResponse),
      throwsA(isA<TypeError>()),
    );
  });
  test('correctly parses valid JSON for the user response', () {
    // Act
    // Mock the API response
    final mockResponse = {
      'address': {
        'city': 'City',
        'street': 'Street',
        'number': 123,
        'zipcode': '12345',
      },
      'id': 1,
      'email': 'email@gmail.com',
      'username': 'username',
      'password': 'password',
      'name': {'firstname': 'firstname', 'lastname': 'lastname'},
      'phone': '633554556',
    };
    //Act
    final user = UsersFakeStore.fromJson(mockResponse);
    //Assert
    expect(user, isA<UsersFakeStore>());
    //Address
    expect(user.apiAddress.city, 'City');
    expect(user.apiAddress.street, 'Street');
    expect(user.apiAddress.number, 123);
    expect(user.apiAddress.zipcode, '12345');
    //name
    expect(user.apiName.lastname, 'lastname');
    expect(user.apiName.firstname, 'firstname');
    //user
    expect(user.id, 1);
    expect(user.email, 'email@gmail.com');
    expect(user.username, 'username');
    expect(user.password, 'password');
    expect(user.phone, '633554556');
  });
  test('throws when a required field is null', () {
    // Act
    final mockResponse = {
      'address': {
        'city': 'City',
        'street': 'Street',
        'number': 123,
        'zipcode': '12345',
      },
      'id': null,
      'email': 'email@gmail.com',
      'username': 'username',
      'password': 'password',
      'name': {'firstname': 'firstname', 'lastname': 'lastname'},
      'phone': '633554556',
    };

    //Assert
    expect(
      () => UsersFakeStore.fromJson(mockResponse),
      throwsA(isA<TypeError>()),
    );
  });
  test('serializes CartsFakeStore to correct JSON', () {
    // Act
    // Mock the API response
    final user = UsersFakeStore(
      apiAddress: ApiAddress(
        city: 'City',
        street: 'Street',
        number: 123,
        zipcode: '12345',
      ),
      id: 1,
      email: 'email@gmail.com',
      username: 'username',
      password: 'password',
      apiName: ApiName(firstname: 'firstname', lastname: 'lastname'),
      phone: '633554556',
    );

    // Arrange
    final json = user.toJson();

    //Assert
    expect(json, {
      'address': {
        'city': 'City',
        'street': 'Street',
        'number': 123,
        'zipcode': '12345',
      },
      'id': 1,
      'email': 'email@gmail.com',
      'username': 'username',
      'password': 'password',
      'name': {'firstname': 'firstname', 'lastname': 'lastname'},
      'phone': '633554556',
    });
  });
}
