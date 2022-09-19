
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget{
  String? text;
  VoidCallback? onTap;


  CustomButton({required this.text,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      child: MaterialButton(
        onPressed: onTap,
        child: Text(
          text!,
          style: TextStyle(color: Color(0xff2B475E), fontSize: 18.0),
        ),
      ),
    ) ;
  }

}