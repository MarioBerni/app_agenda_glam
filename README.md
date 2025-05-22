# Agenda Glam

**Propósito**: Este documento es el punto de entrada principal para desarrolladores que trabajan en el proyecto Agenda Glam. Proporciona una visión general del proyecto, referencias a documentación detallada y guía para comenzar con el desarrollo.

## 📱 Descripción del Proyecto

Agenda Glam es una aplicación móvil para la gestión de servicios de estética dirigidos al público masculino en Uruguay. Desarrollada con Flutter siguiendo los principios de Clean Architecture.

### ✨ Características Principales

- **Sistema de Autenticación Completo**: Registro, inicio de sesión y recuperación de cuenta
- **Perfiles por Tipo de Usuario**: Propietario, Empleado y Cliente con funcionalidades específicas
- **Validación Robusta**: Verificación de correo electrónico y número de teléfono
- **Interfaz Elegante**: Diseño intuitivo con tema oscuro y animaciones fluidas

## 📚 Ecosistema de Documentación

| Documento | Propósito |
|-----------|-------------|
| [**README.md**](./README.md) | **Este documento** - Punto de entrada y visión general del proyecto |
| [**PLANNING.MD**](./PLANNING.MD) | Visión general, alcance, público objetivo y directrices de desarrollo |
| [**ARCHITECTURE.MD**](./ARCHITECTURE.MD) | Arquitectura técnica detallada, patrones de diseño y sistemas clave |
| [**STRUCTURE.md**](./STRUCTURE.md) | Estructura completa de directorios y archivos del proyecto |
| [**TESTING.MD**](./TESTING.MD) | Estrategia y directrices para pruebas (unitarias, widget, integración) |
| [**UI_COMPONENTS.md**](./UI_COMPONENTS.md) | Catálogo de componentes de UI reutilizables |

### 📋 Tareas y Progreso

Las tareas específicas se documentan en la carpeta `/tasks/` con archivos `TASK_nombre_tarea.MD`. Cada archivo detalla los objetivos, pasos y progreso de una funcionalidad específica.

| Tarea Completada | Descripción |
|------------------|-------------|
| [**TASK_ConfiguracionInicial.MD**](./tasks/TASK_ConfiguracionInicial.MD) | Configuración base del proyecto y tema |
| [**TASK_DiseñoAutenticacionUI.MD**](./tasks/TASK_DiseñoAutenticacionUI.MD) | Refinamiento visual del flujo de autenticación |
| [**TASK_FlujoAutenticacionUI.MD**](./tasks/TASK_FlujoAutenticacionUI.MD) | Implementación de pantallas de autenticación |
| [**TASK_MejoraRegistroUsuarios.MD**](./tasks/TASK_MejoraRegistroUsuarios.MD) | Selección de tipo de usuario y teléfono en registro |



## 🚀 Comenzando con el Desarrollo

### Prerequisitos

- Flutter SDK (última versión estable)
- Dart SDK (compatible con la versión de Flutter)
- Editor recomendado: VS Code o Android Studio

### Instalación

1. Clona este repositorio
2. Ejecuta `flutter pub get` para instalar dependencias
3. Consulta los documentos PLANNING.MD y ARCHITECTURE.MD para familiarizarte con el proyecto

### Flujo de Desarrollo

1. Consulta el archivo `PLANNING.MD` para entender la visión general del proyecto
2. Revisa `ARCHITECTURE.MD` para comprender los principios técnicos y patrones a seguir
3. Para trabajar en una tarea específica:
   - Consulta el archivo TASK correspondiente en la carpeta `/tasks/`
   - Sigue los pasos detallados en ese documento
   - Actualiza el estado de las subtareas a medida que avanzas

## 📝 Convenciones para Nuevas Tareas

Al crear un nuevo archivo TASK para una funcionalidad, utiliza la siguiente estructura:

```markdown
# Tarea: [Nombre de la Tarea]

## Referencias
- **ARCHITECTURE.MD:** Sección X.X (Componente Relevante)
- **Tareas Relacionadas:** TASK_OtraTarea.MD
- **Estado:** [Pendiente/En Progreso/Completada]

## Objetivos
[...]

## Pasos
[...]

## Consideraciones
[...]
```

## 📚 Directrices Clave

- Los archivos de código (Dart) no deben exceder las **300 líneas**
- Seguir los principios de Clean Architecture
- Organización por features (módulos funcionales)
- Usar BLoC/Cubit para gestión de estado
- Desarrollo frontend con datos mock (primera fase)
- UI masculina elegante con tema oscuro
- Validación robusta en todos los formularios
- Soporte para múltiples roles de usuario (Propietario, Empleado, Cliente)

## 🔍 Flujos Principales de Usuario

### Proceso de Registro

1. **Selección de Tipo de Usuario**: El usuario elige entre Propietario, Empleado o Cliente
2. **Información Personal**: Ingreso de nombre, teléfono y correo electrónico
3. **Configuración de Contraseña**: Creación de contraseña con validación visual de criterios
4. **Finalización**: Confirmación y redirección al flujo correspondiente según tipo de usuario
