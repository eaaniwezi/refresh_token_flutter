// ignore_for_file: must_be_immutable, prefer_const_constructors_in_immutables

part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthEvent {}

class LogOut extends AuthEvent {}

class LoginEvent extends AuthEvent {
  final String email;

  LoginEvent({required this.email});
}

class SubmitCodeEvent extends AuthEvent {

  final int code;

  SubmitCodeEvent({ required this.code});
}
