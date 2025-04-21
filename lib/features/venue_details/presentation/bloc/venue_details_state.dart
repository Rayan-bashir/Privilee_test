part of 'venue_details_bloc.dart';

sealed class VenueDetailsState extends Equatable {
  const VenueDetailsState();

  @override
  List<Object?> get props => [];
}

class VenueDetailsInitial extends VenueDetailsState {}

class VenueDetailsLoading extends VenueDetailsState {}

class VenueDetailsLoaded extends VenueDetailsState {
  final VenueEntity? venue;

  const VenueDetailsLoaded(this.venue);

  @override
  List<Object?> get props => [venue];
}

class VenueDetailsError extends VenueDetailsState {
  final Failure failure;

  const VenueDetailsError(this.failure);

  @override
  List<Object?> get props => [failure];
}
