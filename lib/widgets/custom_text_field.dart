import 'package:flutter/material.dart';

class CustomFormTextField extends StatelessWidget {
   CustomFormTextField({this.labelText, this.onChanged, this.obscureText=false});

String? labelText;
Function(String)? onChanged;
bool? obscureText;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child:  TextFormField(
        obscureText: obscureText!,
         validator: (data){
        if(data!.isEmpty){
          return 'This field is required';
        }
      
      },
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: labelText,
          contentPadding: EdgeInsets.only(left:10.0)
        ),
      ),
    );
  }
}