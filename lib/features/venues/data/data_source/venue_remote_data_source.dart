import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:injectable/injectable.dart';
import 'package:new_project/core/constants/app_consts.dart';
import 'package:new_project/core/error/failures.dart';
import 'package:new_project/features/venues/data/models/venues_response.dart';

abstract class VenueRemoteDataSource {
  Future<VenueResponse> fetchVenues();
}

@Injectable(as: VenueRemoteDataSource)
class VenueRemoteDataSourceImpl implements VenueRemoteDataSource {
  final Dio dio;

  VenueRemoteDataSourceImpl({required this.dio});

  @override
  Future<VenueResponse> fetchVenues() async {
    try {
      /// get data from local json file for testing
      final jsonString = await rootBundle.loadString(
        '${AppConsts.mockPath}/hotels.json',
      );
      final jsonData = jsonDecode(jsonString);
      return VenueResponse.fromJson(jsonData);
    } catch (e) {
      // TODO: handling dio exceptions and throw errors from server
      if (e is DioException) {
        throw DioFailure(message: e.message);
      } else {
        throw ServerFailure(message: e.toString());
      }
    }
  }
}
