// ignore_for_file: depend_on_referenced_packages

import 'package:get_it/get_it.dart';
import 'package:refresh_token_flutter/repo/auth_repo.dart';
import 'package:refresh_token_flutter/repo/dio_config.dart';
import 'package:refresh_token_flutter/states/auth_bloc.dart';

final sl = GetIt.I;

Future<void> init() async {
  sl.registerLazySingleton<AuthBloc>(() => AuthBloc(
      authRepository: sl<AuthRepo>(), initialState: sl<UserInitState>()));

  sl.registerLazySingleton<IApi>(() => Api());
  sl.registerLazySingleton<AuthRepo>(() => AuthRepo(client: sl<IApi>()));

  sl.registerLazySingleton<UserInitState>(() => UserInitState());
}
