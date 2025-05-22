import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:app_agenda_glam/core/di/service_locator.dart';
import 'package:app_agenda_glam/core/routes/app_router.dart';
import 'package:app_agenda_glam/core/theme/app_theme.dart';
import 'package:app_agenda_glam/features/auth/presentation/bloc/auth_cubit.dart';

/// Observer personalizado para debugging de BLoCs/Cubits
class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    debugPrint('${bloc.runtimeType} $change');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    debugPrint('${bloc.runtimeType} $error $stackTrace');
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Configurar el BlocObserver para depuración
  Bloc.observer = AppBlocObserver();

  // Inicializar las dependencias con GetIt
  await initializeDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
      // Utilizamos GetIt para obtener una instancia de AuthCubit
      create: (_) => sl<AuthCubit>(),
      child: MaterialApp.router(
        title: 'Agenda Glam',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.appTheme,
        routerConfig: AppRouter.router,
        // Configuración de localización
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('es', 'ES'), // Español
          Locale('en', 'US'), // Inglés (fallback)
        ],
        locale: const Locale('es', 'ES'), // Forzar español como idioma predeterminado
      ),
    );
  }
}
