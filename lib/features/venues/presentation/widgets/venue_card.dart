import 'package:flutter/material.dart';
import 'package:new_project/features/common/presentation/widgets/image_carousel.dart';
import 'package:new_project/features/venues/domain/entities/venue_entity.dart';

class VenueCard extends StatelessWidget {
  final VenueEntity venue;
  final VoidCallback? onTap;

  const VenueCard({required this.venue, this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: SizedBox(
              height: 120,
              child: ImageCarousel(images: venue.images ?? []),
            ),
          ),
          SizedBox(height: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                venue.name ?? '',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                '${venue.location ?? '-'}, ${venue.city ?? '-'}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 11, color: Colors.grey[600]),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
