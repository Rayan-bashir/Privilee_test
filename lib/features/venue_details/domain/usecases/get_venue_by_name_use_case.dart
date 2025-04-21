import 'package:collection/collection.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:new_project/core/error/failures.dart';
import 'package:new_project/features/venues/domain/entities/venue_entity.dart';
import 'package:new_project/features/venues/domain/repositories/venue_repository.dart';

@injectable
class GetVenueByNameUseCase {
  final VenueRepository repository;

  GetVenueByNameUseCase(this.repository);

  Future<Either<Failure, VenueEntity?>> call(String name) async {
    try {
      final response = await repository.getVenues(forceRefresh: false);
      final venue = response?.venues?.firstWhereOrNull((v) => v.name == name);
      return Right(venue);
    } catch (_) {
      return Left(UnexpectedFailure());
    }
  }
}
