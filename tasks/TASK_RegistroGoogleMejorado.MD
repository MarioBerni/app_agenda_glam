# Tarea: Mejora del Flujo de Registro con Google (Frontend)

## Referencias
- **ARCHITECTURE.MD:** Sección 3.1 (Capa de Presentación), Sección 6.1 (Sistema de Gestión de Estado)
- **Tareas Relacionadas:** [TASK_FlujoAutenticacionUI.MD](./TASK_FlujoAutenticacionUI.MD), [TASK_DiseñoAutenticacionUI.MD](./TASK_DiseñoAutenticacionUI.MD)
- **Estado:** Pendiente

Este archivo detalla los pasos necesarios para mejorar el flujo de registro con Google en la aplicación "Agenda Glam", enfocándose exclusivamente en la implementación frontend. El objetivo es asegurar la captura de toda la información necesaria del usuario (teléfono y tipo de usuario) mientras se mantiene una experiencia fluida y coherente. Esta implementación seguirá los principios visuales y de experiencia de usuario establecidos en el [PLANNING.MD](../PLANNING.MD).

## Objetivos:

- Implementar una interfaz de usuario para el registro con Google que capture toda la información necesaria
- Crear una experiencia de usuario fluida y sin fricciones
- Asegurar la coherencia visual con el resto de la aplicación
- Simular la funcionalidad de registro con Google (sin implementación backend real)
- Optimizar el proceso para reducir el abandono durante el registro

## Pasos:

### 1. Crear Pantalla de Información Adicional Post-Google:

- [x] Crear nueva pantalla `GoogleRegisterAdditionalInfoPage`:
  - [x] Diseñar interfaz para solicitar información adicional post-autenticación Google
  - [x] Implementar selección de tipo de usuario (Cliente/Propietario/Empleado)
  - [x] Añadir campo para número de teléfono con validación
  - [x] Incluir botón para completar el registro
  - [x] Mantener coherencia visual con el resto del flujo de autenticación
  - [x] Aplicar animaciones consistentes con el sistema GlamAnimations

### 2. Modificar Flujo de Registro con Google:

- [x] Actualizar método `_handleGoogleRegister` en `RegisterPage`:
  - [x] Mantener la simulación de autenticación con Google
  - [x] Modificar navegación para dirigir a `GoogleRegisterAdditionalInfoPage` en lugar de Home
  - [x] Pasar información obtenida de Google (nombre, email) a la nueva pantalla
  - [x] Manejar correctamente los estados de carga

- [x] Implementar lógica para completar registro en `GoogleRegisterAdditionalInfoPage`:
  - [x] Crear método para validar y procesar la información adicional
  - [x] Integrar con AuthCubit para el registro final
  - [x] Implementar navegación a Home después del registro exitoso
  - [x] Manejar casos de error apropiadamente

### 3. Simular el Sistema de Gestión de Estado:

- [x] Modificar `AuthCubit` para simular el registro con Google:
  - [x] Crear método para simular registro con Google + información adicional
  - [x] Actualizar estados para reflejar el nuevo flujo visual
  - [x] Mantener compatibilidad con el flujo de registro tradicional simulado

### 4. Implementar Validaciones y UX:

- [x] Crear validaciones específicas para la información adicional:
  - [x] Validación de número de teléfono (formato, longitud)
  - [x] Validación de selección de tipo de usuario
  - [x] Feedback visual inmediato

- [x] Mejorar experiencia de usuario:
  - [x] Añadir indicación clara de progreso en el flujo
  - [x] Implementar transiciones fluidas entre pantallas
  - [x] Optimizar para uso con teclado virtual
  - [x] Añadir opción para cancelar y volver al inicio

### 5. Optimización de la Experiencia Visual:

- [x] Optimizar rendimiento y experiencia visual:
  - [x] Asegurar transiciones fluidas entre pantallas
  - [x] Minimizar reconstrucciones innecesarias de widgets
  - [x] Verificar comportamiento responsivo en diferentes tamaños de pantalla
  - [x] Optimizar animaciones para mantener 60fps

### 6. Refactorización y Documentación:

- [x] Refactorizar código para mantener archivos bajo 300 líneas:
  - [x] Extraer componentes reutilizables si es necesario
  - [x] Mantener separación clara de responsabilidades

