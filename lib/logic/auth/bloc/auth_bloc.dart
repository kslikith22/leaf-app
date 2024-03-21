import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:leafapp/data/models/user_model.dart';
import 'package:leafapp/data/repository/auth_repository.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthRepository authReository;
  AuthBloc(this.authReository) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) {
      _handleLogin(event, emit);
    });
  }

  Future _handleLogin(event, emit) async {
    await authReository.userLogin(
        name: event.name, image: event.image, email: event.email);
  }
}
