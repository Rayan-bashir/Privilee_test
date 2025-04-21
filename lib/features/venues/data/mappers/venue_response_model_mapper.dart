import 'package:injectable/injectable.dart';
import 'package:new_project/features/venues/data/mappers/venue_filter_model_mapper.dart';
import 'package:new_project/features/venues/data/mappers/venue_model_mapper.dart';
import 'package:new_project/features/venues/data/models/venues_response.dart';
import 'package:new_project/features/venues/domain/entities/venues_response_entity.dart';

@Injectable()
class VenueResponseModelMapper {
  final VenueModelMapper venueMapper;
  final VenueFilterModelMapper filterMapper;

  VenueResponseModelMapper(this.venueMapper, this.filterMapper);

  VenueResponseEntity map(VenueResponse model) => VenueResponseEntity(
    venues: model.items?.map(venueMapper.map).toList(),
    filters: model.filters?.map(filterMapper.map).toList(),
    cities: model.cities,
  );
}
