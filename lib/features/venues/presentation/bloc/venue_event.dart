part of 'venue_bloc.dart';

sealed class VenueEvent extends Equatable {
  const VenueEvent();

  @override
  List<Object?> get props => [];
}

class InitVenuesEvent extends VenueEvent {}

class FetchVenueFiltersEvent extends VenueEvent {}

class FilterVenuesEvent extends VenueEvent {
  final List<VenueFilterEntity> selectedFilters;

  const FilterVenuesEvent({required this.selectedFilters});

  @override
  List<Object?> get props => [selectedFilters];
}
