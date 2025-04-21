// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:new_project/features/venue_details/domain/usecases/get_venue_by_name_use_case.dart'
    as _i744;
import 'package:new_project/features/venue_details/presentation/bloc/venue_details_bloc.dart'
    as _i135;
import 'package:new_project/features/venues/data/data_source/venue_local_data_source.dart'
    as _i876;
import 'package:new_project/features/venues/data/data_source/venue_remote_data_source.dart'
    as _i559;
import 'package:new_project/features/venues/data/mappers/venue_filter_model_mapper.dart'
    as _i8;
import 'package:new_project/features/venues/data/mappers/venue_model_mapper.dart'
    as _i365;
import 'package:new_project/features/venues/data/mappers/venue_response_model_mapper.dart'
    as _i747;
import 'package:new_project/features/venues/data/repositories/venue_repository_impl.dart'
    as _i356;
import 'package:new_project/features/venues/domain/repositories/venue_repository.dart'
    as _i567;
import 'package:new_project/features/venues/domain/usecases/filter_venues_use_case.dart'
    as _i527;
import 'package:new_project/features/venues/domain/usecases/get_venue_filters_use_case.dart'
    as _i965;
import 'package:new_project/features/venues/domain/usecases/get_venues_use_case.dart'
    as _i231;
import 'package:new_project/features/venues/presentation/bloc/venue_bloc.dart'
    as _i975;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i8.FilterCategoryModelMapper>(
      () => _i8.FilterCategoryModelMapper(),
    );
    gh.factory<_i365.CoordinatesModelMapper>(
      () => _i365.CoordinatesModelMapper(),
    );
    gh.factory<_i365.VenueImageModelMapper>(
      () => _i365.VenueImageModelMapper(),
    );
    gh.factory<_i365.CategoryModelMapper>(() => _i365.CategoryModelMapper());
    gh.factory<_i365.OverviewTextModelMapper>(
      () => _i365.OverviewTextModelMapper(),
    );
    gh.factory<_i527.FilterVenuesUseCase>(() => _i527.FilterVenuesUseCase());
    gh.lazySingleton<_i876.VenueLocalDataSource>(
      () => _i876.VenueLocalDataSourceImpl(gh<_i460.SharedPreferences>()),
    );
    gh.factory<_i365.ThingToDoItemModelMapper>(
      () => _i365.ThingToDoItemModelMapper(gh<_i365.VenueImageModelMapper>()),
    );
    gh.factory<_i559.VenueRemoteDataSource>(
      () => _i559.VenueRemoteDataSourceImpl(dio: gh<_i361.Dio>()),
    );
    gh.factory<_i8.VenueFilterModelMapper>(
      () => _i8.VenueFilterModelMapper(gh<_i8.FilterCategoryModelMapper>()),
    );
    gh.factory<_i365.ThingToDoModelMapper>(
      () => _i365.ThingToDoModelMapper(gh<_i365.ThingToDoItemModelMapper>()),
    );
    gh.factory<_i365.VenueModelMapper>(
      () => _i365.VenueModelMapper(
        gh<_i365.CoordinatesModelMapper>(),
        gh<_i365.VenueImageModelMapper>(),
        gh<_i365.CategoryModelMapper>(),
        gh<_i365.OverviewTextModelMapper>(),
        gh<_i365.ThingToDoModelMapper>(),
      ),
    );
    gh.factory<_i747.VenueResponseModelMapper>(
      () => _i747.VenueResponseModelMapper(
        gh<_i365.VenueModelMapper>(),
        gh<_i8.VenueFilterModelMapper>(),
      ),
    );
    gh.factory<_i567.VenueRepository>(
      () => _i356.VenueRepositoryImpl(
        remoteDataSource: gh<_i559.VenueRemoteDataSource>(),
        localDataSource: gh<_i876.VenueLocalDataSource>(),
        venueResponseModelMapper: gh<_i747.VenueResponseModelMapper>(),
      ),
    );
    gh.factory<_i231.GetVenuesUseCase>(
      () => _i231.GetVenuesUseCase(gh<_i567.VenueRepository>()),
    );
    gh.factory<_i965.GetVenueFiltersUseCase>(
      () => _i965.GetVenueFiltersUseCase(gh<_i567.VenueRepository>()),
    );
    gh.factory<_i744.GetVenueByNameUseCase>(
      () => _i744.GetVenueByNameUseCase(gh<_i567.VenueRepository>()),
    );
    gh.factory<_i975.VenueBloc>(
      () => _i975.VenueBloc(
        gh<_i231.GetVenuesUseCase>(),
        gh<_i965.GetVenueFiltersUseCase>(),
        gh<_i527.FilterVenuesUseCase>(),
      ),
    );
    gh.factory<_i135.VenueDetailsBloc>(
      () => _i135.VenueDetailsBloc(gh<_i744.GetVenueByNameUseCase>()),
    );
    return this;
  }
}
