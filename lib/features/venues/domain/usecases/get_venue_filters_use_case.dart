import 'package:injectable/injectable.dart';
import 'package:new_project/core/error/failures.dart';
import 'package:new_project/features/venues/domain/entities/venue_filter_entity.dart';
import 'package:new_project/features/venues/domain/repositories/venue_repository.dart';

@injectable
class GetVenueFiltersUseCase {
  final VenueRepository repository;

  GetVenueFiltersUseCase(this.repository);

  Future<List<VenueFilterEntity>> call({required bool forceRefresh}) async {
    try {
      final response = await repository.getVenues(forceRefresh: forceRefresh);
      return response?.filters ?? [];
    } catch (e) {
      // TODO: Add crash tracking
      throw UnexpectedFailure();
    }
  }
}
