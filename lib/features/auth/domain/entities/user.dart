import 'package:equatable/equatable.dart';

/// Entidad User representa un usuario autenticado en la aplicación
/// Sigue los principios de Clean Architecture al ser independiente de detalles de implementación
class User extends Equatable {
  final String id;
  final String name;
  final String email;
  final String? profileImage;
  final bool isAuthenticated;

  const User({
    required this.id,
    required this.name,
    required this.email,
    this.profileImage,
    this.isAuthenticated = false,
  });

  /// Usuario vacío/no autenticado
  factory User.empty() =>
      const User(id: '', name: '', email: '', isAuthenticated: false);

  @override
  List<Object?> get props => [id, name, email, profileImage, isAuthenticated];

  /// Método para crear una copia de User con algunos valores actualizados
  User copyWith({
    String? id,
    String? name,
    String? email,
    String? profileImage,
    bool? isAuthenticated,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      profileImage: profileImage ?? this.profileImage,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
    );
  }
}
