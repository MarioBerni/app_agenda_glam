import 'package:app_agenda_glam/features/auth/data/models/user_model.dart';

/// Fuente de datos mock para autenticación (sin Firebase)
/// Esta clase simula la interacción con una API o backend
class AuthMockDataSource {
  // Simula una pequeña base de datos de usuarios
  final List<UserModel> _users = [
    const UserModel(
      id: '1',
      name: 'Usuario Demo',
      email: 'demo@ejemplo.com',
      phone: '12345678',
      userType: 'Cliente',
      isAuthenticated: false,
    ),
  ];

  // Usuario actualmente autenticado
  UserModel? _currentUser;

  /// Simula el inicio de sesión
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    // Simular retraso de red
    await Future.delayed(const Duration(seconds: 1));

    // Busca un usuario con el email indicado
    final user = _users.firstWhere(
      (user) => user.email == email,
      orElse: () => throw Exception('Usuario no encontrado'),
    );

    // En un escenario real, aquí verificaríamos la contraseña
    // Para demo aceptamos cualquier contraseña
    if (password.isNotEmpty) {
      _currentUser = user.copyWith(isAuthenticated: true);
      return _currentUser!;
    } else {
      throw Exception('Contraseña incorrecta');
    }
  }

  /// Simula el registro de un nuevo usuario
  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String userType,
  }) async {
    // Simular retraso de red
    await Future.delayed(const Duration(seconds: 1));

    // Verifica si ya existe un usuario con ese email
    final existingUser = _users.any((user) => user.email == email);
    if (existingUser) {
      throw Exception('El email ya está registrado');
    }
    
    // Verifica si ya existe un usuario con ese teléfono
    final existingPhone = _users.any((user) => user.phone == phone);
    if (existingPhone) {
      throw Exception('El número de teléfono ya está registrado');
    }

    // Crea un nuevo usuario
    final newUser = UserModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      email: email,
      phone: phone,
      userType: userType,
      isAuthenticated: true,
    );

    // Añade el usuario a la "base de datos"
    _users.add(newUser);

    // Establece como usuario actual
    _currentUser = newUser;

    return newUser;
  }

  /// Simula el cierre de sesión
  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 500));
    _currentUser = null;
  }

  /// Simula la recuperación de contraseña
  Future<void> recoverPassword(String email) async {
    // Simular retraso de red
    await Future.delayed(const Duration(seconds: 1));

    // Verifica si existe un usuario con ese email
    final existingUser = _users.any((user) => user.email == email);
    if (!existingUser) {
      throw Exception('No existe ningún usuario con ese email');
    }

    // En un caso real, aquí se enviaría un email
    // Para la demo, simplemente retornamos éxito
    return;
  }

  /// Obtiene el usuario actual, si hay uno autenticado
  Future<UserModel?> getCurrentUser() async {
    // Simular un pequeño retraso
    await Future.delayed(const Duration(milliseconds: 300));
    return _currentUser;
  }
  
  /// Simula el registro de un usuario que ya se autenticó con Google
  Future<UserModel> registerWithGoogle({
    required String name,
    required String email,
    required String phone,
    required String userType,
  }) async {
    // Simular retraso de red como lo haría una llamada real a Firebase/Google
    await Future.delayed(const Duration(seconds: 1));
    
    // Verifica si ya existe un usuario con ese email
    final existingUserIndex = _users.indexWhere((user) => user.email == email);
    
    // Si el usuario ya existe con ese email (posiblemente de un inicio de sesión anterior con Google)
    // actualizamos sus datos con la nueva información
    if (existingUserIndex >= 0) {
      final updatedUser = _users[existingUserIndex].copyWith(
        phone: phone,
        userType: userType,
        isAuthenticated: true,
      );
      
      // Actualiza el usuario en la "base de datos"
      _users[existingUserIndex] = updatedUser;
      
      // Establece como usuario actual
      _currentUser = updatedUser;
      
      return updatedUser;
    }
    
    // Si es un usuario completamente nuevo, verificamos el teléfono
    final existingPhone = _users.any((user) => user.phone == phone);
    if (existingPhone) {
      throw Exception('El número de teléfono ya está registrado');
    }

    // Crea un nuevo usuario con los datos de Google
    final newUser = UserModel(
      id: 'google_${DateTime.now().millisecondsSinceEpoch}',
      name: name,
      email: email,
      phone: phone,
      userType: userType,
      isAuthenticated: true,
    );

    // Añade el usuario a la "base de datos"
    _users.add(newUser);

    // Establece como usuario actual
    _currentUser = newUser;

    return newUser;
  }
}
