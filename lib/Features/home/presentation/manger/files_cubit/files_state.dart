import 'package:equatable/equatable.dart';

// Events
abstract class FilesEvent extends Equatable {}

class FetchSelectedItems extends FilesEvent {
  final String userId;

  FetchSelectedItems(this.userId);

  @override
  List<Object?> get props => [userId];
}

// States
abstract class FilesState extends Equatable {}

class FilesInitial extends FilesState {
  @override
  List<Object?> get props => [];
}

class FilesLoading extends FilesState {
  @override
  List<Object?> get props => [];
}
class FilesNoData extends FilesState {
  @override
  List<Object?> get props => [];
}

class FilesLoaded extends FilesState {
  final List<Map<String, dynamic>> selectedItems;
  final bool isDone;

  FilesLoaded({required this.selectedItems, required this.isDone});

  @override
  List<Object?> get props => [selectedItems];
}

class FilesError extends FilesState {
  final String error;

  FilesError({required this.error});

  @override
  List<Object?> get props => [error];
}
class ItemMarkedAsDone extends FilesState {
  @override
  List<Object?> get props => [];
}