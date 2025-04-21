import 'package:new_project/features/venues/domain/entities/venues_response_entity.dart';

abstract class VenueRepository {
  Future<VenueResponseEntity?> getVenues({bool forceRefresh = false});
}
