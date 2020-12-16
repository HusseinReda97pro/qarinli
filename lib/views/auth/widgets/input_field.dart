import 'package:flutter/material.dart';
import 'package:qarinli/config/Palette.dart';

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final Function validator;
  final isPassword;
  InputField(
      {@required this.hint,
      @required this.validator,
      @required this.controller,
      @required this.isPassword});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: TextFormField(
          controller: controller,
          obscureText: isPassword,
          decoration: InputDecoration(
            hintText: hint,
            border: InputBorder.none,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(6.0)),
              borderSide: BorderSide(color: Palette.black),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(6.0)),
              borderSide: BorderSide(color: Palette.black),
            ),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(6.0)),
                borderSide: BorderSide(color: Colors.red),
                gapPadding: 100),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(18.0),
              ),
              borderSide: BorderSide(color: Palette.black),
            ),
          ),
          validator: validator,
        ),
      ),
    );
  }
}
