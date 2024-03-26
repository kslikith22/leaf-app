part of 'user_activity_bloc.dart';

sealed class UserActivityEvent extends Equatable {
  const UserActivityEvent();

  @override
  List<Object> get props => [];
}

class UserActivityPostEvent extends UserActivityEvent {
  final LeafModel leafModel;
  final AIModel aiModel;
  UserActivityPostEvent({required this.aiModel, required this.leafModel});

  @override
  List<Object> get props => [aiModel, leafModel];
}

class FetchUserActivity extends UserActivityEvent {}
