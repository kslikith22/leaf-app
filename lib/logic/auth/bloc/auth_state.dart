part of 'auth_bloc.dart';

@immutable
sealed class AuthState extends Equatable {
  @immutable
  List get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthLoginRequestSent extends AuthState {
  final String name;
  final String email;
  final String profilePicture;
  AuthLoginRequestSent(this.email, this.name, this.profilePicture);
}

class AuthLoginRequestSuccess extends AuthState {
  late AuthResponse authResponse;
  AuthLoginRequestSuccess({required this.authResponse});
}

class AuthLoginError extends AuthState {
  final String error;
  AuthLoginError({required this.error});
}

class AuthResetState extends AuthState{}
