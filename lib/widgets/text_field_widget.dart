// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final String label;
  final bool isCode;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  const TextFieldWidget({
    Key? key,
    required this.label,
    required this.isCode,
    required this.validator,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: TextFormField(
        controller: controller,
        validator: validator,
        keyboardType: isCode? TextInputType.number : TextInputType.emailAddress,
        decoration: InputDecoration(
          labelText: label,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide:
                BorderSide(color: Theme.of(context).iconTheme.color!, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide:
                BorderSide(color: Theme.of(context).focusColor, width: 2),
          ),
          border: OutlineInputBorder(
            gapPadding: 2,
            borderRadius: BorderRadius.circular(20),
          ),
          labelStyle: TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
