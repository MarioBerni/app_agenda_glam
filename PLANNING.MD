# Planificación General del Proyecto: Agenda Glam

## 1. Visión General del Proyecto: Agenda Glam

**Propósito y Alcance:**
Agenda Glam es una plataforma innovadora diseñada para revolucionar la gestión de servicios de estética dirigidos al público masculino en Uruguay. El proyecto busca simplificar el proceso de reserva de citas para los clientes finales y, al mismo tiempo, ofrecer herramientas de gestión comercial robustas y eficientes para los proveedores de servicios (negocios de estética, barberías, etc.). El objetivo es desarrollar la aplicación completa con todas sus funcionalidades previstas.

**Público Objetivo:**
El proyecto se enfoca en dos grupos de usuarios principales:
1.  **Clientes:** Hombres en Uruguay que buscan descubrir, comparar y reservar servicios de estética de manera fácil y rápida.
2.  **Proveedores de Servicios:** Dueños de negocios y empleados del sector de la estética masculina que necesitan una herramienta para gestionar sus agendas, servicios, clientes y personal.

**Funcionalidades Clave (Aplicación Completa):**
*   **Para Clientes:**
    *   Búsqueda y descubrimiento de proveedores de servicios.
    *   Visualización de perfiles de negocios, servicios ofrecidos, precios y disponibilidad.
    *   Reserva y gestión de citas online.
    *   Recordatorios de citas.
    *   Historial de servicios.
    *   Sistema de calificaciones y reseñas.
*   **Para Proveedores de Servicios:**
    *   Gestión de agenda y calendario de citas (multi-empleado si es necesario).
    *   Configuración de servicios, precios, duraciones y horarios de atención.
    *   Gestión de perfiles de empleados con roles y permisos.
    *   Base de datos de clientes con historial.
    *   Notificaciones y confirmaciones de citas.
    *   Herramientas de marketing: promociones y cupones.
    *   Reportes y estadísticas de rendimiento del negocio.

**Arquitectura de Alto Nivel:**
Agenda Glam se desarrollará siguiendo los principios de la **Arquitectura Limpia**, promoviendo una clara separación de responsabilidades entre las siguientes capas:
1.  **Capa de Presentación (UI):** Responsable de la interfaz de usuario y la interacción con el usuario. Construida con Flutter.
2.  **Capa de Dominio (Lógica de Negocio):** Contiene las reglas de negocio, entidades y casos de uso de la aplicación. Independiente de frameworks específicos.
3.  **Capa de Datos:** Encargada de la persistencia y obtención de datos, interactuando con fuentes externas como la base de datos y servicios de red.

**Pila Tecnológica Principal:**
*   **Frontend (Aplicación Móvil):** Flutter (Framework), Dart (Lenguaje de programación). Inicialmente se priorizará la aplicación móvil.
*   **Backend y Base de Datos:** **Firebase** (BaaS - Backend as a Service). Esto incluye:
    *   **Firebase Authentication** para la autenticación de usuarios.
    *   **Cloud Firestore** como base de datos NoSQL.
    *   **Firebase Storage** para imágenes de perfil, logos de negocios, y potencialmente fotos de trabajos. Se gestionará la privacidad según corresponda.
    *   **Cloud Functions for Firebase** para lógica de backend que no deba residir en el cliente (ej. notificaciones complejas, cálculos intensivos). Se recomienda un uso inicial moderado.
*   **Gestión de Estado (Flutter):** BLoC (Business Logic Component) / Cubit.
*   **Pruebas:** Framework de pruebas de Flutter (para unitarias, widgets e integración).
*   **Control de Versiones:** Git (con una plataforma como GitHub, GitLab o Bitbucket).
*   **Contenerización (Opcional):** Docker, para estandarizar entornos de desarrollo/CI o para futuros microservicios.
*   **Seguridad:** Se utilizarán las reglas de seguridad de Firestore y las configuraciones de Firebase Authentication para asegurar la correcta segregación y acceso a los datos (cuando se implemente el backend).

## 2. Proceso Completo de Codificación

Esta guía describe un proceso repetible y estructurado para crear software de calidad de producción para Agenda Glam.

### 2.1. 🔑 Reglas de Oro

Estos son los principios generales que guían el uso eficiente y eficaz de las herramientas. Los implementaremos mediante reglas globales y nuestra guía durante todo el proceso:

