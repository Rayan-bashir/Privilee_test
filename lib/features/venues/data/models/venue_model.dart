class Venue {
  final String? section;
  final String? name;
  final String? city;
  final String? type;
  final Coordinates? coordinates;
  final String? location;
  final List<VenueImage>? images;
  final List<Category>? categories;
  final Map<String, dynamic>? openingHours;
  final bool? accessibleForGuestPass;
  final String? specialNotice;
  final List<OverviewText>? overviewText;
  final List<ThingToDo>? thingsToDo;

  Venue({
    this.section,
    this.name,
    this.city,
    this.type,
    this.coordinates,
    this.location,
    this.images,
    this.categories,
    this.openingHours,
    this.accessibleForGuestPass,
    this.specialNotice,
    this.overviewText,
    this.thingsToDo,
  });

  factory Venue.fromJson(Map<String, dynamic> json) => Venue(
    section: json['section'],
    name: json['name'],
    city: json['city'],
    type: json['type'],
    coordinates:
        json['coordinates'] != null
            ? Coordinates.fromJson(json['coordinates'])
            : null,
    location: json['location'],
    images:
        (json['images'] as List?)?.map((e) => VenueImage.fromJson(e)).toList(),
    categories:
        (json['categories'] as List?)
            ?.map((e) => Category.fromJson(e))
            .toList(),
    openingHours: json['openingHours'],
    accessibleForGuestPass: json['accessibleForGuestPass'],
    specialNotice: json['specialNotice'],
    overviewText:
        (json['overviewText'] as List?)
            ?.map((e) => OverviewText.fromJson(e))
            .toList(),
    thingsToDo:
        (json['thingsToDo'] as List?)
            ?.map((e) => ThingToDo.fromJson(e))
            .toList(),
  );

  Map<String, dynamic> toJson() => {
    'section': section,
    'name': name,
    'city': city,
    'type': type,
    'coordinates': coordinates?.toJson(),
    'location': location,
    'images': images?.map((e) => e.toJson()).toList(),
    'categories': categories?.map((e) => e.toJson()).toList(),
    'openingHours': openingHours,
    'accessibleForGuestPass': accessibleForGuestPass,
    'specialNotice': specialNotice,
    'overviewText': overviewText?.map((e) => e.toJson()).toList(),
    'thingsToDo': thingsToDo?.map((e) => e.toJson()).toList(),
  };
}

class Coordinates {
  final double? lat;
  final double? lng;

  Coordinates({this.lat, this.lng});

  factory Coordinates.fromJson(Map<String, dynamic> json) =>
      Coordinates(lat: json['lat']?.toDouble(), lng: json['lng']?.toDouble());

  Map<String, dynamic> toJson() => {'lat': lat, 'lng': lng};
}

class VenueImage {
  final String? url;

  VenueImage({this.url});

  factory VenueImage.fromJson(Map<String, dynamic> json) =>
      VenueImage(url: json['url']);

  Map<String, dynamic> toJson() => {'url': url};
}

class Category {
  final String? id;
  final String? category;
  final String? title;
  final List<CategoryDetail>? detail;
  final bool? showOnVenuePage;

  Category({
    this.id,
    this.category,
    this.title,
    this.detail,
    this.showOnVenuePage,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json['id'],
    category: json['category'],
    title: json['title'],
    detail:
        (json['detail'] as List?)
            ?.map((e) => CategoryDetail.fromJson(e))
            .toList(),
    showOnVenuePage: json['showOnVenuePage'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'category': category,
    'title': title,
    'detail': detail?.map((e) => e.toJson()).toList(),
    'showOnVenuePage': showOnVenuePage,
  };
}

class CategoryDetail {
  final String? type;
  final String? text;

  CategoryDetail({this.type, this.text});

  factory CategoryDetail.fromJson(Map<String, dynamic> json) =>
      CategoryDetail(type: json['type'], text: json['text']);

  Map<String, dynamic> toJson() => {'type': type, 'text': text};
}

class OverviewText {
  final String? type;
  final String? text;
  final String? direction;

  OverviewText({this.type, this.text, this.direction});

  factory OverviewText.fromJson(Map<String, dynamic> json) => OverviewText(
    type: json['type'],
    text: json['text'],
    direction: json['direction'],
  );

  Map<String, dynamic> toJson() => {
    'type': type,
    'text': text,
    'direction': direction,
  };
}

class ThingToDo {
  final String? title;
  final String? badge;
  final String? subtitle;
  final List<ThingToDoItem>? items;
  final List<List<CategoryDetail>>? content;

  ThingToDo({this.title, this.badge, this.subtitle, this.items, this.content});

  factory ThingToDo.fromJson(Map<String, dynamic> json) => ThingToDo(
    title: json['title'],
    badge: json['badge'],
    subtitle: json['subtitle'],
    items:
        (json['items'] as List?)
            ?.map((e) => ThingToDoItem.fromJson(e))
            .toList(),
    content:
        (json['content'] as List?)
            ?.map(
              (e) =>
                  (e as List).map((i) => CategoryDetail.fromJson(i)).toList(),
            )
            .toList(),
  );

  Map<String, dynamic> toJson() => {
    'title': title,
    'badge': badge,
    'subtitle': subtitle,
    'items': items?.map((e) => e.toJson()).toList(),
    'content':
        content?.map((list) => list.map((e) => e.toJson()).toList()).toList(),
  };
}

class ThingToDoItem {
  final String? title;
  final VenueImage? image;

  ThingToDoItem({this.title, this.image});

  factory ThingToDoItem.fromJson(Map<String, dynamic> json) => ThingToDoItem(
    title: json['title'],
    image: json['image'] != null ? VenueImage.fromJson(json['image']) : null,
  );

  Map<String, dynamic> toJson() => {'title': title, 'image': image?.toJson()};
}
