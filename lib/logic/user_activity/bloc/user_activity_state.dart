part of 'user_activity_bloc.dart';

sealed class UserActivityState extends Equatable {
  const UserActivityState();

  @override
  List<Object> get props => [];
}

final class UserActivityInitial extends UserActivityState {}

final class UserActivityPostingState extends UserActivityState {}

final class UserActivityPostedState extends UserActivityState {}

final class UserActivityPostError extends UserActivityState {
  final String error;
const  UserActivityPostError({required this.error});
}

final class UserActivityLoadingState extends UserActivityState {}

final class UserActivityLoadedState extends UserActivityState {
  final UserActivityModel userActivityModel;
 const UserActivityLoadedState({required this.userActivityModel});

  @override
  List<Object> get props => [userActivityModel];
}

final class UserActivityError extends UserActivityState {
  final String error;
 const UserActivityError({required this.error});
}
