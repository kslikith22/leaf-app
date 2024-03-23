part of 'ai_bloc.dart';

sealed class AIState extends Equatable {
  const AIState();

  @override
  List<Object> get props => [];
}

final class AIInitial extends AIState {}

final class AILoadingState extends AIState {}

final class AILoadedState extends AIState {
  final AIModel aiModel;
  AILoadedState({required this.aiModel});
  @override
  List<Object> get props => [aiModel];
}

final class AIErrorState extends AIState {
  final String error;
  AIErrorState({required this.error});
  @override
  List<Object> get props => [error];
}
