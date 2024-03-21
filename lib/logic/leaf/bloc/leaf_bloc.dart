import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:leafapp/data/models/leaf_model.dart';
import 'package:leafapp/data/repository/leaf_repository.dart';

part 'leaf_event.dart';
part 'leaf_state.dart';

class LeafBloc extends Bloc<LeafEvent, LeafState> {
  final LeafRepository leafRepository;
  LeafBloc(this.leafRepository) : super(LeafInitial()) {
    on<LeafEvent>((event, emit) async {
      await _postLeafToPredict(event, emit);
    });
  }

  Future _postLeafToPredict(event, emit) async {
    emit(LeafPostingState());
    try {
      LeafModel predictionData =
          await leafRepository.postLeafToPredict(imageFile: event.imageFile);
      emit(LeafPostedState(leafModel: predictionData));
    } catch (e) {
      emit(LeafPostError());
    }
  }
}
