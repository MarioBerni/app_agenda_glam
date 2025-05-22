# Estrategia de Pruebas: Agenda Glam

**Propósito**: Este documento establece la estrategia, principios y estándares para pruebas en el proyecto Agenda Glam. Sirve como guía para implementar pruebas efectivas que equilibren la cobertura con la velocidad de desarrollo.

## 1. Filosofía y Principios de Testing

Nuestro enfoque de pruebas es pragmático y estandarizado, buscando asegurar un producto de calidad sin sacrificar la agilidad del desarrollo.

### 1.1. Principios Fundamentales

1. **Priorización:** Testear primero los componentes críticos y de alto riesgo.
2. **Aislamiento:** Cada test debe enfocarse en una sola unidad de funcionalidad.
3. **Determinismo:** Los tests deben ser reproducibles y consistentes en cualquier entorno.
4. **Mantenibilidad:** Los tests deben ser fáciles de entender, mantener y actualizar.
5. **Eficiencia:** Los tests no deben ralentizar significativamente el desarrollo.
6. **Integración Continua:** Los tests deben ejecutarse automáticamente en cada pull request o commit a ramas principales.

### 1.2. Beneficios del Enfoque

- **Detección temprana de errores:** Reducir el costo de corrección identificando problemas en etapas tempranas.
- **Documentación viva:** Los tests sirven como documentación ejecutable del comportamiento esperado.
- **Refactorización segura:** Permitir cambios en el código con confianza de que la funcionalidad no se ha roto.
- **Diseño mejorado:** Fomentar un código más modular y desacoplado.
- **Confianza en el despliegue:** Minimizar riesgos al liberar nuevas versiones.

## 2. Tipos de Tests y su Aplicación

### 2.1. Tests Unitarios

- **Objetivo:** Verificar que unidades individuales de código funcionan como se espera en aislamiento.
- **Alcance:** 
  - Validators (ej. `recovery_validator.dart`)
  - Use Cases (cuando se implementen)
  - Repositories (ej. `auth_repository_impl.dart`)
  - Models (ej. `user_model.dart`)
  - Cubits/BLoCs (ej. `auth_cubit.dart`)
- **Herramientas:** `test`, `mockito`, `bloc_test`
- **Prioridad:** ALTA - Implementar desde el principio para componentes críticos.
- **Cobertura Mínima Recomendada:** 80% de la lógica de negocio crítica.

### 2.2. Tests de Widgets

- **Objetivo:** Verificar que los widgets se renderizan correctamente y responden adecuadamente a las interacciones.
- **Alcance:** 
  - Widgets reutilizables (ej. `glam_button.dart`, `password_strength_indicator.dart`)
  - Pantallas clave (ej. `login_page.dart`)
  - Flujos de UI complejos (ej. proceso de registro por pasos)
- **Herramientas:** `flutter_test`, `network_image_mock`
- **Prioridad:** MEDIA - Implementar para componentes visuales críticos o complejos.
- **Cobertura Mínima Recomendada:** 60% de widgets reutilizables y pantallas principales.

### 2.3. Tests de Integración

- **Objetivo:** Verificar que diferentes partes del sistema trabajan correctamente juntas.
- **Alcance:** 
  - Flujos completos (ej. proceso de registro, reserva de cita)
  - Interacciones con servicios externos (cuando se implemente Firebase)
- **Herramientas:** `flutter_test`, `integration_test`
- **Prioridad:** BAJA - Implementar para flujos críticos antes de releases importantes.
- **Cobertura Mínima Recomendada:** Tests para los 3-5 flujos más críticos del usuario.

### 2.4. Golden Tests (Tests de Referencia Visual)

- **Objetivo:** Verificar que la UI se ve exactamente como se espera a través de capturas de pantalla.
- **Alcance:** Componentes visuales clave y pantallas completas en diferentes tamaños de dispositivo.
- **Herramientas:** `golden_toolkit`
- **Prioridad:** BAJA - Implementar solo para componentes visuales críticos donde la consistencia es fundamental.
- **Consideraciones:** Estos tests son sensibles a cambios mínimos en el diseño, usar con moderación.

