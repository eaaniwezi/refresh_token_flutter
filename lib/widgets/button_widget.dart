// ignore_for_file: unused_import, library_prefixes, prefer_if_null_operators, prefer_const_constructors

import 'package:flutter/material.dart';


class ButtonWidget extends StatelessWidget {
  final String title;
  final Function onTap;
  const ButtonWidget({
    Key? key,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal:40,
      ),
      child: InkWell(
        highlightColor: Colors.transparent,
        focusColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: () {
          onTap();
        },
        child: Container(
          height: 54,
           
          decoration: BoxDecoration(
            color:Colors.blue,
            borderRadius: BorderRadius.circular(20),
           
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color:  Colors.black  ,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}