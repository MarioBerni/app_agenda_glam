import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_agenda_glam/features/explore/domain/models/service.dart';
import 'package:app_agenda_glam/features/explore/domain/models/service_category.dart';
import 'package:app_agenda_glam/features/explore/presentation/cubit/explore_state.dart';

/// Cubit para manejar el estado de la página de exploración
class ExploreCubit extends Cubit<ExploreState> {
  /// Constructor del ExploreCubit
  /// 
  /// [isUserLoggedIn] indica si el usuario está autenticado o no
  ExploreCubit({bool isUserLoggedIn = false}) : super(const ExploreLoadingState()) {
    // Inicializar el estado con datos de muestra
    loadExploreData(isUserLoggedIn: isUserLoggedIn);
  }

  /// Carga los datos de exploración (categorías y servicios)
  /// 
  /// [isUserLoggedIn] indica si el usuario está autenticado
  void loadExploreData({required bool isUserLoggedIn}) {
    emit(const ExploreLoadingState());
    
    try {
      // En una implementación real, estos datos vendrían de un repositorio
      final categories = ServiceCategory.getSampleCategories();
      final allServices = Service.getSampleServices();
      
      emit(ExploreLoadedState(
        services: allServices,
        categories: categories,
        filteredServices: allServices,
        selectedCategory: null,
        isUserLoggedIn: isUserLoggedIn,
      ));
    } catch (e) {
      emit(ExploreErrorState(message: 'Error al cargar datos: ${e.toString()}'));
    }
  }

  /// Filtra los servicios por categoría
  /// 
  /// [category] es la categoría seleccionada (puede ser nula para mostrar todos)
  void filterByCategory(ServiceCategory? category) {
    final currentState = state;
    
    if (currentState is ExploreLoadedState) {
      final filteredServices = category == null 
          ? currentState.services 
          : Service.filterByCategory(currentState.services, category.id);
      
      emit(ExploreLoadedState(
        services: currentState.services,
        categories: currentState.categories,
        filteredServices: filteredServices,
        selectedCategory: category,
        isUserLoggedIn: currentState.isUserLoggedIn,
      ));
    }
  }

  /// Actualiza el estado de autenticación del usuario
  /// 
  /// [isLoggedIn] indica si el usuario está autenticado o no
  void updateAuthStatus(bool isLoggedIn) {
    final currentState = state;
    
    if (currentState is ExploreLoadedState) {
      emit(ExploreLoadedState(
        services: currentState.services,
        categories: currentState.categories,
        filteredServices: currentState.filteredServices,
        selectedCategory: currentState.selectedCategory,
        isUserLoggedIn: isLoggedIn,
      ));
    }
  }

  /// Verifica si un servicio requiere registro para su uso completo
  /// 
  /// [service] es el servicio a verificar
  /// [isUserLoggedIn] indica si el usuario está autenticado
  /// 
  /// Retorna true si el servicio está disponible para el usuario actual
  bool isServiceAvailable(Service service, bool isUserLoggedIn) {
    if (service.availableWithoutRegistration) {
      return true;
    }
    return isUserLoggedIn;
  }
}
