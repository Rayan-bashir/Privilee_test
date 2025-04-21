import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:new_project/core/error/failures.dart';
import 'package:new_project/features/venues/domain/entities/venue_entity.dart';
import 'package:new_project/features/venues/domain/repositories/venue_repository.dart';

@injectable
class GetVenuesUseCase {
  final VenueRepository repository;

  GetVenuesUseCase(this.repository);

  Future<Either<Failure, List<VenueEntity>>> call({
    bool forceRefresh = false,
  }) async {
    try {
      final response = await repository.getVenues(forceRefresh: forceRefresh);
      final venues = response?.venues ?? [];
      if (venues.isEmpty) {
        return Left(NoItemsFoundFailure());
      } else {
        return Right(venues);
      }
    } catch (e) {
      // TODO: send the error to sentry or crashlytics
      return Left(UnexpectedFailure());
    }
  }
}
