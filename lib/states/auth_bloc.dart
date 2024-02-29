// ignore_for_file: depend_on_referenced_packages, override_on_non_overriding_member, avoid_print

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:refresh_token_flutter/models/token_model.dart';
import 'package:refresh_token_flutter/repo/auth_repo.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepo authRepository;

  AuthBloc({
    required this.authRepository,
    required AuthState initialState,
  }) : super(initialState) {
    add(AppStarted());
  }
  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AppStarted) {
      try {
        yield InitializingUser();
        final bool hasToken = await authRepository.hasToken();

        if (hasToken) {
          final String userId = await authRepository.getUserId();

          yield UserAuthenticated(userId: userId);
        }
      } catch (e) {
        yield UserUnauthenticated();
      }
    }
    if (event is LogOut) {
      try {
        yield LoginingOut();
        await authRepository.deleteToken();
        yield UserUnauthenticated();
      } catch (e) {
        print(e);
        yield ErrorLoginingOut();
      }
    }
    if (event is LoginEvent) {
      try {
        yield LoginingIN();
        final bool isLoggedIn = await authRepository.login(event.email);
        if (isLoggedIn) {
          yield SuccessLoginingIN();
        }
      } catch (e) {
        print(e);
        yield ErrorLoginingIN();
      }
    }
    if (event is SubmitCodeEvent) {
      try {
        yield SubmittingCode();

        late final TokenModel tokenModel;
        tokenModel = await authRepository.submitCode(code: event.code);
        await authRepository.persistToken(
          accessToken: tokenModel.jwt.toString(),
          refreshToken: tokenModel.refreshToken.toString(),
        );
        final String userId = await authRepository.getUserId();
         
        yield SuccessSubmittingCode();
        yield UserAuthenticated(userId: userId);
      } catch (e) {
        print(e);
        yield ErrorSubmittingCode();
      }
    }
  }
}
