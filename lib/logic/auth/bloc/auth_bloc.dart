import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:leafapp/data/models/user_model.dart';
import 'package:leafapp/data/repository/auth_repository.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthRepository authRepository;
  AuthBloc(this.authRepository) : super(AuthInitial()) {
    on<UserLoginEvent>((event, emit) async {
      await _handleLogin(event, emit);
    });
    on<UserVerifyEvent>((event, emit) async {
      await _verifyUser(event, emit);
    });
  }

  Future _handleLogin(event, emit) async {
    emit(AuthLoadingState());
    try {
      AuthResponse response = await authRepository.userLogin(
        name: event.name,
        profilePicture: event.profilePicture,
        email: event.email,
      );
      emit(AuthLoginRequestSuccess(authResponse: response));
    } catch (e) {
      emit(AuthLoginError(error: e.toString()));
    }
  }

  Future _verifyUser(event, emit) async {
    emit(AuthLoadingState());
    try {
      AuthResponse response =
          await authRepository.verifyUser(token: event.token);
      emit(AuthLoginRequestSuccess(authResponse: response));
    } catch (e) {
      emit(AuthLoginError(error: e.toString()));
    }
  }
}
