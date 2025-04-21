import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:new_project/core/error/failures.dart';
import 'package:new_project/features/venue_details/domain/usecases/get_venue_by_name_use_case.dart';
import 'package:new_project/features/venues/domain/entities/venue_entity.dart';

part 'venue_details_event.dart';
part 'venue_details_state.dart';

@injectable
class VenueDetailsBloc extends Bloc<VenueDetailsEvent, VenueDetailsState> {
  final GetVenueByNameUseCase getVenueByNameUseCase;

  VenueDetailsBloc(this.getVenueByNameUseCase) : super(VenueDetailsInitial()) {
    on<FetchVenueDetailsEvent>(_onFetchVenueDetails);
  }

  Future<void> _onFetchVenueDetails(
    FetchVenueDetailsEvent event,
    Emitter<VenueDetailsState> emit,
  ) async {
    emit(VenueDetailsLoading());
    final result = await getVenueByNameUseCase(event.name);
    result.fold(
      (failure) => emit(VenueDetailsError(failure)),
      (venue) => emit(VenueDetailsLoaded(venue)),
    );
  }
}