## 3. Estructura de Carpetas y Convenciones de Nombrado

### 3.1. Estructura de Carpetas para Tests

```
test/
├── helpers/                      # Utilidades compartidas para testing
│   ├── test_helpers.dart         # Funciones helper comunes
│   ├── mock_helpers.dart         # Configuraciones para mocks
│   └── test_data/                # Datos de prueba comunes
│       └── auth/
│           └── mock_user_data.dart
│
├── core/                         # Tests para componentes core
│   ├── theme/
│   ├── widgets/
│   └── utils/
│
└── features/                     # Tests por feature (espejando lib/features)
    └── auth/                     # Ejemplo: Feature de autenticación
        ├── data/
        │   ├── datasources/
        │   │   └── auth_mock_datasource_test.dart
        │   ├── models/
        │   │   └── user_model_test.dart
        │   └── repositories/
        │       └── auth_repository_impl_test.dart
        ├── domain/
        │   ├── entities/
        │   └── validators/
        │       ├── recovery_validator_test.dart
        │       └── register_validator_test.dart
        └── presentation/
            ├── bloc/
            │   └── auth_cubit_test.dart
            └── widgets/
                └── password_strength_indicator_test.dart
```

### 3.2. Convenciones de Nombrado

- **Archivos de Test:** El nombre debe ser el mismo que el archivo que está siendo testeado con el sufijo `_test.dart`.
  - Ejemplo: Para testear `user_model.dart` → `user_model_test.dart`

- **Grupos de Test:** Usar el nombre de la clase o función que está siendo testeada.
  - Ejemplo: `group('UserModel', () { ... });`

- **Casos de Test:** Describir claramente el comportamiento esperado usando el formato "should... when...".
  - Ejemplo: `test('should return valid user when parsing JSON with all fields', () { ... });`

- **Mocks:** Prefijo `Mock` seguido del nombre de la clase.
  - Ejemplo: `class MockAuthRepository extends Mock implements AuthRepository {}`

## 4. Estrategia de Implementación Incremental

### 4.1. Fase 1: Fundamentos (Inmediata)

- **Objetivos:**
  - Configurar las herramientas básicas de testing en `pubspec.yaml`
  - Establecer la estructura de carpetas para tests
  - Implementar tests unitarios para:
    - Validadores en `domain/validators/`
    - Modelos clave en `data/models/`
    - Implementaciones de repositorio críticas

- **Entregables:**
  - Configuración de desarrollo completada
  - Al menos 5-10 tests unitarios para componentes críticos

### 4.2. Fase 2: Expansión (Incremental)

- **Objetivos:**
  - Implementar tests para todos los Cubits/BLoCs
  - Añadir tests para widgets reutilizables clave
  - Configurar GitHub Actions para CI/CD básico

- **Entregables:**
  - Tests para todos los Cubits implementados
  - Tests para al menos 5 widgets críticos
  - Workflow de GitHub Actions funcionando

### 4.3. Fase 3: Cobertura Completa (Pre-release)

- **Objetivos:**
  - Implementar tests de integración para flujos críticos
  - Añadir golden tests para pantallas principales
  - Configurar análisis de cobertura de código

- **Entregables:**
  - Tests de integración para el flujo de autenticación completo
  - Golden tests para las pantallas principales
  - Dashboard de cobertura de código

## 5. Ejemplos de Implementación

### 5.1. Test Unitario (Validator)

