import 'package:flutter/material.dart';
import 'package:app_agenda_glam/core/theme/colors.dart';
import 'package:app_agenda_glam/core/utils/color_utils.dart';
import 'package:app_agenda_glam/core/animations/glam_animations.dart';
import 'package:app_agenda_glam/features/explore/domain/models/service_category.dart';

/// Widget para filtrar servicios por categoría
class CategoryFilter extends StatefulWidget {
  /// Lista de categorías para mostrar
  final List<ServiceCategory> categories;
  
  /// Callback cuando se selecciona una categoría
  final Function(ServiceCategory?) onCategorySelected;
  
  /// Categoría actualmente seleccionada (puede ser nula)
  final ServiceCategory? selectedCategory;

  const CategoryFilter({
    super.key,
    required this.categories,
    required this.onCategorySelected,
    this.selectedCategory,
  });

  @override
  State<CategoryFilter> createState() => _CategoryFilterState();
}

class _CategoryFilterState extends State<CategoryFilter> {
  late ServiceCategory? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.selectedCategory;
  }

  @override
  void didUpdateWidget(CategoryFilter oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedCategory != oldWidget.selectedCategory) {
      _selectedCategory = widget.selectedCategory;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Título de la sección de filtros
        Padding(
          padding: const EdgeInsets.only(left: 24, right: 24, bottom: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Filtrar por',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              // Botón para limpiar el filtro
              if (_selectedCategory != null)
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedCategory = null;
                    });
                    widget.onCategorySelected(null);
                  },
                  child: const Text(
                    'Mostrar todos',
                    style: TextStyle(
                      color: kAccentColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
            ],
          ),
        ),
        
        // Lista horizontal de categorías
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: widget.categories.length,
            itemBuilder: (context, index) {
              final category = widget.categories[index];
              final isSelected = _selectedCategory?.id == category.id;
              
              return GlamAnimations.applyEntryEffect(
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedCategory = category;
                    });
                    widget.onCategorySelected(category);
                  },
                  child: Container(
                    width: 100,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: isSelected 
                          ? ColorUtils.withOpacityValue(kAccentColor, 0.2)
                          : ColorUtils.withOpacityValue(kSurfaceColor, 0.7),
                      borderRadius: BorderRadius.circular(12),
                      border: isSelected
                          ? Border.all(color: kAccentColor, width: 2)
                          : null,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Icono de la categoría
                        Icon(
                          category.icon,
                          color: isSelected ? kAccentColor : Colors.white70,
                          size: 36,
                        ),
                        const SizedBox(height: 8),
                        // Nombre de la categoría
                        Text(
                          category.name,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                            color: isSelected ? kAccentColor : Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        // Descripción breve (opcional, solo si hay espacio)
                        if (!isSelected)
                          const SizedBox(height: 4),
                        if (!isSelected)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              category.description,
                              style: const TextStyle(
                                fontSize: 10,
                                color: Colors.white60,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                // Usamos duración manual para escalonar los elementos
                duration: Duration(milliseconds: 600 + (100 * index)),
              );
            },
          ),
        ),
      ],
    );
  }
}
