// ignore_for_file: prefer_const_constructors, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'injection_container.dart' as di;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:refresh_token_flutter/states/auth_bloc.dart';
import 'package:refresh_token_flutter/screens/login_screen.dart';
import 'package:refresh_token_flutter/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di.init();
  runApp(MultiProvider(
    providers: [
      BlocProvider(create: (_) => di.sl<AuthBloc>()..add(AppStarted())),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Refresh Token',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is UserAuthenticated) {
              return HomeScreen();
            }
            return LoginScreen();
          },
        ));
  }
}
