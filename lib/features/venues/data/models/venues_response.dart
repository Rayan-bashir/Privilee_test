import 'package:new_project/features/venues/data/models/venue_filter_model.dart';
import 'package:new_project/features/venues/data/models/venue_model.dart';

class VenueResponse {
  final List<VenueFilter>? filters;
  final List<Venue>? items;
  final List<String>? cities;

  VenueResponse({this.filters, this.items, this.cities});

  factory VenueResponse.fromJson(Map<String, dynamic> json) => VenueResponse(
    filters: (json['filters'] as List?)?.map((e) => VenueFilter.fromJson(e)).toList(),
    items: (json['items'] as List?)?.map((e) => Venue.fromJson(e)).toList(),
    cities: (json['cities'] as List?)?.map((e) => e.toString()).toList(),
  );

  Map<String, dynamic> toJson() => {
    'filters': filters?.map((e) => e.toJson()).toList(),
    'items': items?.map((e) => e.toJson()).toList(),
    'cities': cities,
  };
}