*   Utilice archivos markdown para administrar el proyecto (`README.MD`, `PLANNING.MD` (este archivo), y archivos `TASK_nombre_tarea.MD` específicos para cada tarea o funcionalidad mayor).
*   Mantenga los archivos de código fuente por debajo de las **300 líneas**. Divídalos en módulos o componentes más pequeños cuando sea necesario.
*   Prueba pronto y con frecuencia. Toda función o widget nuevo debe incluir pruebas.
*   Escribe documentos y comentarios sobre la marcha. No retrases la documentación.

### 2.2. 🧠 Planificación y Gestión de Tareas

Antes de escribir cualquier código para una nueva funcionalidad, es importante conversar con el Ingeniero/programador para planificarla. El alcance general se incluye en `PLANNING.MD` (este documento). Las tareas específicas, pasos detallados y el progreso para una funcionalidad o módulo se detallarán en archivos `TASK_nombre_tarea.MD` dedicados. Cada archivo `TASK` se debe crear *antes* de iniciar las tareas correspondientes.

**`PLANNING.MD` (Este Documento)**
*   **Propósito:** Visión de alto nivel, arquitectura, restricciones, pila tecnológica, herramientas y directrices generales para el desarrollo de la aplicación completa Agenda Glam. No contiene detalles minuciosos de implementación diaria.
*   **Referencia:** Este archivo debe ser consultado al comienzo de cualquier conversación nueva relacionada con el proyecto.

**Archivos `TASK_nombre_tarea.MD`**
*   **Propósito:** Realiza un seguimiento de las tareas actuales, pasos detallados, tareas atrasadas y subtareas para una funcionalidad o módulo específico de Agenda Glam (ej. `TASK_PerfilProveedor.MD`, `TASK_FlujoReservaCliente.MD`). Se crea *antes* de comenzar a trabajar en la tarea.
*   **Incluye:** Lista con viñetas de trabajo activo, hitos y cualquier cosa descubierta a mitad del proceso para esa tarea específica.
*   **Referencia:** Para la tarea actual, consulta el `TASK_nombre_tarea.MD` correspondiente. Actualiza el archivo `TASK` para marcar pasos como terminados o agregar nuevas subtareas.

### 2.3. ⚙️ Directrices de Desarrollo

Estas directrices se aplicarán al desarrollo de Agenda Glam para asegurar la calidad, mantenibilidad y escalabilidad del código.

#### 🏗️ Arquitectura y Estructura

*   **Adherencia a Clean Architecture:** Mantener una separación estricta entre las capas de Presentación, Dominio y Datos. La lógica de negocio debe residir en el Dominio y ser independiente de la UI y los detalles de implementación de datos.
*   **Modularización:** Organizar el código en módulos cohesivos, preferiblemente agrupados por funcionalidad (feature-first). Cada módulo debe tener una responsabilidad clara y exponer una interfaz bien definida.
*   **Estructura de Carpetas:** Seguir una estructura de carpetas consistente dentro de cada módulo (ej. `presentation` (con `bloc`, `pages`, `widgets`), `domain` (con `entities`, `repositories`, `usecases`), `data` (con `datasources`, `models`, `repositories`)).

#### 📏 Tamaño y Complejidad de Archivos

*   **Límite de 300 Líneas:** Ningún archivo Dart debe superar las 300 líneas. Refactorizar proactivamente dividiendo clases, widgets o funciones grandes en unidades más pequeñas y enfocadas.
*   **Principio de Responsabilidad Única (SRP):** Cada clase, widget o función debe tener una única razón para cambiar. Evitar clases "todopoderosas".

#### ✨ Calidad y Buenas Prácticas de Codificación

*   **Legibilidad:** Escribir código claro, conciso y fácil de entender. Usar nombres descriptivos para variables, funciones y clases.
*   **Consistencia:** Seguir las guías de estilo oficiales de Dart y Flutter (`flutter analyze` debe pasar sin errores/warnings). Utilizar `dart format` regularmente.
*   **Comentarios y Documentación:**
    *   Escribir docstrings (`///`) para cada función, clase y widget público, explicando su propósito, parámetros y lo que retorna.
    *   Usar comentarios en línea (`//`) para explicar lógica compleja o decisiones no obvias (`// Razón: ...`).
    *   Mantener `README.MD` actualizado con instrucciones de configuración y descripción general.
*   **Inmutabilidad:** Preferir objetos inmutables siempre que sea posible, especialmente para modelos de datos y estados (usar `final` y paquetes como `freezed`).
*   **Manejo de Errores:** Implementar un manejo de errores robusto usando `try-catch`, resultados (Result type) o estados específicos en BLoC/Cubit para informar al usuario y evitar crashes.
*   **Evitar "Magic Strings/Numbers":** Definir constantes para valores literales que se repiten o cuyo significado no es obvio.

