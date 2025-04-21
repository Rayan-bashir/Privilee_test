import 'package:equatable/equatable.dart';

class VenueFilterEntity extends Equatable {
  final String? name;
  final String? type;
  final List<FilterCategoryEntity>? categories;

  const VenueFilterEntity({this.name, this.type, this.categories});

  @override
  List<Object?> get props => [name, type, categories];
}

class FilterCategoryEntity extends Equatable {
  final String? id;
  final String? name;

  const FilterCategoryEntity({this.id, this.name});

  @override
  List<Object?> get props => [id, name];
}
