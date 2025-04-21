import 'package:injectable/injectable.dart';
import 'package:new_project/features/venues/data/models/venue_model.dart';
import 'package:new_project/features/venues/domain/entities/venue_entity.dart';

@Injectable()
class CoordinatesModelMapper {
  CoordinatesEntity map(Coordinates? model) => CoordinatesEntity(
    lat: model?.lat,
    lng: model?.lng,
  );
}

@Injectable()
class VenueImageModelMapper {
  VenueImageEntity map(VenueImage? model) => VenueImageEntity(url: model?.url);
}

@Injectable()
class CategoryModelMapper {
  CategoryEntity map(Category? model) => CategoryEntity(
    id: model?.id,
    name: model?.category,
    title: model?.title,
    details: model?.detail?.map((e) => e.text ?? '').toList(),
    showOnVenuePage: model?.showOnVenuePage,
  );
}

@Injectable()
class OverviewTextModelMapper {
  OverviewTextEntity map(OverviewText? model) => OverviewTextEntity(
    type: model?.type,
    text: model?.text,
  );
}

@Injectable()
class ThingToDoItemModelMapper {
  VenueImageModelMapper imageMapper;

  ThingToDoItemModelMapper(this.imageMapper);

  ThingToDoItemEntity map(ThingToDoItem? model) => ThingToDoItemEntity(
    title: model?.title,
    imageUrl: model?.image?.url,
  );
}

@Injectable()
class ThingToDoModelMapper {
  final ThingToDoItemModelMapper itemMapper;

  ThingToDoModelMapper(this.itemMapper);

  ThingToDoEntity map(ThingToDo? model) => ThingToDoEntity(
    title: model?.title,
    badge: model?.badge,
    subtitle: model?.subtitle,
    items: model?.items?.map(itemMapper.map).toList(),
    listItems: model?.content?.expand((e) => e.map((i) => i.text ?? '')).toList(),
  );
}

@Injectable()
class VenueModelMapper {
  final CoordinatesModelMapper coordinatesMapper;
  final VenueImageModelMapper imageMapper;
  final CategoryModelMapper categoryMapper;
  final OverviewTextModelMapper overviewMapper;
  final ThingToDoModelMapper thingToDoMapper;

  VenueModelMapper(
      this.coordinatesMapper,
      this.imageMapper,
      this.categoryMapper,
      this.overviewMapper,
      this.thingToDoMapper,
      );

  VenueEntity map(Venue? model) => VenueEntity(
    section: model?.section,
    name: model?.name,
    city: model?.city,
    type: model?.type,
    coordinates: coordinatesMapper.map(model?.coordinates),
    location: model?.location,
    images: model?.images?.map(imageMapper.map).toList(),
    categories: model?.categories?.map(categoryMapper.map).toList(),
    accessibleForGuestPass: model?.accessibleForGuestPass,
    specialNotice: model?.specialNotice,
    overview: model?.overviewText?.map(overviewMapper.map).toList(),
    thingsToDo: model?.thingsToDo?.map(thingToDoMapper.map).toList(),
  );
}