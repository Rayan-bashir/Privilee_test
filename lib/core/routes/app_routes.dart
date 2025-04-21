import 'package:go_router/go_router.dart';
import 'package:new_project/core/constants/app_routes.dart';
import 'package:new_project/features/common/presentation/screens/splash_screen.dart';
import 'package:new_project/features/venue_details/presentation/screens/venue_details_screen.dart';
import 'package:new_project/features/venues/presentation/screens/venue_list_screen.dart';

class AppRouter {
  final GoRouter router;

  AppRouter()
    : router = GoRouter(
        initialLocation: '/',
        routes: [
          GoRoute(
            path: AppRoutes.splash,
            builder: (context, state) => const SplashScreen(),
          ),
          GoRoute(
            path: AppRoutes.venues,
            builder: (context, state) => const VenueListScreen(),
          ),
          GoRoute(
            path: AppRoutes.venueDetails,
            name: AppRoutes.venueDetailsName,
            builder: (context, state) {
              final name = state.pathParameters['name'] ?? '';
              return VenueDetailsScreen(venueName: name);
            },
          ),
        ],
      );
}