```dart
// En: test/features/auth/domain/validators/register_validator_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:app_agenda_glam/features/auth/domain/validators/register_validator.dart';

void main() {
  late RegisterValidator validator;

  setUp(() {
    validator = RegisterValidator();
  });

  group('RegisterValidator', () {
    group('validateEmail', () {
      test('should return error message when email is empty', () {
        final result = validator.validateEmail('');
        expect(result, isNotNull);
        expect(result, contains('email'));
      });

      test('should return error message when email format is invalid', () {
        final result = validator.validateEmail('invalid-email');
        expect(result, isNotNull);
        expect(result, contains('formato'));
      });

      test('should return null when email is valid', () {
        final result = validator.validateEmail('valid@example.com');
        expect(result, isNull);
      });
    });

    group('validatePassword', () {
      test('should return error message when password is too short', () {
        final result = validator.validatePassword('123');
        expect(result, isNotNull);
        expect(result, contains('caracteres'));
      });

      test('should return null when password meets requirements', () {
        final result = validator.validatePassword('SecureP@ss123');
        expect(result, isNull);
      });
    });
  });
}
```

### 5.2. Test de Cubit

```dart
// En: test/features/auth/presentation/bloc/auth_cubit_test.dart
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:app_agenda_glam/features/auth/domain/entities/user.dart';
import 'package:app_agenda_glam/features/auth/domain/repositories/auth_repository.dart';
import 'package:app_agenda_glam/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:app_agenda_glam/features/auth/presentation/bloc/auth_state.dart';
import 'package:dartz/dartz.dart';  // Asumiendo que usas Either para manejo de errores

// Generar mocks con mockito
@GenerateMocks([AuthRepository])
import 'auth_cubit_test.mocks.dart';

void main() {
  late AuthCubit authCubit;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    authCubit = AuthCubit(authRepository: mockAuthRepository);
  });

  tearDown(() {
    authCubit.close();
  });

  test('initial state should be AuthInitial', () {
    expect(authCubit.state, equals(const AuthState.initial()));
  });

  group('login', () {
    final tEmail = 'test@example.com';
    final tPassword = 'password123';
    final tUser = User(id: '1', email: tEmail);

    blocTest<AuthCubit, AuthState>(
      'should emit [loading, authenticated] when login succeeds',
      build: () {
        when(mockAuthRepository.login(tEmail, tPassword))
            .thenAnswer((_) async => Right(tUser));
        return authCubit;
      },
      act: (cubit) => cubit.login(tEmail, tPassword),
      expect: () => [
        const AuthState.loading(),
        AuthState.authenticated(tUser),
      ],
      verify: (_) {
        verify(mockAuthRepository.login(tEmail, tPassword)).called(1);
      },
    );

    blocTest<AuthCubit, AuthState>(
      'should emit [loading, error] when login fails',
      build: () {
        when(mockAuthRepository.login(tEmail, tPassword))
            .thenAnswer((_) async => Left('Credenciales inválidas'));
        return authCubit;
      },
      act: (cubit) => cubit.login(tEmail, tPassword),
      expect: () => [
        const AuthState.loading(),
        const AuthState.error('Credenciales inválidas'),
      ],
    );
  });
}
```

### 5.3. Test de Widget

```dart
// En: test/features/auth/presentation/widgets/password_strength_indicator_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app_agenda_glam/core/theme/app_theme.dart';
import 'package:app_agenda_glam/features/auth/presentation/widgets/password_strength_indicator.dart';

void main() {
  testWidgets('PasswordStrengthIndicator shows correct strength levels', 
      (WidgetTester tester) async {
    // Función helper para pruebas con diferentes passwords
    Future<void> testPasswordStrength(String password, String expectedText) async {
      await tester.pumpWidget(MaterialApp(
        theme: AppTheme.appTheme,
        home: Scaffold(
          body: PasswordStrengthIndicator(
            password: password,
          ),
        ),
      ));
      
      expect(find.text(expectedText), findsOneWidget);
      expect(find.byType(LinearProgressIndicator), findsOneWidget);
    }
    
    // Test 1: Contraseña vacía
    await testPasswordStrength('', 'Sin contraseña');
    
    // Test 2: Contraseña débil
    await testPasswordStrength('weak', 'Débil');
    
    // Test 3: Contraseña media
    await testPasswordStrength('Medium123', 'Media');
    
    // Test 4: Contraseña fuerte
    await testPasswordStrength('StrongP@ssw0rd!', 'Fuerte');
  });
  
  testWidgets('PasswordStrengthIndicator updates when password changes', 
      (WidgetTester tester) async {
    // Inicialmente débil
    await tester.pumpWidget(MaterialApp(
      theme: AppTheme.appTheme,
      home: Scaffold(
        body: PasswordStrengthIndicator(
          password: 'weak',
        ),
      ),
    ));
    
    expect(find.text('Débil'), findsOneWidget);
    
    // Cambia a fuerte
    await tester.pumpWidget(MaterialApp(
      theme: AppTheme.appTheme,
      home: Scaffold(
        body: PasswordStrengthIndicator(
          password: 'StrongP@ssw0rd!',
        ),
      ),
    ));
    
    await tester.pump();
    expect(find.text('Fuerte'), findsOneWidget);
  });
}
```