#### 📦 Gestión de Dependencias

*   **Uso Criterioso de Paquetes:** Evaluar cuidadosamente la necesidad y calidad de paquetes externos antes de añadirlos. Preferir paquetes bien mantenidos y populares de pub.dev.
*   **Inyección de Dependencias:** Utilizar un mecanismo de inyección de dependencias (como `get_it` o `provider`) para desacoplar componentes y facilitar las pruebas.

#### 🧪 Pruebas y Confiabilidad

*   **Cobertura de Pruebas:** Escribir pruebas unitarias para la lógica de negocio (Dominio) y los componentes de datos, y pruebas de widgets para la UI (Presentación).
*   **Pruebas Significativas:** Enfocarse en probar el comportamiento esperado, casos límite y manejo de errores.
*   **Organización:** Mantener la estructura de la carpeta `test/` reflejando la de `lib/`.

#### ✅ Finalización de Tareas

*   **Actualización de TASK:** Marcar tareas como completadas en el archivo `TASK_nombre_tarea.MD` correspondiente.
*   **Registro de Descubrimientos:** Añadir nuevas subtareas o TODOs identificados durante el desarrollo al archivo `TASK` relevante.

#### 🎨 Diseño y UX

*   **Consistencia Visual:** Aplicar el tema definido (Sección 3) de manera uniforme en toda la aplicación.
*   **Accesibilidad:** Considerar pautas de accesibilidad (WCAG) en el diseño de componentes (tamaño de fuentes, contraste, navegación).
*   **Estilo Específico:** Seguir las convenciones de estilo de Flutter/Dart y las específicas del proyecto (ej. uso de `freezed`, `flutter_bloc`).

#### 🔗 Interacciones Externas

*   **Firebase SDKs:** Utilizar los SDKs oficiales de Firebase para Flutter para interactuar con los servicios de Firebase.
*   **Seguridad:** Implementar reglas de seguridad adecuadas en Firestore y seguir las mejores prácticas de Firebase Authentication.

#### 🧠 Directrices Adicionales

*   **Contexto:** No hacer suposiciones; preguntar si falta contexto.
*   **Bibliotecas:** Usar solo paquetes verificados de pub.dev.
*   **Rutas y Nombres:** Confirmar la existencia de archivos/módulos antes de referenciarlos.
*   **Modificación de Código:** No eliminar/sobrescribir código existente sin indicación explícita o como parte de una tarea definida.
*   **Documentación Externa:** Consultar documentación actualizada antes de implementar funcionalidades complejas o interactuar con APIs/librerías. **Si es posible, utilizar el MCP `context7` para obtener la documentación más reciente.**

### 2.4. 💬 Enfoque de Desarrollo Inicial

Por el momento, el desarrollo se centrará exclusivamente en el **frontend**. Se priorizará el diseño de la interfaz de usuario (frontend) para cada módulo o flujo principal. Una vez que el diseño de un módulo esté claro, esto facilitará la definición precisa de los modelos de datos que necesitará el frontend. Los datos para las pruebas del frontend se ingresarán manualmente en el código (hardcodeados) o se mockearán según sea necesario. La integración con Firebase y la definición de la estructura de la base de datos se realizarán en una fase posterior, una vez que el frontend de los módulos clave esté bien definido.

### 2.5. ✅ Prueba Después de Cada Función

Escriba pruebas de widgets después de cada componente UI que implemente para Agenda Glam, o hágalo usted mismo. Las pruebas unitarias para lógica de UI (si la hubiera separada) también son importantes.

**Mejores prácticas para realizar pruebas en Flutter (enfocadas en frontend inicialmente):**
*   Crea las pruebas en un directorio `test/`.
*   Para pruebas de widgets, utiliza `flutter_test` para verificar que la UI se renderiza correctamente y responde a interacciones.
*   Utiliza datos mock o hardcodeados consistentes con los usados en el desarrollo del widget.

### 2.6. 🐳 Uso de Docker (Opcional)

La utilización de Docker en este proyecto es **opcional**, especialmente en las fases iniciales centradas en el frontend con Flutter y Firebase. Sin embargo, puede considerarse para:

