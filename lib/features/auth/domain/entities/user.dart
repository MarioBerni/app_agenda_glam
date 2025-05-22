import 'package:equatable/equatable.dart';

/// Entidad User representa un usuario autenticado en la aplicación
/// Sigue los principios de Clean Architecture al ser independiente de detalles de implementación
class User extends Equatable {
  final String id;
  final String name;
  final String email;
  final String? phone;
  final String? userType;
  final String? profileImage;
  final bool isAuthenticated;

  const User({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.userType,
    this.profileImage,
    this.isAuthenticated = false,
  });

  /// Usuario vacío/no autenticado
  factory User.empty() =>
      const User(id: '', name: '', email: '', phone: '', userType: '', isAuthenticated: false);

  @override
  List<Object?> get props => [id, name, email, phone, userType, profileImage, isAuthenticated];

  /// Método para crear una copia de User con algunos valores actualizados
  User copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? userType,
    String? profileImage,
    bool? isAuthenticated,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      userType: userType ?? this.userType,
      profileImage: profileImage ?? this.profileImage,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
    );
  }
}
