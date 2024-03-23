part of 'ai_bloc.dart';

sealed class AIEvent extends Equatable {
  const AIEvent();

  @override
  List<Object> get props => [];
}

class GenerateData extends AIEvent {
  final String className;
  GenerateData({required this.className});

  @override
  List<Object> get props => [className];
}
