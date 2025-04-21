import 'package:new_project/features/venues/domain/entities/venue_entity.dart';
import 'package:new_project/features/venues/domain/entities/venue_filter_entity.dart';

class FilterVenuesParams {
  final List<VenueEntity> venues;
  final List<VenueFilterEntity> selectedFilters;

  FilterVenuesParams({required this.venues, required this.selectedFilters});
}
