import 'package:app_agenda_glam/features/auth/data/datasources/auth_mock_datasource.dart';
import 'package:app_agenda_glam/features/auth/domain/entities/credentials.dart';
import 'package:app_agenda_glam/features/auth/domain/entities/user.dart';
import 'package:app_agenda_glam/features/auth/domain/repositories/auth_repository.dart';

/// Implementación concreta del repositorio de autenticación
/// Utiliza un datasource mock para simular las operaciones
class AuthRepositoryImpl implements AuthRepository {
  final AuthMockDataSource _dataSource;

  AuthRepositoryImpl(this._dataSource);

  @override
  Future<User> login(Credentials credentials) async {
    try {
      final user = await _dataSource.login(
        email: credentials.email,
        password: credentials.password,
      );
      return user;
    } catch (e) {
      // En una implementación real, podríamos manejar diferentes tipos de errores
      // y transformarlos en excepciones de dominio específicas
      rethrow;
    }
  }

  @override
  Future<User> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final user = await _dataSource.register(
        name: name,
        email: email,
        password: password,
      );
      return user;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _dataSource.logout();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> recoverPassword(String email) async {
    try {
      await _dataSource.recoverPassword(email);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<User?> getCurrentUser() async {
    try {
      return await _dataSource.getCurrentUser();
    } catch (e) {
      rethrow;
    }
  }
}
