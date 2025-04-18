import 'package:example/domain/models/auth_entity.dart';
import 'package:fake_store_api_package/infraestructure/helppers/mappers/auth/auth_fake_store.dart';

class AuthMapper {
  static Auth authFakeStoreToAuth(TokenFakeStore tokenFakeStore) {
    return Auth(token: tokenFakeStore.token);
  }
}
