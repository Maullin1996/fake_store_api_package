import 'package:fake_store_api_package/config/constants/api_config.dart';
import 'package:fake_store_api_package/errors/structure/fetch_fake_store_exception.dart';
import 'package:fake_store_api_package/infraestructure/driven-adapter/api/auth_fake_store_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:http/testing.dart';

@GenerateMocks([http.Client])
void main() {
  late AuthFakeStoreApi authFakeStoreApi;
  late http.Client mockClient;

  group('authentication()', () {
    const mockJsonToken = '''
    {
      "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9"
    }
    ''';

    setUp(() {
      mockClient = MockClient((request) async {
        // Parse x-www-form-urlencoded body
        final Map<String, String> body = Uri.splitQueryString(request.body);

        if (request.url.path == '/auth/login' &&
            request.method == 'POST' &&
            body['username'] == 'kateh' &&
            body['password'] == 'kfejk@*') {
          return http.Response(mockJsonToken, 200);
        } else {
          return http.Response('Not Found', 404);
        }
      });

      authFakeStoreApi = AuthFakeStoreApi(
        baseUrl: ApiConfig.baseUrl,
        client: mockClient,
      );
    });

    test('returns a TokenFakeStore object if call is successful', () async {
      final token = await authFakeStoreApi.authentication(
        username: 'kateh',
        password: 'kfejk@*',
      );

      expect(token.token, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9');
    });

    test('throws FetchFakeStoreException on error', () async {
      expect(
        () async => await authFakeStoreApi.authentication(
          username: 'wrong_user',
          password: 'wrong_pass',
        ),
        throwsA(isA<FetchFakeStoreException>()),
      );
    });
  });
}
