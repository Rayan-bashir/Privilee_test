import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:new_project/core/constants/local_keys.dart';
import 'package:new_project/features/venues/data/models/venues_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class VenueLocalDataSource {
  Future<void> cacheVenues(VenueResponse response);

  Future<VenueResponse?> getCachedVenues();
}

@LazySingleton(as: VenueLocalDataSource)
class VenueLocalDataSourceImpl implements VenueLocalDataSource {
  final SharedPreferences prefs;

  VenueLocalDataSourceImpl(this.prefs);

  @override
  Future<void> cacheVenues(VenueResponse response) async {
    final json = jsonEncode(response.toJson());
    await prefs.setString(LocalKeys.cachedVenuesKey, json);
  }

  @override
  Future<VenueResponse?> getCachedVenues() async {
    final jsonString = prefs.getString(LocalKeys.cachedVenuesKey);
    if (jsonString == null) return null;
    return VenueResponse.fromJson(jsonDecode(jsonString));
  }
}
