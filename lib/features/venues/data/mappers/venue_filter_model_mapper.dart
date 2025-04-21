import 'package:injectable/injectable.dart';
import 'package:new_project/features/venues/data/models/venue_filter_model.dart';
import 'package:new_project/features/venues/domain/entities/venue_filter_entity.dart';

@Injectable()
class VenueFilterModelMapper {
  final FilterCategoryModelMapper categoryMapper;

  VenueFilterModelMapper(this.categoryMapper);

  VenueFilterEntity map(VenueFilter? model) => VenueFilterEntity(
    name: model?.name ?? '',
    type: model?.type ?? '',
    categories: model?.categories?.map(categoryMapper.map).toList(),
  );
}

@Injectable()
class FilterCategoryModelMapper {
  FilterCategoryEntity map(FilterCategory? model) =>
      FilterCategoryEntity(id: model?.id ?? '', name: model?.name ?? '');
}