- [x] Actualizar documentación:
  - [x] Documentar el nuevo flujo en comentarios de código
  - [x] Actualizar UI_COMPONENTS.md si se crean nuevos componentes
  - [x] Añadir instrucciones para implementación real con Firebase Auth

### 7. Mejoras Adicionales de Experiencia de Usuario:

- [x] Mejorar coherencia visual con el resto de la aplicación:
  - [x] Restaurar tarjeta de confirmación de datos del usuario (nombre y email de Google)
  - [x] Aplicar formato consistente con otras pantallas de registro
  - [x] Aplicar animaciones de entrada con GlamAnimations

- [x] Mejorar la interacción del usuario:
  - [x] Eliminar duplicación de texto "Tipo de Usuario"
  - [x] Implementar texto más amigable "Selecciona cómo utilizarás la App"
  - [x] Eliminar preselección automática de "Cliente" para forzar una selección explícita

- [x] Corregir errores técnicos:
  - [x] Implementar GlamUI.buildBackButton para botón de retroceso consistente
  - [x] Corregir método dispose() para llamar a super.dispose() según requiere @mustCallSuper
  - [x] Organizar código con mejores prácticas y comentarios explicativos

## Instrucciones para Implementación Real con Firebase Auth:

Para implementar el flujo de registro con Google usando Firebase Auth en una fase futura, sigue estos pasos:

### 1. Configuración Inicial:

1. **Agregar dependencias**:
   ```yaml
   dependencies:
     firebase_core: ^latest_version
     firebase_auth: ^latest_version
     google_sign_in: ^latest_version
   ```

2. **Configurar Firebase**:
   - Registrar la aplicación en Firebase Console
   - Descargar el archivo `google-services.json` (Android) y/o `GoogleService-Info.plist` (iOS)
   - Seguir las instrucciones de configuración para cada plataforma

3. **Configurar Google Sign-In**:
   - Crear credenciales OAuth en Google Cloud Console
   - Configurar URI de redirección autorizados
   - Agregar la huella digital SHA-1 para Android

### 2. Implementación del Código:

1. **Modificar el `RegisterGoogleHandler`**:
   - Reemplazar la simulación por el código real de autenticación:
   ```dart
   Future<void> handleGoogleRegister(BuildContext context) async {
     try {
       onLoadingChanged(true);
       
       // Iniciar flujo de Google Sign-In
       final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
       if (googleUser == null) {
         onLoadingChanged(false);
         return; // Usuario canceló el inicio de sesión
       }
       
       // Obtener credenciales de autenticación
       final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
       final credential = GoogleAuthProvider.credential(
         accessToken: googleAuth.accessToken,
         idToken: googleAuth.idToken,
       );
       
       // Autenticar con Firebase
       final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
       final user = userCredential.user;
       
       // Verificar si es un usuario nuevo
       final isNewUser = userCredential.additionalUserInfo?.isNewUser ?? false;
       
       onLoadingChanged(false);
       
       // Si es un usuario nuevo, solicitar información adicional
       if (isNewUser && user != null && context.mounted) {
         context.pushCircle(
           GoogleRegisterAdditionalInfoPage(
             userName: user.displayName ?? 'Usuario',
             userEmail: user.email ?? '',
           ),
         );
       } else {
         // Usuario existente, navegar a Home
         if (context.mounted) {
           CircleNavigation.goToHome(context);
         }
       }
     } catch (e) {
       onLoadingChanged(false);
       debugPrint('Error en autenticación con Google: $e');
       // Mostrar error al usuario
     }
   }
   ```

2. **Modificar `AuthRepository` e implementación**:
   - Implementar métodos reales para interactuar con Firebase:
   ```dart
   // En AuthRepositoryImpl
   @override
   Future<User> registerWithGoogle({
     required String name,
     required String email,
     required String phone,
     required String userType,
   }) async {
     try {
       // Actualizar datos adicionales del usuario en Firestore
       final firebaseUser = FirebaseAuth.instance.currentUser;
       if (firebaseUser == null) {
         throw Exception('No se encontró usuario autenticado');
       }
       
       // Guardar datos adicionales en Firestore
       await FirebaseFirestore.instance.collection('users').doc(firebaseUser.uid).set({
         'name': name,
         'email': email,
         'phone': phone,
         'userType': userType,
         'registeredAt': FieldValue.serverTimestamp(),
         'authProvider': 'google',
       }, SetOptions(merge: true));
       
       // Retornar el usuario de dominio
       return User(
         id: firebaseUser.uid,
         name: name,
         email: email,
         phone: phone,
         userType: userType,
         isAuthenticated: true,
         profileImage: firebaseUser.photoURL,
       );
     } catch (e) {
       throw Exception('Error al registrar con Google: $e');
     }
   }
   ```

