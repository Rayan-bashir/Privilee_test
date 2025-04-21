import 'package:injectable/injectable.dart';
import 'package:new_project/core/error/failures.dart';
import 'package:new_project/features/venues/data/data_source/venue_local_data_source.dart';
import 'package:new_project/features/venues/data/data_source/venue_remote_data_source.dart';
import 'package:new_project/features/venues/data/mappers/venue_response_model_mapper.dart';
import 'package:new_project/features/venues/domain/entities/venues_response_entity.dart';
import 'package:new_project/features/venues/domain/repositories/venue_repository.dart';

@Injectable(as: VenueRepository)
class VenueRepositoryImpl implements VenueRepository {
  final VenueRemoteDataSource remoteDataSource;
  final VenueLocalDataSource localDataSource;
  final VenueResponseModelMapper venueResponseModelMapper;

  VenueRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.venueResponseModelMapper,
  });

  @override
  Future<VenueResponseEntity?> getVenues({bool forceRefresh = false}) async {
    try {
      if (forceRefresh) return _fetchAndCache();

      final cached = await localDataSource.getCachedVenues();
      if (cached != null) {
        return venueResponseModelMapper.map(cached);
      } else {
        return _fetchAndCache();
      }
    } catch (e) {
      if (e is ServerFailure) {
        // TODO: handle server errors here
        throw ServerFailure(message: e.message);
      } else {
        throw UnexpectedFailure();
      }
    }
  }

  /// fetches data from remote and caches it locally
  Future<VenueResponseEntity> _fetchAndCache() async {
    final response = await remoteDataSource.fetchVenues();
    await localDataSource.cacheVenues(response);
    return venueResponseModelMapper.map(response);
  }
}
