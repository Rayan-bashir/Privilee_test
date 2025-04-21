import 'package:flutter/material.dart';
import 'package:new_project/features/venues/domain/entities/venue_filter_entity.dart';

void showFilterBottomSheet({
  required BuildContext context,
  required List<VenueFilterEntity> allFilters,
  required List<VenueFilterEntity> selectedFilters,
  required void Function(List<VenueFilterEntity>) onApply,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (ctx) {
      final tempSelected = [...selectedFilters];
      return _AnimatedBottomSheetContent(
        allFilters: allFilters,
        tempSelected: tempSelected,
        onApply: onApply,
      );
    },
  );
}

class _AnimatedBottomSheetContent extends StatefulWidget {
  final List<VenueFilterEntity> allFilters;
  final List<VenueFilterEntity> tempSelected;
  final void Function(List<VenueFilterEntity>) onApply;

  const _AnimatedBottomSheetContent({
    required this.allFilters,
    required this.tempSelected,
    required this.onApply,
  });

  @override
  State<_AnimatedBottomSheetContent> createState() =>
      _AnimatedBottomSheetContentState();
}

class _AnimatedBottomSheetContentState
    extends State<_AnimatedBottomSheetContent> {
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() => setState(() => _visible = true));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSlide(
      offset: _visible ? Offset.zero : const Offset(0, 1),
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOutCubic,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        padding: const EdgeInsets.all(16),
        child: FractionallySizedBox(
          heightFactor: 0.75,
          child: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: widget.allFilters.length,
                      itemBuilder: (context, index) {
                        final filter = widget.allFilters[index];
                        return _FilterSection(
                          filter: filter,
                          selectedFilters: widget.tempSelected,
                          onChanged: (updated) {
                            setState(() {
                              widget.tempSelected.removeWhere(
                                (f) => f.name == filter.name,
                              );
                              if (updated.categories?.isNotEmpty ?? false) {
                                widget.tempSelected.add(updated);
                              }
                            });
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            widget.onApply([]);
                          },
                          child: const Text("Clear All"),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton(
                          key: const Key('apply_filters_button'),
                          onPressed: () {
                            Navigator.pop(context);
                            widget.onApply(widget.tempSelected);
                          },
                          child: const Text("Apply Filters"),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _FilterSection extends StatelessWidget {
  final VenueFilterEntity filter;
  final List<VenueFilterEntity> selectedFilters;
  final ValueChanged<VenueFilterEntity> onChanged;

  const _FilterSection({
    required this.filter,
    required this.selectedFilters,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final selected =
        selectedFilters
            .firstWhere(
              (f) => f.name == filter.name,
              orElse: () => const VenueFilterEntity(),
            )
            .categories
            ?.map((c) => c.id)
            .toSet();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(filter.name ?? '', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children:
                (filter.categories ?? []).map((category) {
                  final isSelected = selected?.contains(category.id) ?? false;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: FilterChip(
                      label: Text(category.name ?? ''),
                      selected: isSelected,
                      onSelected: (value) {
                        final updatedCategories = [
                          ...?selected?.map(
                            (id) => filter.categories!.firstWhere(
                              (c) => c.id == id,
                            ),
                          ),
                        ];

                        if (value) {
                          updatedCategories.add(category);
                        } else {
                          updatedCategories.removeWhere(
                            (c) => c.id == category.id,
                          );
                        }

                        onChanged(
                          VenueFilterEntity(
                            name: filter.name,
                            type: filter.type,
                            categories: updatedCategories,
                          ),
                        );
                      },
                    ),
                  );
                }).toList(),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
