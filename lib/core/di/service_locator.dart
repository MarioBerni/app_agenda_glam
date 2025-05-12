import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Aquí registraremos las dependencias (datasources, repositories, usecases, blocs)
  // Por ahora, lo dejamos vacío o con registros muy básicos si es necesario.

  // Ejemplo básico (si tuviéramos algo que registrar ya):
  // sl.registerSingleton<ApiClient>(ApiClient());
  // sl.registerLazySingleton<ExampleRepository>(() => ExampleRepositoryImpl(sl()));

  print('Dependencias inicializadas');
}
