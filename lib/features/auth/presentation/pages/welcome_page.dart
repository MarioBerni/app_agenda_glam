import 'package:app_agenda_glam/core/routes/app_router.dart';
import 'package:app_agenda_glam/features/auth/presentation/widgets/glam_button.dart';
import 'package:app_agenda_glam/features/auth/presentation/widgets/glam_logo.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Página de bienvenida que muestra opciones para login o registro
class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: size.height * 0.1),
              // Logo y título
              const GlamLogo(size: 100),
              const Spacer(),
              // Mensaje de bienvenida
              Text(
                'Bienvenido',
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onBackground,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'Tu plataforma para descubrir y reservar los mejores servicios de estética masculina',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onBackground.withOpacity(0.8),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
              // Botones de acción
              GlamButton(
                text: 'Iniciar Sesión',
                onPressed: () => context.go(AppRouter.login),
              ),
              const SizedBox(height: 16),
              GlamButton(
                text: 'Registrarse',
                onPressed: () => context.go(AppRouter.register),
                isSecondary: true,
              ),
              SizedBox(height: size.height * 0.08),
            ],
          ),
        ),
      ),
    );
  }
}
