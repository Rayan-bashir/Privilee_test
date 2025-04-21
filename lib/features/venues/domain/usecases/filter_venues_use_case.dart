import 'package:injectable/injectable.dart';
import 'package:new_project/features/venues/domain/entities/venue_entity.dart';
import 'package:new_project/features/venues/domain/params/filter_venues_params.dart';

@injectable
class FilterVenuesUseCase {
  Future<List<VenueEntity>> call({
    required FilterVenuesParams filterVenuesParams,
  }) async {
    final activeCategoryIds =
        filterVenuesParams.selectedFilters
            .expand((filter) => filter.categories ?? [])
            .map((cat) => cat.id)
            .whereType<String>()
            .toSet();

    if (activeCategoryIds.isEmpty) return filterVenuesParams.venues;

    return filterVenuesParams.venues.where((venue) {
      final venueCategoryIds =
          venue.categories?.map((c) => c.id).whereType<String>().toSet() ?? {};
      return venueCategoryIds.any(activeCategoryIds.contains);
    }).toList();
  }
}