### 3. Consideraciones de Seguridad:

1. **Reglas de Firestore**: Configurar reglas adecuadas para proteger los datos de usuario:
   ```
   rules_version = '2';
   service cloud.firestore {
     match /databases/{database}/documents {
       match /users/{userId} {
         allow read: if request.auth != null && request.auth.uid == userId;
         allow write: if request.auth != null && request.auth.uid == userId;
       }
     }
   }
   ```

2. **Validación de Datos**: Implementar validación adicional en el servidor usando Cloud Functions para verificar la integridad de los datos.

3. **Manejo de Tokens**: Gestionar adecuadamente los tokens de autenticación y configurar tiempos de expiración apropiados.

Esta implementación mantiene la misma estructura y flujo del código simulado actual, pero reemplaza las partes simuladas con integraciones reales de Firebase Auth y Firestore.

## Consideraciones Adicionales:

- Mantener todos los textos claros y consistentes con el resto de la aplicación
- Asegurar que la pantalla de información adicional mantenga la estética masculina y profesional
- Crear componentes modulares que faciliten la futura integración con sistemas reales
- Asegurar que todos los archivos mantengan menos de 300 líneas siguiendo la regla de oro del proyecto
- Documentar claramente el flujo visual para facilitar la futura implementación backend

# Tareas para Rediseño del Flujo de Registro

## Objetivo
Rediseñar el flujo de registro para que sea más intuitivo y eficiente, permitiendo al usuario elegir entre diferentes métodos de autenticación (Google o teléfono) y unificando la experiencia de usuario en todos los flujos.

## Referencias
- **ARCHITECTURE.MD:** Sección 3.1 (Capa de Presentación), Sección 6.1 (Sistema de Gestión de Estado)
- **Tareas Relacionadas:** [TASK_FlujoAutenticacionUI.MD](./TASK_FlujoAutenticacionUI.MD), [TASK_DiseñoAutenticacionUI.MD](./TASK_DiseñoAutenticacionUI.MD)
- **Estado:** Pendiente

## Pasos:

### 1. Rediseño de la Página de Registro Inicial:

- [x] Modificar la página de registro para mostrar dos opciones de autenticación:
  - [x] Registrarse con Google
  - [x] Registrarse con número de teléfono
- [x] Eliminar el selector de tipo de usuario (Propietario/Empleado/Cliente) de la pantalla inicial

### 2. Crear Página de Verificación por SMS:

- [x] Diseñar e implementar página `PhoneVerificationPage`:
  - [x] Interfaz para ingresar número de teléfono
  - [x] Validación en tiempo real del formato del teléfono
  - [x] Botón para solicitar código de verificación
- [x] Diseñar e implementar página `SMSCodeVerificationPage`:
  - [x] Interfaz para introducir código de verificación
  - [x] Temporizador para códigos (2 minutos)
  - [x] Opción para reenviar código
  - [x] Validación del código ingresado
- [x] Implementar navegación fluida entre pantallas de verificación

### 3. Crear Página de Datos Adicionales Post-Verificación:

- [x] Diseñar e implementar página `PhoneRegisterAdditionalInfoPage`:
  - [x] Campo para nombre completo
  - [x] Selector de fecha de nacimiento
  - [x] Selector de tipo de usuario (Propietario/Empleado/Cliente)
  - [x] Validaciones en tiempo real
  - [x] Botón para completar registro
- [x] Asegurar consistencia visual con la página de información adicional de Google

### 4. Refactorizar Arquitectura para Soportar Múltiples Métodos de Registro:

- [x] Actualizar `AuthCubit` para manejar diferentes flujos de registro:
  - [x] Crear método para verificación de teléfono
  - [x] Crear método para verificación de código SMS
  - [x] Crear método para registro final con teléfono
