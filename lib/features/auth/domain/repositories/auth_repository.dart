import 'package:app_agenda_glam/features/auth/domain/entities/credentials.dart';
import 'package:app_agenda_glam/features/auth/domain/entities/user.dart';

/// Define las operaciones relacionadas con la autenticación
/// En Clean Architecture, esto define el contrato para los repositorios concretos
abstract class AuthRepository {
  /// Autentica al usuario con email y contraseña
  /// Retorna un [User] si la autenticación es exitosa
  Future<User> login(Credentials credentials);

  /// Registra un nuevo usuario
  /// Retorna el [User] creado
  Future<User> register({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String userType,
  });

  /// Cierra la sesión del usuario actual
  Future<void> logout();

  /// Envía un correo para recuperar la contraseña
  Future<void> recoverPassword(String email);

  /// Verifica si hay un usuario actualmente autenticado
  Future<User?> getCurrentUser();
}
