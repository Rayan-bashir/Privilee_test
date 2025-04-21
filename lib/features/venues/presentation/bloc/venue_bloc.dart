import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:new_project/core/error/failures.dart';
import 'package:new_project/features/venues/domain/entities/venue_entity.dart';
import 'package:new_project/features/venues/domain/entities/venue_filter_entity.dart';
import 'package:new_project/features/venues/domain/params/filter_venues_params.dart';
import 'package:new_project/features/venues/domain/usecases/filter_venues_use_case.dart';
import 'package:new_project/features/venues/domain/usecases/get_venue_filters_use_case.dart';
import 'package:new_project/features/venues/domain/usecases/get_venues_use_case.dart';

part 'venue_event.dart';
part 'venue_state.dart';

@injectable
class VenueBloc extends Bloc<VenueEvent, VenueState> {
  final GetVenuesUseCase getVenues;
  final GetVenueFiltersUseCase getFilteredVenues;
  final FilterVenuesUseCase filterVenuesUseCase;

  VenueBloc(this.getVenues, this.getFilteredVenues, this.filterVenuesUseCase)
    : super(VenueInitial()) {
    on<InitVenuesEvent>(_onInitVenues);
    on<FetchVenueFiltersEvent>(_onFetchVenueFilters);
    on<FilterVenuesEvent>(_onFilterVenues);
  }

  Future<void> _onInitVenues(
    InitVenuesEvent event,
    Emitter<VenueState> emit,
  ) async {
    emit(VenueLoading());
    try {
      final venuesResult = await getVenues.call(forceRefresh: true);
      venuesResult.fold(
        (failure) {
          emit(VenueError(failure: failure));
        },
        (venues) {
          emit(VenueLoaded(venues: venues));
          add(FetchVenueFiltersEvent());
        },
      );
    } catch (e) {
      emit(VenueError(failure: UnexpectedFailure()));
    }
  }

  void _onFetchVenueFilters(
    FetchVenueFiltersEvent event,
    Emitter<VenueState> emit,
  ) async {
    try {
      final filters = await getFilteredVenues.call(forceRefresh: true);
      final currentState = state;

      if (currentState is VenueLoaded) {
        emit(VenueLoaded(venues: currentState.venues, filters: filters));
      }
    } catch (e) {
      emit(VenueError(failure: UnexpectedFailure()));
    }
  }

  Future<void> _onFilterVenues(
    FilterVenuesEvent event,
    Emitter<VenueState> emit,
  ) async {
    if (state is! VenueLoaded) return;

    final currentState = state as VenueLoaded;

    emit(VenueLoading());

    try {
      /// best practice to fetch the from memory source (singleton class) to avoid handling the errors again
      final result = await getVenues.call(forceRefresh: false);

      if (result.isLeft()) {
        final failure = result.swap().getOrElse(() => UnexpectedFailure());
        emit(VenueError(failure: failure));
        return;
      }

      final venues = result.getOrElse(() => []);
      final filteredVenues = await filterVenuesUseCase.call(
        filterVenuesParams: FilterVenuesParams(
          venues: venues,
          selectedFilters: event.selectedFilters,
        ),
      );

      emit(
        VenueLoaded(
          venues: filteredVenues,
          filters: currentState.filters,
          selectedFilters: event.selectedFilters,
        ),
      );
    } catch (_) {
      emit(VenueError(failure: UnexpectedFailure()));
    }
  }
}
