import 'package:app_agenda_glam/core/routes/routes/app_routes.dart';
import 'package:app_agenda_glam/features/auth/domain/entities/credentials.dart';
import 'package:app_agenda_glam/features/auth/domain/repositories/auth_repository.dart';
import 'package:app_agenda_glam/features/auth/presentation/bloc/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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
    required String phone,
    required String userType,
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
      
      if (phone.isEmpty) {
        emit(AuthState.error('El número de teléfono no puede estar vacío'));
        return;
      }
      
      // Validar formato de teléfono (básico)
      if (!RegExp(r'^[0-9]{8,}$').hasMatch(phone)) {
        emit(AuthState.error('El formato del teléfono no es válido'));
        return;
      }
      
      if (userType.isEmpty) {
        emit(AuthState.error('Debes seleccionar un tipo de usuario'));
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
        phone: phone,
        userType: userType,
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

  /// Registra un usuario que ya se autenticó con Google
  ///
  /// Este método completa el registro de un usuario que ya pasó por el flujo de
  /// autenticación de Google, agregando la información adicional necesaria:
  /// - Tipo de usuario (cliente, propietario, empleado)
  /// - Número de teléfono
  Future<void> registerWithGoogle({
    required String name,
    required String email,
    required String phone,
    required String userType,
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
      
      if (phone.isEmpty) {
        emit(AuthState.error('El número de teléfono no puede estar vacío'));
        return;
      }
      
      // Validar formato de teléfono (básico)
      if (!RegExp(r'^[0-9]{8,}$').hasMatch(phone)) {
        emit(AuthState.error('El formato del teléfono no es válido'));
        return;
      }
      
      if (userType.isEmpty) {
        emit(AuthState.error('Debes seleccionar un tipo de usuario'));
        return;
      }

      // En un caso real, aquí se utilizaría la información de la cuenta de Google
      // junto con los datos adicionales para completar el registro
      // En nuestra simulación, simplemente creamos un usuario con los datos proporcionados
      final user = await _authRepository.registerWithGoogle(
        name: name,
        email: email,
        phone: phone,
        userType: userType,
      );
      emit(AuthState.authenticated(user));
    } catch (e) {
      emit(AuthState.error(e.toString()));
    }
  }

  /// Valida el formato del email utilizando una expresión regular
  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }
  
  /// Verifica si una funcionalidad específica requiere autenticación
  /// y redirige al usuario apropiadamente
  ///
  /// Retorna true si el usuario está autenticado y puede acceder a la funcionalidad
  /// o false si el usuario no está autenticado y debe ser redirigido
  bool handleAuthRequiredFeature(BuildContext context, {bool showDialog = true}) {
    final currentState = state;
    
    if (currentState.status == AuthStatus.authenticated) {
      return true; // Usuario autenticado, puede acceder
    }
    
    // Usuario no autenticado, mostrar diálogo si se requiere
    if (showDialog) {
      _showAuthRequiredDialog(context);
    }
    
    return false; // No autenticado
  }
  
  /// Muestra un diálogo informando que la funcionalidad requiere autenticación
  /// y ofrece opciones para iniciar sesión o registrarse
  void _showAuthRequiredDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Autenticación requerida'),
        content: const Text(
          'Esta funcionalidad requiere que inicies sesión o te registres para continuar.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.go(AppRoutes.login);
            },
            child: const Text('Iniciar Sesión'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.go(AppRoutes.register);
            },
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.secondary,
            ),
            child: const Text('Registrarse'),
          ),
        ],
      ),
    );
  }
}
