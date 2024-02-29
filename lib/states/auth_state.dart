// ignore_for_file: prefer_const_constructors_in_immutables

part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class UserInitState extends AuthState {}

class InitializingUser extends AuthState {}

class UserAuthenticated extends AuthState {
  final String userId;
  UserAuthenticated({
    required this.userId,
  });
}

class UserUnauthenticated extends AuthState {}

//
class LoginingOut extends AuthState {}

class ErrorLoginingOut extends AuthState {}

//
class LoginingIN extends AuthState {}

class SuccessLoginingIN extends AuthState {}

class ErrorLoginingIN extends AuthState {}

//
class SubmittingCode extends AuthState {}

class SuccessSubmittingCode extends AuthState {}

class ErrorSubmittingCode extends AuthState {}
