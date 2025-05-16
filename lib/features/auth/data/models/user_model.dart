import 'package:app_agenda_glam/features/auth/domain/entities/user.dart';

/// Modelo de usuario que implementa la entidad User
/// Facilita la conversión desde/hacia formatos de datos (json, etc.)
class UserModel extends User {
  const UserModel({
    required super.id,
    required super.name,
    required super.email,
    super.profileImage,
    super.isAuthenticated,
  });

  /// Crea un UserModel a partir de un mapa (ej: json)
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      profileImage: json['profile_image'] as String?,
      isAuthenticated: json['is_authenticated'] as bool? ?? false,
    );
  }

  /// Convierte el modelo a formato json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'profile_image': profileImage,
      'is_authenticated': isAuthenticated,
    };
  }

  /// Crea una copia del modelo con algunos valores actualizados
  @override
  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? profileImage,
    bool? isAuthenticated,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      profileImage: profileImage ?? this.profileImage,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
    );
  }
}
