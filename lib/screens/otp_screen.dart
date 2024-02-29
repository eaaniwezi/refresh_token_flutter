// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:refresh_token_flutter/screens/home_screen.dart';
import 'package:refresh_token_flutter/states/auth_bloc.dart';
import 'package:refresh_token_flutter/widgets/button_widget.dart';
import 'package:refresh_token_flutter/widgets/text_field_widget.dart';

class OtpScreen extends StatelessWidget {
  final _globalkey = GlobalKey<FormState>();
  final TextEditingController _otpController = TextEditingController();
  OtpScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
         if (state is ErrorSubmittingCode) {
          Fluttertoast.showToast(
            msg: 'Error Submitting Code',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.TOP,
            backgroundColor: Colors.red,
          );
        }
        if (state is SuccessSubmittingCode) {
          Fluttertoast.showToast(
            msg: 'Success Submitting Code',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.TOP,
            backgroundColor: Colors.green,
          );
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (_) => HomeScreen()), (route) => false);
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.3),
                Center(
                  child: Text(
                    "OTP\n\nCheck your mail for the code sent!!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextFieldWidget(
                  label: "OTP",
                  controller: _otpController,
                  isCode: true,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return "Cant be empty";
                    } else {
                      return null;
                    }
                  },
                ),
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    return state == SubmittingCode()
                        ? _text("Please Wait")
                        : ButtonWidget(
                            title: "Submit",
                            onTap: () {
                         
                              FormState? formState = _globalkey.currentState;
                              if (formState!.validate()) {
                                BlocProvider.of<AuthBloc>(context).add(
                                    SubmitCodeEvent(
                                       
                                        code: int.parse(_otpController.text)));
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