- [x] Modificar `AuthRepository` y sus implementaciones:
  - [x] Añadir métodos para soportar verificación por SMS
  - [x] Implementar simulación de envío y verificación de códigos
- [x] Crear nuevos controladores:
  - [x] `PhoneVerificationHandler` (similar a `RegisterGoogleHandler`)
  - [x] `SMSCodeVerificationHandler`

### 5. Implementación de Seguridad y Prevención de Abusos:

- [ ] Implementar lógica de limitación de intentos:
  - [ ] Máximo 3 intentos de código por sesión
  - [ ] Cooldown después de múltiples intentos fallidos
- [ ] Implementar lógica de reenvío de códigos:
  - [ ] Limitar a 2 reenvíos por sesión
  - [ ] Espera de 60 segundos entre reenvíos

### 6. Pruebas y Optimización:

- [x] Probar todos los flujos de registro:
  - [x] Registro con Google completo
  - [x] Registro con teléfono completo
  - [x] Casos de error y cancelación
- [x] Optimizar experiencia de usuario:
  - [x] Asegurar transiciones fluidas entre pantallas
  - [x] Minimizar reconstrucciones innecesarias de widgets
  - [x] Verificar comportamiento responsivo
- [x] Implementar soporte de localización en español:
  - [x] Configurar flutter_localizations en pubspec.yaml
  - [x] Configurar MaterialApp para usar español como idioma principal
  - [x] Adaptar selector de fecha para mostrar contenido en español

### 7. Documentación del Nuevo Flujo:

- [x] Actualizar UI_COMPONENTS.md con los nuevos componentes
- [x] Documentar el flujo completo de registro con ambos métodos
- [x] Agregar instrucciones para implementación real con Firebase Auth y SMS

## Instrucciones para Implementación Real (Futura):

### 1. Implementación de Verificación por SMS con Firebase:

```dart
// Enviar código de verificación
Future<void> sendVerificationCode(String phoneNumber) async {
  await FirebaseAuth.instance.verifyPhoneNumber(
    phoneNumber: phoneNumber,
    verificationCompleted: (PhoneAuthCredential credential) {
      // Auto-verificación completada (Android)
      signInWithCredential(credential);
    },
    verificationFailed: (FirebaseAuthException e) {
      // Manejar error
      throw Exception('Error de verificación: ${e.message}');
    },
    codeSent: (String verificationId, int? resendToken) {
      // Guardar ID de verificación para confirmar código más tarde
      this.verificationId = verificationId;
      this.resendToken = resendToken;
    },
    codeAutoRetrievalTimeout: (String verificationId) {
      // Tiempo de espera para recuperación automática de código
      this.verificationId = verificationId;
    },
    timeout: const Duration(minutes: 2),
  );
}

// Verificar código SMS
Future<UserCredential> verifyCode(String smsCode) async {
  final credential = PhoneAuthProvider.credential(
    verificationId: verificationId,
    smsCode: smsCode,
  );
  return await FirebaseAuth.instance.signInWithCredential(credential);
}
```

## Detalles Técnicos:

### Archivos Principales a Modificar (Frontend):

1. **Crear Nuevos Archivos:**
   - `lib/features/auth/presentation/pages/google_register_additional_info_page.dart`
   - `lib/features/auth/presentation/widgets/google_register_info_form.dart` (opcional, para modularidad)

2. **Modificar Archivos Existentes:**
   - `lib/features/auth/presentation/pages/register_page.dart`
   - `lib/features/auth/presentation/widgets/register_content.dart`
   - `lib/features/auth/presentation/cubit/auth_cubit.dart` (solo para simulación)

### Flujo de Usuario Final (Frontend):

1. Usuario selecciona "Registrarse con Google" en la pantalla de registro
2. Se muestra animación de carga simulando proceso de autenticación con Google
3. Usuario es dirigido a pantalla de información adicional
4. Usuario completa tipo de usuario y número de teléfono
5. Usuario finaliza registro y es dirigido a la pantalla principal (simulado)
6. En caso de cancelación, usuario puede volver a la pantalla anterior

Este documento proporciona una guía completa para implementar la interfaz de usuario del flujo de registro con Google mejorado, centrándose exclusivamente en los aspectos visuales y de experiencia de usuario, sin implementación de pruebas ni integración backend real.
