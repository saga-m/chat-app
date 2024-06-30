import 'package:flutter/material.dart';
class CustomFormTextFiled extends StatelessWidget {
   CustomFormTextFiled({this.hintText , this.onChanged , this.obscureText =false});
  String? hintText;
  Function(String)? onChanged;

  bool? obscureText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText!,
      validator:(data)
      {
        if(data!.isEmpty){
          return 'filed is requred';
        }
      },
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle:TextStyle(
          color: Colors.white,
        ) ,
        enabledBorder:OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
