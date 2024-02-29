// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:refresh_token_flutter/screens/login_screen.dart';
import 'package:refresh_token_flutter/states/auth_bloc.dart';
import 'package:refresh_token_flutter/widgets/button_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is ErrorLoginingOut) {
          Fluttertoast.showToast(
            msg: 'Error Loggin Out',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.TOP,
            backgroundColor: Colors.red,
          );
        }
        if (state is UserUnauthenticated) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => LoginScreen()),
              (route) => false);
        }
      },
      child: Scaffold(
        bottomNavigationBar: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return state == LoginingIN()
                ? _text("Logging out")
                : ButtonWidget(
                    title: "LogOut",
                    onTap: () {
                      BlocProvider.of<AuthBloc>(context).add(LogOut());
                    });
          },
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.3),
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  if (state is UserAuthenticated) {
                    return _text(state.userId.toString());
                  }
                  return _text("$state");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  _text(label) {
    return Center(
      child: Text(
        label,
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
