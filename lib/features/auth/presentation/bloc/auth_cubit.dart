import 'package:app_agenda_glam/features/auth/domain/entities/credentials.dart';
import 'package:app_agenda_glam/features/auth/domain/repositories/auth_repository.dart';
import 'package:app_agenda_glam/features/auth/presentation/bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Cubit que gestiona el estado de autenticación
/// Orquesta las operaciones de autenticación utilizando el repositorio
class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;

  AuthCubit(this._authRepository) : super(AuthState.initial());

  /// Verifica si el usuario está actualmente autenticado
  Future<void> checkAuthStatus() async {
    emit(AuthState.loading());
    try {
      final user = await _authRepository.getCurrentUser();
      if (user != null && user.isAuthenticated) {
        emit(AuthState.authenticated(user));
      } else {
        emit(AuthState.unauthenticated());
      }
    } catch (e) {
      emit(AuthState.error(e.toString()));
    }
  }

  /// Inicia sesión con email y contraseña
  Future<void> login(String email, String password) async {
    emit(AuthState.loading());
    try {
      // Valida el formato del email
      if (!_isValidEmail(email)) {
        emit(AuthState.error('El formato del email no es válido'));
        return;
      }

      // Valida que la contraseña no esté vacía
      if (password.isEmpty) {
        emit(AuthState.error('La contraseña no puede estar vacía'));
        return;
      }

      final credentials = Credentials(email: email, password: password);
      final user = await _authRepository.login(credentials);
      emit(AuthState.authenticated(user));
    } catch (e) {
      emit(AuthState.error(e.toString()));
    }
  }

  /// Registra un nuevo usuario
  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    emit(AuthState.loading());
    try {
      // Validaciones básicas
      if (name.isEmpty) {
        emit(AuthState.error('El nombre no puede estar vacío'));
        return;
      }

      if (!_isValidEmail(email)) {
        emit(AuthState.error('El formato del email no es válido'));
        return;
      }

      if (password.isEmpty) {
        emit(AuthState.error('La contraseña no puede estar vacía'));
        return;
      }

      if (password != confirmPassword) {
        emit(AuthState.error('Las contraseñas no coinciden'));
        return;
      }

      final user = await _authRepository.register(
        name: name,
        email: email,
        password: password,
      );
      emit(AuthState.authenticated(user));
    } catch (e) {
      emit(AuthState.error(e.toString()));
    }
  }

  /// Cierra la sesión del usuario actual
  Future<void> logout() async {
    emit(AuthState.loading());
    try {
      await _authRepository.logout();
      emit(AuthState.unauthenticated());
    } catch (e) {
      emit(AuthState.error(e.toString()));
    }
  }

  /// Envía un correo para recuperar la contraseña
  Future<void> recoverPassword(String email) async {
    emit(AuthState.loading());
    try {
      if (!_isValidEmail(email)) {
        emit(AuthState.error('El formato del email no es válido'));
        return;
      }

      await _authRepository.recoverPassword(email);
      // Volvemos al estado no autenticado después de enviar el correo
      emit(AuthState.unauthenticated());
    } catch (e) {
      emit(AuthState.error(e.toString()));
    }
  }

  /// Valida el formato del email utilizando una expresión regular
  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }
}
