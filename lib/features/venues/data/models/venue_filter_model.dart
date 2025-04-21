class VenueFilter {
  final String? name;
  final String? type;
  final List<FilterCategory>? categories;

  VenueFilter({this.name, this.type, this.categories});

  factory VenueFilter.fromJson(Map<String, dynamic> json) => VenueFilter(
    name: json['name'],
    type: json['type'],
    categories:
        (json['categories'] as List?)
            ?.map((e) => FilterCategory.fromJson(e))
            .toList(),
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'type': type,
    'categories': categories?.map((e) => e.toJson()).toList(),
  };
}

class FilterCategory {
  final String? id;
  final String? name;

  FilterCategory({this.id, this.name});

  factory FilterCategory.fromJson(Map<String, dynamic> json) =>
      FilterCategory(id: json['id'], name: json['name']);

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}
