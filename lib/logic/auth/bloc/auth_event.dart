part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent extends Equatable {
  @immutable
  List get props => [];
}

class UserLoginEvent extends AuthEvent {
  final String name;
  final String email;
  final String profilePicture;
  final String token;
  final String status;
  UserLoginEvent({
    required this.email,
    required this.name,
    required this.profilePicture,
    required this.status,
    required this.token,
  });

  @immutable
  List get props => [name, email, profilePicture, status, token];
}



class UserVerifyEvent extends AuthEvent {
  final String token;
  UserVerifyEvent({
    required this.token,
  });

  @immutable
  List get props => [token];
}

class UserLogoutEvent extends AuthEvent{}