### 5.4. Test de Integración Simple

```dart
// En: integration_test/auth_flow_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:app_agenda_glam/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Auth Flow Test', () {
    testWidgets('Full registration and login flow', (WidgetTester tester) async {
      // Iniciar la app
      app.main();
      await tester.pumpAndSettle();

      // Verificar que estamos en la pantalla de bienvenida
      expect(find.text('Bienvenido a Agenda Glam'), findsOneWidget);

      // Navegar a registro
      await tester.tap(find.text('Registrarse'));
      await tester.pumpAndSettle();

      // Completar información personal
      await tester.enterText(find.byType(TextField).at(0), 'Test User');
      await tester.enterText(find.byType(TextField).at(1), 'test@example.com');
      await tester.tap(find.text('Continuar'));
      await tester.pumpAndSettle();

      // Completar contraseña
      await tester.enterText(find.byType(TextField).at(0), 'SecureP@ss123');
      await tester.enterText(find.byType(TextField).at(1), 'SecureP@ss123');
      await tester.tap(find.text('Registrarse'));
      await tester.pumpAndSettle();

      // Verificar redirección a login o home
      expect(find.text('Bienvenido de nuevo') | find.text('Inicio'), findsOneWidget);
    });
  });
}
```

## 6. Herramientas y Configuración

### 6.1. Dependencias para Testing

Añadir estas dependencias a `pubspec.yaml`:

```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
  integration_test:
    sdk: flutter
  mockito: ^5.4.2
  bloc_test: ^9.1.4
  mocktail: ^1.0.0
  build_runner: ^2.4.6
  network_image_mock: ^2.1.1
  golden_toolkit: ^0.15.0
  coverage: ^1.6.3
```

### 6.2. Configuración de GitHub Actions (CI/CD)

Crear archivo `.github/workflows/flutter_tests.yml`:

```yaml
name: Flutter Tests

on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main, develop ]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.19.0'
          channel: 'stable'
      - run: flutter pub get
      - run: flutter analyze
      - run: flutter test --coverage
      - name: Upload coverage to Codecov
        uses: codecov/codecov-action@v3
        with:
          file: coverage/lcov.info
```

### 6.3. Comandos Útiles

```bash
# Ejecutar todos los tests unitarios y de widget
flutter test

# Ejecutar tests con cobertura
flutter test --coverage

# Ejecutar tests de integración
flutter test integration_test

# Generar mocks con mockito
flutter pub run build_runner build
```

## 7. Mejores Prácticas y Patrones

### 7.1. Estructura AAA (Arrange-Act-Assert)

Estructurar los tests siguiendo el patrón AAA:

1. **Arrange:** Preparar el estado inicial y las dependencias.
2. **Act:** Ejecutar la acción a testear.
3. **Assert:** Verificar el resultado.

```dart
test('should update user name', () {
  // Arrange
  final initialUser = User(id: '1', name: 'Old Name');
  final repository = MockUserRepository();
  when(repository.updateUser(any)).thenAnswer((_) async => Right(User(id: '1', name: 'New Name')));
  
  // Act
  final result = await userUseCase.execute(initialUser, 'New Name');
  
  // Assert
  expect(result.isRight(), true);
  expect(result.getOrElse(() => initialUser).name, equals('New Name'));
});
```

