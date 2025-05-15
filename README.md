# Agenda Glam

Aplicación móvil para la gestión de servicios de estética dirigidos al público masculino en Uruguay. Desarrollada con Flutter siguiendo los principios de Clean Architecture.

## 📋 Documentación del Proyecto

### Documentos Principales

| Documento | Descripción |
|-----------|-------------|
| [**PLANNING.MD**](./PLANNING.MD) | Visión general, alcance, público objetivo, funcionalidades clave y directrices de desarrollo del proyecto. Documento de referencia principal para entender el propósito y enfoque global. |
| [**ARCHITECTURE.MD**](./ARCHITECTURE.MD) | Arquitectura técnica detallada, estructura del proyecto, patrones de diseño, y sistemas clave (BLoC/Cubit, GetIt, Routing). Guía de referencia para decisiones de implementación. |

### Tareas y Progreso

Las tareas específicas se documentan en la carpeta `/tasks/` con archivos `TASK_nombre_tarea.MD`. Cada archivo detalla los objetivos, pasos, consideraciones y progreso de una funcionalidad o módulo específico.

| Tarea Completada | Descripción |
|------------------|-------------|
| [**TASK_ConfiguracionInicial.MD**](./tasks/TASK_ConfiguracionInicial.MD) | Configuración base del proyecto, dependencias, estructura de carpetas y tema. |
| [**TASK_DiseñoAutenticacionUI.MD**](./tasks/TASK_DiseñoAutenticacionUI.MD) | Refinamiento visual del flujo de autenticación, animaciones y experiencia de usuario. |
| [**TASK_FlujoAutenticacionUI.MD**](./tasks/TASK_FlujoAutenticacionUI.MD) | Implementación de pantallas y lógica UI para el proceso de autenticación. |

## 🗂️ Estructura del Proyecto

```
app_agenda_glam/
├── README.MD             # Este archivo - Guía principal del proyecto
├── PLANNING.MD           # Planificación estratégica del proyecto
├── ARCHITECTURE.MD       # Documentación técnica y arquitectónica detallada
├── pubspec.yaml          # Dependencias y configuración del proyecto Flutter
├── analysis_options.yaml # Configuración de linting y análisis
├── assets/               # Recursos estáticos (imágenes, iconos, fuentes)
│   ├── images/
│   ├── icons/
│   └── fonts/
├── lib/                  # Código fuente principal
│   ├── core/             # Funcionalidades transversales compartidas
│   ├── features/         # Módulos de funcionalidad (por feature)
│   └── main.dart         # Punto de entrada de la aplicación
├── tasks/                # Documentación de tareas específicas
│   └── TASK_*.MD
└── test/                 # Pruebas automatizadas
```

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