*   **Estandarización del Entorno:** Asegurar que todos los desarrolladores y el sistema de Integración Continua (CI) utilicen exactamente las mismas versiones del SDK de Flutter, Dart y otras dependencias del sistema, evitando inconsistencias.
*   **Servicios Auxiliares:** Si en el futuro se desarrollan microservicios propios (ej. para tareas específicas de backend no cubiertas por Cloud Functions) o se necesita ejecutar localmente herramientas externas (ej. una base de datos para pruebas), Docker facilitaría su gestión.
*   **Builds Consistentes:** Crear un entorno aislado y reproducible para generar los artefactos de la aplicación (APK/IPA).

**Consideraciones:**
*   Añade una capa de complejidad inicial a la configuración del entorno de desarrollo.
*   Puede tener un ligero impacto en el rendimiento durante el desarrollo (dependiendo de la configuración y el sistema operativo).
*   Se recomienda evaluar su incorporación si surgen problemas de inconsistencia entre entornos o si la arquitectura del backend se expande más allá de Firebase.

## 3. Diseño General y Tema de la Aplicación (UI/UX)

Se buscará un estilo y diseño general **minimalista, elegante y con un enfoque estético masculino**, que se aplique consistentemente en toda la aplicación. Se priorizará una experiencia de usuario intuitiva y clara, considerando las guías de accesibilidad (WCAG).

### 3.1. Concepto Visual General 🎨

*   **Tema:** Oscuro (Dark Theme) predominante.
*   **Paleta Principal:** Azul marino profundo (primario), Dorado/Ámbar (acento), complementados con tonos de gris azulado oscuro para superficies y blanco/gris claro para textos.
*   **Sensación:** Profesional, moderna y sofisticada.

### 3.2. Tipografía ✒️

*   **Fuente:** Limpia y legible (ej. Roboto o similar).
*   **Jerarquía:** Clara distinción entre títulos, encabezados y cuerpo de texto mediante tamaño y peso.

### 3.3. Componentes Clave 🧩

Se definirán estilos consistentes en el `ThemeData` para elementos comunes como AppBar, botones (ElevatedButton, TextButton, OutlinedButton), campos de texto, tarjetas (Card), diálogos, etc., siguiendo la paleta y sensación general.

### 3.4. Implementación Inicial del Tema (Dart)

El `ThemeData` se definirá en un archivo dedicado (ej. `lib/core/theme/app_theme.dart`) y contendrá la configuración detallada de colores, tipografía y estilos de widgets. El siguiente es un ejemplo conceptual de la estructura y colores base (la implementación detallada se hará en el archivo de tema específico):

```dart
import 'package:flutter/material.dart';

// Paleta de colores base (Valores exactos en el archivo de tema)
const Color _primaryColor = Color(0xFF0A1128);      // Azul marino
const Color _accentColor = Color(0xFFFFC107);       // Dorado/Ámbar
const Color _backgroundColor = Color(0xFF050A14);   // Fondo oscuro
const Color _surfaceColor = Color(0xFF1E2A3B);      // Superficies oscuras
const Color _textColor = Color(0xFFFFFFFF);         // Texto principal
const Color _secondaryTextColor = Color(0xFFB0B8C1); // Texto secundario
const Color _errorColor = Color(0xFFCF6679);        // Error

/// ThemeData conceptual para Agenda Glam (Implementación detallada aparte).
final ThemeData appTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: _primaryColor,
  scaffoldBackgroundColor: _backgroundColor,
  colorScheme: const ColorScheme.dark(
    primary: _primaryColor,
    secondary: _accentColor,
    surface: _surfaceColor,
    background: _backgroundColor,
    error: _errorColor,
    onPrimary: _textColor,
    onSecondary: Colors.black, // Texto sobre acento
    onSurface: _textColor,
    onBackground: _textColor,
    onError: _textColor,
  ),
  // ... Definiciones resumidas o placeholders para textTheme, buttonThemes, etc.
  // La configuración completa estará en el archivo de tema dedicado.
  appBarTheme: const AppBarTheme(
     backgroundColor: _primaryColor,
     centerTitle: true,
     titleTextStyle: TextStyle(fontWeight: FontWeight.bold, color: _textColor, fontSize: 20),
  ),
   // Ejemplo muy básico de botón elevado
   elevatedButtonTheme: ElevatedButtonThemeData(
     style: ElevatedButton.styleFrom(
       backgroundColor: _accentColor,
       foregroundColor: Colors.black,
       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
     ),
   ),
   // ... etc.
);
```

Este documento de planificación general establece las bases para el desarrollo de la aplicación completa Agenda Glam, integrando un flujo de trabajo moderno y definiendo claramente el estilo visual y las directrices de codificación para maximizar la eficiencia y la calidad del software.