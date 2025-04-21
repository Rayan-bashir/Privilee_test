import 'package:equatable/equatable.dart';
class VenueEntity extends Equatable {
  final String? section;
  final String? name;
  final String? city;
  final String? type;
  final CoordinatesEntity? coordinates;
  final String? location;
  final List<VenueImageEntity>? images;
  final List<CategoryEntity>? categories;
  final bool? accessibleForGuestPass;
  final String? specialNotice;
  final List<OverviewTextEntity>? overview;
  final List<ThingToDoEntity>? thingsToDo;

  const VenueEntity({
    this.section,
    this.name,
    this.city,
    this.type,
    this.coordinates,
    this.location,
    this.images,
    this.categories,
    this.accessibleForGuestPass,
    this.specialNotice,
    this.overview,
    this.thingsToDo,
  });

  @override
  List<Object?> get props => [
    section,
    name,
    city,
    type,
    coordinates,
    location,
    images,
    categories,
    accessibleForGuestPass,
    specialNotice,
    overview,
    thingsToDo,
  ];
}
class CoordinatesEntity extends Equatable {
  final double? lat;
  final double? lng;

  const CoordinatesEntity({this.lat, this.lng});

  @override
  List<Object?> get props => [lat, lng];
}

class VenueImageEntity extends Equatable {
  final String? url;

  const VenueImageEntity({this.url});

  @override
  List<Object?> get props => [url];
}

class CategoryEntity extends Equatable {
  final String? id;
  final String? name;
  final String? title;
  final List<String>? details;
  final bool? showOnVenuePage;

  const CategoryEntity({
    this.id,
    this.name,
    this.title,
    this.details,
    this.showOnVenuePage,
  });

  @override
  List<Object?> get props => [id, name, title, details, showOnVenuePage];
}

class OverviewTextEntity extends Equatable {
  final String? type;
  final String? text;

  const OverviewTextEntity({this.type, this.text});

  @override
  List<Object?> get props => [type, text];
}

class ThingToDoItemEntity extends Equatable {
  final String? title;
  final String? imageUrl;

  const ThingToDoItemEntity({this.title, this.imageUrl});

  @override
  List<Object?> get props => [title, imageUrl];
}

class ThingToDoEntity extends Equatable {
  final String? title;
  final String? badge;
  final String? subtitle;
  final List<ThingToDoItemEntity>? items;
  final List<String>? listItems;

  const ThingToDoEntity({
    this.title,
    this.badge,
    this.subtitle,
    this.items,
    this.listItems,
  });

  @override
  List<Object?> get props => [title, badge, subtitle, items, listItems];
}
