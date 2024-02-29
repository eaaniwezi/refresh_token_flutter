// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:refresh_token_flutter/screens/otp_screen.dart';
import 'package:refresh_token_flutter/states/auth_bloc.dart';
import 'package:refresh_token_flutter/widgets/button_widget.dart';
import 'package:refresh_token_flutter/widgets/text_field_widget.dart';

class LoginScreen extends StatelessWidget {
  final _globalkey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is ErrorLoginingIN) {
          Fluttertoast.showToast(
            msg: 'Error Loggin In',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.TOP,
            backgroundColor: Colors.red,
          );
        }
        if (state is SuccessLoginingIN) {
          Fluttertoast.showToast(
            msg: 'A code has been sent to your mail',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.TOP,
            backgroundColor: Colors.green,
          );
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (_) => OtpScreen()), (route) => false);
        }
      },
      child: Scaffold(
          body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Form(
          key: _globalkey,
          child: SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.3),
                _text("Login"),
                TextFieldWidget(
                  label: "Email",
                  controller: _emailController,
                  isCode: false,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      Pattern pattern =
                          r'^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                      RegExp regex = RegExp(pattern.toString());
                      if (!regex.hasMatch(value)) {
                        return "Please make sure your email address is valid";
                      } else {
                        return null;
                      }
                    }
                    return null;
                  },
                ),
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    return state == LoginingIN()
                        ? _text("Please Wait")
                        : ButtonWidget(
                            title: "Login",
                            onTap: () {
                              FormState? formState = _globalkey.currentState;
                              if (formState!.validate()) {
                                BlocProvider.of<AuthBloc>(context).add(
                                    LoginEvent(email: _emailController.text));
                              }
                            });
                  },
                )
              ],
            ),
          ),
        ),
      )),
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
