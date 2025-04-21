part of 'venue_details_bloc.dart';

sealed class VenueDetailsEvent extends Equatable {
  const VenueDetailsEvent();

  @override
  List<Object?> get props => [];
}

class FetchVenueDetailsEvent extends VenueDetailsEvent {
  final String name;

  const FetchVenueDetailsEvent(this.name);

  @override
  List<Object?> get props => [name];
}
