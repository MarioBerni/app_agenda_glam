﻿import 'package:equatable/equatable.dart';

/// Representa las credenciales necesarias para autenticar a un usuario
class Credentials extends Equatable {
  final String email;
  final String password;

  const Credentials({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}
