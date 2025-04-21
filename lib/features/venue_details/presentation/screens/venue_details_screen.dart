import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:new_project/core/constants/app_routes.dart';
import 'package:new_project/core/di/injection.dart';
import 'package:new_project/core/error/failures.dart';
import 'package:new_project/features/common/presentation/widgets/image_carousel.dart';
import 'package:new_project/features/venue_details/presentation/bloc/venue_details_bloc.dart';
import 'package:new_project/features/venue_details/presentation/widgets/venue_map.dart';
import 'package:new_project/features/venues/domain/entities/venue_entity.dart';

class VenueDetailsScreen extends StatelessWidget {
  final String venueName;

  const VenueDetailsScreen({super.key, required this.venueName});

  static Future<Future<Object?>> navigate(
    BuildContext context,
    String venueName,
  ) async {
    return context.pushNamed(
      AppRoutes.venueDetailsName,
      pathParameters: {'name': venueName},
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (_) =>
              getIt<VenueDetailsBloc>()..add(FetchVenueDetailsEvent(venueName)),
      child: const _VenueDetailsView(),
    );
  }
}

class _VenueDetailsView extends StatelessWidget {
  const _VenueDetailsView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Venue Details")),
      body: BlocBuilder<VenueDetailsBloc, VenueDetailsState>(
        builder: (context, state) {
          switch (state) {
            case VenueDetailsLoading():
              return const Center(child: CircularProgressIndicator());

            case VenueDetailsLoaded(:final venue):
              return venue != null
                  ? _VenueDetailsBody(venue)
                  : const Center(child: Text("Venue not found."));

            case VenueDetailsError(:final failure):
              return _ErrorView(failure);

            default:
              return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}

class _VenueDetailsBody extends StatelessWidget {
  final VenueEntity venue;

  const _VenueDetailsBody(this.venue);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _VenueImageGallery(images: venue.images ?? []),
        const SizedBox(height: 16),
        Text(
          venue.name ?? '-',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 8),
        Text(
          '${venue.location ?? '-'}, ${venue.city ?? '-'}',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: 16),
        if (venue.overview?.isNotEmpty == true)
          ...venue.overview!.map(
            (e) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Text(e.text ?? ''),
            ),
          ),
        const SizedBox(height: 16),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: venue.thingsToDo!.length,
          separatorBuilder: (_, __) => const Divider(height: 8),
          itemBuilder: (context, index) {
            final item = venue.thingsToDo![index];
            return _ThingsToDoCard(
              title: item.title,
              badge: item.badge,
              subtitle: item.subtitle,
            );
          },
        ),
        if (venue.coordinates != null &&
            venue.coordinates!.lat != null &&
            venue.coordinates!.lng != null)
          VenueMap(
            latitude: venue.coordinates!.lat!,
            longitude: venue.coordinates!.lng!,
          ),
      ],
    );
  }
}

class _VenueImageGallery extends StatelessWidget {
  final List<VenueImageEntity> images;

  const _VenueImageGallery({required this.images});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: ImageCarousel(images: images),
      ),
    );
  }
}

class _ThingsToDoCard extends StatelessWidget {
  final String? title;
  final String? badge;
  final String? subtitle;

  const _ThingsToDoCard({this.title, this.badge, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  title ?? '-',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              if (badge != null)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    badge!,
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ),
            ],
          ),
          if (subtitle != null)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                subtitle!,
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: Colors.grey[700]),
              ),
            ),
        ],
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final Failure failure;

  const _ErrorView(this.failure);

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(failure.message ?? "An error occurred"));
  }
}
