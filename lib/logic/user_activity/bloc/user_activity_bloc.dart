import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:leafapp/data/models/ai_model.dart';
import 'package:leafapp/data/models/leaf_model.dart';
import 'package:leafapp/data/models/user_activity_model.dart';
import 'package:leafapp/data/repository/user_activity_repository.dart';

part 'user_activity_event.dart';
part 'user_activity_state.dart';

class UserActivityBloc extends Bloc<UserActivityEvent, UserActivityState> {
  late UserActivityRepository userActivityRepository;
  UserActivityBloc(this.userActivityRepository) : super(UserActivityInitial()) {
    on<UserActivityPostEvent>((event, emit) async {
      await _postUserActivity(event, emit);
    });
    on<FetchUserActivity>((event, emit) async {
      await _fetchUserActivity(event, emit);
    });
  }

  Future _fetchUserActivity(event, emit) async {
    emit(UserActivityLoadingState());
    try {
      UserActivityModel activityData =
          await userActivityRepository.getUserActivity();
      emit(UserActivityLoadedState(userActivityModel: activityData));
    } catch (e) {
      emit(UserActivityError(error: e.toString()));
    }
  }

  Future _postUserActivity(event, emit) async {
    emit(UserActivityPostingState());
    try {
      await userActivityRepository.postUserActivity(
        className: event.leafModel.className,
        confidence: event.leafModel.confidence.toString(),
        imageUrl: event.leafModel.imageUrl,
        markedUrl: event.leafModel.markedUrl,
        heatmapUrl: event.leafModel.heatmapUrl,
        about: event.aiModel.about,
        prevention: event.aiModel.prevention,
      );
      emit(UserActivityPostedState());
    } catch (e) {
      emit(UserActivityPostError(error: e.toString()));
    }
  }
}
