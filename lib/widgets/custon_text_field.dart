import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  String hintText;
  bool isSecure, isHide;
  Function(String) fun;
  //VoidCallback setState ;
  CustomTextField(
      {required this.hintText, required this.fun, this.isSecure = false, this.isHide = true,});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isSecure,
      style: TextStyle(color: Colors.white),
      validator: (data) {
        if (data!.isEmpty) {
          return "Field can't be empty";
        }
      },
      onChanged: fun,
      decoration: InputDecoration(
        suffixIcon: isSecure
            ? isHide
                ? GestureDetector(
                    onTap: () {
                      isHide = false;
                    },
                    child: Icon(
                      Icons.remove_red_eye,
                      color: Colors.white,
                    ),
                  )
                : GestureDetector(
                    onTap: () {
                      isHide = true;
                    },
                    child: Icon(
                      Icons.remove_red_eye_outlined,
                      color: Colors.white,
                    ),
                  )
            : null,
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.white),
      ),
    );
  }
}
