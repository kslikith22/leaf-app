import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:leafapp/data/models/ai_model.dart';
import 'package:leafapp/data/repository/ai_description_repository.dart';

part 'ai_event.dart';
part 'ai_state.dart';

class AIBloc extends Bloc<AIEvent, AIState> {
  late AIRespository aiRepository;
  AIBloc(this.aiRepository) : super(AIInitial()) {
    on<AIEvent>((event, emit) async {
      await _generateData(event, emit);
    });
  }

  Future _generateData(event, emit) async {
    emit(AILoadingState());
    try {
      AIModel data =
          await aiRepository.generateData(className: event.className);
      emit(AILoadedState(aiModel: data));
    } catch (e) {
      emit(AIErrorState(error: e.toString()));
    }
  }
}
