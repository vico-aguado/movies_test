import 'package:get/get.dart';

class AppLocalizations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': {
          'home': 'Movies',
          'settings': 'Settings',
          'change_language': 'Change Language',
          'change_theme': 'Change Theme',
          'light_mode': 'Light Mode',
          'dark_mode': 'Dark Mode',
          'search': 'Search',
          'release_date': 'Release Date',
          'genres': 'Genres',
          'auth_error': 'Access not authorized. Verify your token.',
          'generic_error': 'An error occurred:',
          'error_loading_movies': 'Error loading movies.',
        },
        'es': {
          'home': 'Películas',
          'settings': 'Configuración',
          'change_language': 'Cambiar Idioma',
          'change_theme': 'Cambiar Tema',
          'light_mode': 'Modo Claro',
          'dark_mode': 'Modo Oscuro',
          'search': 'Buscar',
          'release_date': 'Fecha de Lanzamiento',
          'genres': 'Géneros',
          'auth_error': 'Acceso no autorizado. Verifica tu token.',
          'generic_error': 'Ocurrió un error:',
          'error_loading_movies': 'No se pudieron cargar películas.',
        },
      };
}
