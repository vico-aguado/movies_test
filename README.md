# Movie App

[![Flutter](https://img.shields.io/badge/Flutter-3.27.1+-blue.svg)](https://flutter.dev)
[![GetX](https://img.shields.io/badge/GetX-State%20Management-blueviolet)](https://pub.dev/packages/get)

Movie App es una aplicación móvil desarrollada con Flutter que permite a los usuarios explorar películas populares, filtrarlas por título y ver detalles específicos de cada película. La aplicación está diseñada siguiendo los principios de **Clean Architecture** y utiliza bibliotecas modernas para mejorar la experiencia del usuario.

---

## Tabla de Contenidos

1. [Descripción del Proyecto](#descripción-del-proyecto)
2. [Características Principales](#características-principales)
3. [Tecnologías y Bibliotecas Utilizadas](#tecnologías-y-bibliotecas-utilizadas)
4. [Cómo Ejecutar el Proyecto](#cómo-ejecutar-el-proyecto)
5. [Estructura del Proyecto](#estructura-del-proyecto)
6. [Licencia](#licencia)

---

## Descripción del Proyecto

La aplicación **Movie App** consume datos de la API de [The Movie DB](https://www.themoviedb.org/) para mostrar una lista de películas populares. Las principales funcionalidades incluyen:

- Visualización de posters de películas en una cuadrícula.
- Filtrado local de películas por título en tiempo real.
- Navegación a una vista de detalle para ver más información sobre una película seleccionada.
- Cambio de idioma y tema (claro/oscuro) desde la pantalla de configuración.

El proyecto sigue los principios de **Clean Architecture**, lo que garantiza una separación clara entre las capas de presentación, dominio y datos, facilitando la escalabilidad y mantenimiento.

---

## Características Principales

- **Paginación**: Las películas se cargan en páginas para mejorar el rendimiento y evitar sobrecargar la memoria.
- **Búsqueda Local**: Los usuarios pueden filtrar películas por título sin realizar nuevas llamadas a la API.
- **Internacionalización**: La aplicación soporta múltiples idiomas (por ejemplo, inglés y español).
- **Tema Oscuro/Claro**: Los usuarios pueden cambiar el tema de la aplicación según sus preferencias.
- **Gestión de Estado**: Se utiliza **GetX** para la gestión de estado y navegación, lo que simplifica el flujo de datos y mejora la reactividad.

---

## Tecnologías y Bibliotecas Utilizadas

A continuación, se detallan las principales tecnologías y bibliotecas utilizadas en este proyecto:

| Tecnología/Biblioteca | Propósito                                                                 |
|------------------------|---------------------------------------------------------------------------|
| **Flutter**            | Framework utilizado para desarrollar la interfaz de usuario.             |
| **GetX**               | Biblioteca para la gestión de estado, dependencias y navegación.         |
| **Dio**                | Cliente HTTP para realizar solicitudes a la API de The Movie DB.         |
| **flutter_dotenv**     | Gestiona variables de entorno (como el token) para mayor seguridad.     |
| **shared_preferences** | Almacena las preferencias del usuario, como el idioma y el tema.          |
| **Clean Architecture** | Estructura el proyecto en capas (presentación, dominio, datos).           |

---

## Cómo Ejecutar el Proyecto

### Requisitos Previos

1. **Flutter SDK**: Asegúrate de tener instalado Flutter. Puedes descargarlo desde [aquí](https://flutter.dev/docs/get-started/install).
2. **API Key**: Necesitarás un token de The Movie DB. Obtén una gratis desde [The Movie DB](https://www.themoviedb.org/).

### Pasos para Ejecutar

1. Clona el repositorio:
   ```bash
   git clone https://github.com/vico-aguado/movies_test.git
   ```

2. **Instala las dependencias**:
   ```bash
   flutter pub get
   ```

3. **Configura las variables de entorno**:
   ```bash
   cp .env.example .env
   ```

4. **Ejecuta la aplicación**:
   ```bash
   flutter run
   ```

5. **Ejecuta las pruebas**:
   ```bash
   flutter test
   ```

---

## Estructura del Proyecto

El proyecto sigue una estructura basada en **Clean Architecture** y está organizado dentro de la carpeta `lib/app` para mantener un diseño limpio y modular. 
A continuación, se detalla la organización:

```plaintext
lib/
├── app/               # Carpeta principal de la aplicación
│   ├── app.dart       # Archivo con el widget GetMaterialApp (configuración global)
│   ├── core/          # Configuración global (tema, internacionalización, utilidades)
│   │   ├── constants/      # Constantes globales
│   │   ├── localization/   # Archivos de traducción e internacionalización
│   │   ├── theme/          # Configuración de temas (claro/oscuro)
│   │   └── utils/          # Utilidades generales (Dio, Preferences, etc.)
│   ├── data/          # Capa de datos (repositorios, modelos, fuentes de datos)
│   │   ├── models/         # Modelos de datos
│   │   └── repositories/   # Implementaciones de repositorios
│   ├── domain/        # Capa de dominio (casos de uso, entidades)
│   │   ├── entities/       # Entidades del dominio
│   │   ├── repositories/   # Interfaces de repositorios
│   │   └── usecases/       # Casos de uso
│   └── presentation/  # Capa de presentación (páginas, controladores, bindings)
│       ├── bindings/       # Bindings para inyección de dependencias
│       ├── controllers/    # Controladores GetX
│       ├── pages/          # Páginas de la aplicación
│       └── routes/         # Rutas de navegación
└── main.dart          # Punto de entrada de la aplicación
```

### Descripción de los Componentes Principales

- **`app.dart`**: Contiene la configuración global de la aplicación, como el tema, idioma y rutas principales usando `GetMaterialApp`.
- **`core/`**: Alberga componentes compartidos y globales, como la internacionalización, temas y utilidades.
- **`data/`**: Implementa la capa de datos, incluyendo modelos, repositorios y fuentes de datos.
- **`domain/`**: Define las reglas de negocio mediante entidades, interfaces de repositorio y casos de uso.
- **`presentation/`**: Contiene la lógica de la interfaz de usuario, como páginas, controladores, rutas y bindings.
- **`main.dart`**: Es el punto de entrada de la aplicación, donde se inicializa `app.dart`.

Esta estructura garantiza una separación clara entre las capas de la aplicación, facilitando su mantenimiento y escalabilidad.

--- 

## Licencia

Este proyecto está bajo la Licencia MIT.

---