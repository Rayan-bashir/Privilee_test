import 'package:flutter/material.dart';
import 'package:new_project/features/venues/domain/entities/venue_filter_entity.dart';

class VenueTypeQuickFilterSection extends StatelessWidget {
  final List<VenueFilterEntity> venueFilters;
  final List<VenueFilterEntity> selectedFilters;
  final void Function(List<VenueFilterEntity>) onFilterChange;

  const VenueTypeQuickFilterSection({
    super.key,
    required this.venueFilters,
    required this.selectedFilters,
    required this.onFilterChange,
  });

  @override
  Widget build(BuildContext context) {
    final venueTypesFilter = venueFilters.firstWhere(
      (f) => f.name == 'Venue type',
      orElse: () => const VenueFilterEntity(),
    );

    final venueTypesCategories = venueTypesFilter.categories ?? [];
    if (venueTypesCategories.isEmpty) return const SizedBox.shrink();

    final selectedIds =
        selectedFilters
            .where((f) => f.name == venueTypesFilter.name)
            .expand((f) => f.categories ?? [])
            .map((c) => c.id)
            .toSet();

    return SizedBox(
      height: 50,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: venueTypesCategories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (_, index) {
          final type = venueTypesCategories[index];
          final isSelected = selectedIds.contains(type.id);

          return FilterChip(
            label: Text(type.name ?? ''),
            selected: isSelected,
            onSelected: (selected) {
              final List<FilterCategoryEntity> updatedCategories =
                  selected ? [type] : [];

              onFilterChange([
                VenueFilterEntity(
                  name: venueTypesFilter.name,
                  type: venueTypesFilter.type,
                  categories: updatedCategories,
                ),
              ]);
            },
          );
        },
      ),
    );
  }
}
