import 'package:app_agenda_glam/features/explore/domain/models/service.dart';
import 'package:app_agenda_glam/features/explore/domain/models/service_category.dart';

/// Estado base para la página de exploración
abstract class ExploreState {
  const ExploreState();
  
  /// Método para manejar los diferentes estados (similar a pattern matching)
  T when<T>({
    required T Function() loading,
    required T Function(List<Service> services, List<ServiceCategory> categories, 
        List<Service> filteredServices, ServiceCategory? selectedCategory, 
        bool isUserLoggedIn) loaded,
    required T Function(String message) error,
  }) {
    if (this is ExploreLoadingState) {
      return loading();
    } else if (this is ExploreLoadedState) {
      final state = this as ExploreLoadedState;
      return loaded(
        state.services, 
        state.categories, 
        state.filteredServices, 
        state.selectedCategory, 
        state.isUserLoggedIn
      );
    } else if (this is ExploreErrorState) {
      return error((this as ExploreErrorState).message);
    }
    throw Exception('Unknown state type: $this');
  }
}

/// Estado de carga
class ExploreLoadingState extends ExploreState {
  const ExploreLoadingState();
}

/// Estado cuando los datos están cargados
class ExploreLoadedState extends ExploreState {
  final List<Service> services;
  final List<ServiceCategory> categories;
  final List<Service> filteredServices;
  final ServiceCategory? selectedCategory;
  final bool isUserLoggedIn;
  
  const ExploreLoadedState({
    required this.services,
    required this.categories,
    required this.filteredServices,
    this.selectedCategory,
    required this.isUserLoggedIn,
  });
}

/// Estado de error
class ExploreErrorState extends ExploreState {
  final String message;
  
  const ExploreErrorState({required this.message});
}
