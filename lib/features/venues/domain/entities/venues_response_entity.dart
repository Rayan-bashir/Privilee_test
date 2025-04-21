import 'package:equatable/equatable.dart';
import 'package:new_project/features/venues/domain/entities/venue_entity.dart';
import 'package:new_project/features/venues/domain/entities/venue_filter_entity.dart';

class VenueResponseEntity extends Equatable {
  final List<VenueEntity>? venues;
  final List<VenueFilterEntity>? filters;
  final List<String>? cities;

  const VenueResponseEntity({this.venues, this.filters, this.cities});

  @override
  List<Object?> get props => [venues, filters, cities];
}
