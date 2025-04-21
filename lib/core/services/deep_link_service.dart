import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:new_project/core/constants/app_routes.dart';

class DeepLinkService {
  final AppLinks _appLinks = AppLinks();
  final GoRouter _router;

  DeepLinkService(this._router);

  Future<void> init() async {
    try {
      final initialUri = await _appLinks.getInitialLink();
      _handleUri(initialUri);
    } catch (_) {}
    _appLinks.uriLinkStream.listen(_handleUri);
  }

  void _handleUri(Uri? uri) {
    if (uri != null && uri.host == 'venue') {
      final name = uri.queryParameters['name'];
      if (name != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _router.goNamed(
            AppRoutes.venueDetailsName,
            pathParameters: {'name': name},
          );
        });
      }
    }
  }
}
