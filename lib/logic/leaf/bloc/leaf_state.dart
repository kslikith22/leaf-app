part of 'leaf_bloc.dart';

sealed class LeafState extends Equatable {
  const LeafState();

  @override
  List<Object> get props => [];
}

final class LeafInitial extends LeafState {}

final class LeafPostingState extends LeafState {}

final class LeafPostedState extends LeafState {
  final LeafModel leafModel;
 const LeafPostedState({required this.leafModel});

  @immutable
  List<Object> get props => [leafModel];
}

final class LeafPostError extends LeafState {
  final String error;
 const LeafPostError({required this.error});
}
