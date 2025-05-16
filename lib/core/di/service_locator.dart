import 'package:app_agenda_glam/features/auth/data/datasources/auth_mock_datasource.dart';
import 'package:app_agenda_glam/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:app_agenda_glam/features/auth/domain/repositories/auth_repository.dart';
import 'package:app_agenda_glam/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

/// Instancia singleton de GetIt
final GetIt sl = GetIt.instance;

/// Inicializa las dependencias de la aplicación
///
/// Este método debe ser llamado al inicio de la aplicación
/// antes de utilizar cualquier dependencia
Future<void> initializeDependencies() async {
  // === Auth Module ===

  // DataSources - Nivel de datos
  sl.registerLazySingleton<AuthMockDataSource>(() => AuthMockDataSource());

  // Repositories - Nivel de dominio
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));

  // Cubits / BLoCs - Nivel de presentación
  // Usamos Factory para que cada widget obtenga una nueva instancia
  sl.registerFactory<AuthCubit>(() => AuthCubit(sl()));

  // Usar debugPrint en lugar de print para código de producción
  // debugPrint se elimina automáticamente en builds de release
  debugPrint('Dependencias inicializadas correctamente');
}