### 7.2. Uso de Mocks y Fakes

- **Mocks:** Objetos que simulan el comportamiento de objetos reales para tests.
- **Fakes:** Implementaciones livianas de interfaces reales para testing.

```dart
// Mock con mockito
@GenerateMocks([AuthRepository])
import 'auth_repository_test.mocks.dart';

// Fake implementación manual
class FakeAuthRepository implements AuthRepository {
  bool loginCalled = false;
  Either<String, User> loginResult = Right(User(id: '1', email: 'test@example.com'));

  @override
  Future<Either<String, User>> login(String email, String password) async {
    loginCalled = true;
    return loginResult;
  }

  // Implementar otros métodos...
}
```

### 7.3. Tests Parametrizados

Usar tests parametrizados para probar múltiples casos con el mismo código:

```dart
void main() {
  group('EmailValidator', () {
    final validator = EmailValidator();
    
    final testCases = {
      '': false,
      'invalid': false,
      'test@': false,
      '@example.com': false,
      'test@example': true,
      'test@example.com': true,
      'test.user@example.co.uk': true,
    };
    
    testCases.forEach((email, isValid) {
      test('validate "$email" should return ${isValid ? 'valid' : 'invalid'}', () {
        final result = validator.isValid(email);
        expect(result, equals(isValid));
      });
    });
  });
}
```

### 7.4. Manejo de Dependencias en Tests

- **setUp/tearDown:** Usar para inicializar y limpiar el estado entre tests.
- **setUpAll/tearDownAll:** Para configuraciones que se comparten entre todos los tests.

```dart
void main() {
  late AuthCubit authCubit;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    authCubit = AuthCubit(authRepository: mockAuthRepository);
  });

  tearDown(() {
    authCubit.close();
  });

  // Tests...
}
```

### 7.5. Tips para Testing Efectivo

1. **Testear comportamiento, no implementación:** Enfocarse en lo que hace el código, no en cómo lo hace.
2. **Un assert por test:** Idealmente cada test verifica una sola cosa.
3. **Tests independientes:** Los tests no deben depender del orden o resultado de otros tests.
4. **Evitar lógica compleja en tests:** Mantener los tests simples y directos.
5. **No testear código generado o de framework:** Enfocarse en testear código propio, no en Flutter o dependencias externas.

## 8. Workflow de Desarrollo con Tests

### 8.1. Enfoque TDD Ligero

1. Escribir tests para los componentes críticos antes de implementarlos.
2. Implementar el código mínimo necesario para que los tests pasen.
3. Refactorizar manteniendo los tests en verde.

### 8.2. Enfoque Pragmático

1. Implementar la funcionalidad básica.
2. Escribir tests para cubrir los casos principales.
3. Refinar la implementación y añadir tests para casos borde.

### 8.3. Proceso de Desarrollo Sugerido

1. **Planificación:**
   - Identificar los componentes críticos que necesitarán tests.
   - Añadir tareas de testing al archivo `TASK_nombre_tarea.MD`.

2. **Implementación:**
   - Para validators, repositories y cubits, considerar TDD.
   - Para widgets y UI, implementar y luego testear.

3. **Pull Request:**
   - Ejecutar los tests localmente antes de crear un PR.
   - Verificar que la CI pasa correctamente.

4. **Mantenimiento:**
   - Actualizar los tests cuando se modifica la funcionalidad.
   - Ampliar la cobertura de tests gradualmente.

## 9. Recursos Adicionales

- [Flutter Testing Documentation](https://docs.flutter.dev/testing)
- [Testing Flutter Apps - Cookbook](https://docs.flutter.dev/cookbook/testing)
- [bloc_test Package](https://pub.dev/packages/bloc_test)
- [Mockito Package](https://pub.dev/packages/mockito)
- [Golden Toolkit](https://pub.dev/packages/golden_toolkit)

---

**Nota:** Este documento es una guía viva que evolucionará con el proyecto. Cualquier duda específica sobre la implementación de tests para un componente particular, consultar con el equipo.
