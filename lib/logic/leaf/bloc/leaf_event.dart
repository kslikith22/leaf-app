part of 'leaf_bloc.dart';

sealed class LeafEvent extends Equatable {
  const LeafEvent();

  @override
  List<Object> get props => [];
}

class LeafPostEvent extends LeafEvent {
  final XFile imageFile;
  LeafPostEvent({required this.imageFile});

  @override
  List<Object> get props => [imageFile];
}

class LeafResetStateEvent extends LeafEvent{}

