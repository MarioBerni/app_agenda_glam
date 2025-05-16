import 'package:app_agenda_glam/features/auth/domain/entities/user.dart';
import 'package:equatable/equatable.dart';

/// Tipos de estados de autenticación
enum AuthStatus { initial, loading, authenticated, unauthenticated, error }

/// Estados para el flujo de autenticación
class AuthState extends Equatable {
  final AuthStatus status;
  final User? user;
  final String? errorMessage;

  const AuthState({
    this.status = AuthStatus.initial,
    this.user,
    this.errorMessage,
  });

  /// Estado inicial de autenticación
  factory AuthState.initial() => const AuthState(status: AuthStatus.initial);

  /// Estado de carga durante operaciones de autenticación
  factory AuthState.loading() => const AuthState(status: AuthStatus.loading);

  /// Usuario autenticado exitosamente
  factory AuthState.authenticated(User user) =>
      AuthState(status: AuthStatus.authenticated, user: user);

  /// Usuario no autenticado
  factory AuthState.unauthenticated() =>
      const AuthState(status: AuthStatus.unauthenticated);

  /// Error durante operaciones de autenticación
  factory AuthState.error(String message) =>
      AuthState(status: AuthStatus.error, errorMessage: message);

  @override
  List<Object?> get props => [status, user, errorMessage];
}
