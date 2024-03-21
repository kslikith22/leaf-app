part of 'auth_bloc.dart';

@immutable
sealed class AuthState extends Equatable {
  @immutable
  List get props => [];
}

final class AuthInitial extends AuthState {}

final class AuthLoginRequestSent extends AuthState {}

final class AuthLoginRequestSuccess extends AuthState {
  late UserModel userModel;
  AuthLoginRequestSuccess({required this.userModel});
}

final class AuthLoginError extends AuthState {}
