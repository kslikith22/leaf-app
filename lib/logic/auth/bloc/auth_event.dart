part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent extends Equatable {
  @immutable
  List get props => [];
}

class UserLoginEvent extends AuthEvent {
  final String name;
  final String email;
  final String profile_photo;
  UserLoginEvent({
    required this.email,
    required this.name,
    required this.profile_photo,
  });

  @immutable
  List get props => [name, email, profile_photo];
}
