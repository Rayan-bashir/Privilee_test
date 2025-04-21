import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_project/core/di/injection.dart';
import 'package:new_project/features/venue_details/presentation/screens/venue_details_screen.dart';
import 'package:new_project/features/venues/presentation/bloc/venue_bloc.dart';
import 'package:new_project/features/venues/presentation/bottom_sheets/show_filter_bottom_sheet.dart';
import 'package:new_project/features/venues/presentation/widgets/venue_card.dart';
import 'package:new_project/features/venues/presentation/widgets/venue_type_quick_filter_section.dart';

class VenueListScreen extends StatefulWidget {
  const VenueListScreen({super.key});

  @override
  State<VenueListScreen> createState() => _VenueListScreenState();
}

class _VenueListScreenState extends State<VenueListScreen> {
  late final VenueBloc _bloc;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _bloc = getIt<VenueBloc>()..add(InitVenuesEvent());

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        // TODO: Implement pagination here
      }
    });
  }

  @override
  void dispose() {
    _bloc.close();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: Scaffold(
        appBar: AppBar(title: const Text("Venues")),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: SizedBox(
          width: 75,
          child: FloatingActionButton(
            onPressed: () {
              final currentState = _bloc.state;

              if (currentState is VenueLoaded) {
                showFilterBottomSheet(
                  context: context,
                  allFilters: currentState.filters ?? [],
                  selectedFilters: currentState.selectedFilters ?? [],
                  onApply: (selected) {
                    _bloc.add(FilterVenuesEvent(selectedFilters: selected));
                  },
                );
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Icon(Icons.tune_outlined), Text("Filters")],
            ),
          ),
        ),
        body: SafeArea(
          child: BlocConsumer<VenueBloc, VenueState>(
            buildWhen: _buildWhen,
            listenWhen: _listenWhen,
            listener: _listener,
            builder: _builder,
          ),
        ),
      ),
    );
  }

  bool _buildWhen(VenueState previous, VenueState current) =>
      current is VenueLoaded || current is VenueLoading;

  bool _listenWhen(VenueState previous, VenueState current) =>
      current is VenueError;

  void _listener(BuildContext context, VenueState state) {
    if (state is VenueError) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(state.failure.message ?? '')));
    }
  }

  Widget _builder(BuildContext context, VenueState state) {
    if (state is VenueLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is VenueLoaded) {
      return Column(
        children: [
          if ((state.filters ?? []).isNotEmpty)
            VenueTypeQuickFilterSection(
              venueFilters: state.filters ?? [],
              selectedFilters: state.selectedFilters ?? [],
              onFilterChange: (filters) {
                _bloc.add(FilterVenuesEvent(selectedFilters: filters));
              },
            ),

          if (state.venues.isEmpty)
            Expanded(child: Center(child: Text("No venues found")))
          else
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  controller: _scrollController,
                  itemCount: state.venues.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: MediaQuery.of(context).size.height * 0.23,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 0.9,
                  ),
                  itemBuilder: (_, i) {
                    final venue = state.venues[i];
                    return VenueCard(
                      venue: venue,
                      onTap: () {
                        VenueDetailsScreen.navigate(context, venue.name ?? '');
                      },
                    );
                  },
                ),
              ),
            ),
        ],
      );
    }

    return const SizedBox.shrink();
  }
}
