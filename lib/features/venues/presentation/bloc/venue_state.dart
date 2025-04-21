part of 'venue_bloc.dart';

sealed class VenueState extends Equatable {
  @override
  List<Object?> get props => [];
}

class VenueInitial extends VenueState {}

class VenueLoading extends VenueState {}

class VenueLoaded extends VenueState {
  final List<VenueEntity> venues;
  final List<VenueFilterEntity>? filters;
  final List<VenueFilterEntity>? selectedFilters;

  VenueLoaded({required this.venues, this.filters, this.selectedFilters});

  @override
  List<Object?> get props => [venues, filters, selectedFilters];
}

class VenueError extends VenueState {
  final Failure failure;

  VenueError({required this.failure});

  @override
  List<Object> get props => [failure];
}
