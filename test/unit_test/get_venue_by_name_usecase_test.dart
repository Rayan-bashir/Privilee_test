import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:new_project/core/error/failures.dart';
import 'package:new_project/features/venue_details/domain/usecases/get_venue_by_name_use_case.dart';
import 'package:new_project/features/venues/domain/entities/venue_entity.dart';
import 'package:new_project/features/venues/domain/entities/venues_response_entity.dart';
import 'package:new_project/features/venues/domain/repositories/venue_repository.dart';

import 'get_venue_by_name_usecase_test.mocks.dart';

@GenerateMocks([VenueRepository])
void main() {
  late GetVenueByNameUseCase useCase;
  late MockVenueRepository mockRepository;

  setUp(() {
    mockRepository = MockVenueRepository();
    useCase = GetVenueByNameUseCase(mockRepository);
  });

  const testVenueName = 'Test Venue';
  final testVenue = VenueEntity(name: testVenueName);

  group('GetVenueByNameUseCase', () {
    test('should return venue when name is found', () async {
      when(
        mockRepository.getVenues(),
      ).thenAnswer((_) async => VenueResponseEntity(venues: [testVenue, VenueEntity(name: 'Other')]));

      final result = await useCase(testVenueName);

      expect(result, Right(testVenue));
    });

    test('should return null when venue name is not found', () async {
      when(mockRepository.getVenues()).thenAnswer(
        (_) async => VenueResponseEntity(venues: [VenueEntity(name: 'Other')]),
      );

      final result = await useCase(testVenueName);

      expect(result, const Right(null));
    });

    test('should return UnexpectedFailure on exception', () async {
      when(mockRepository.getVenues()).thenThrow(Exception());

      final result = await useCase(testVenueName);

      expect(result, Left(UnexpectedFailure()));
    });
  });
}
