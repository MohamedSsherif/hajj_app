import 'package:flutter/material.dart';

class CustomFormTextField extends StatelessWidget {
   const CustomFormTextField({super.key, this.labelText, this.onChanged, this.obscureText=false ,required  this.controller});

final String? labelText;
final Function(String)? onChanged;
final bool? obscureText;
final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText ?? false,
        validator: (data){
          if((((data?.isEmpty) ?? false) && labelText == "email" && (data?.contains("@") ?? false))){
            return 'This field is required';
          }
          return null;
        },
        onChanged: onChanged,
        decoration: InputDecoration(
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.orange
            ),
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            )
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          hintText: labelText,
          hintStyle: const TextStyle(color: Colors.white,),
        ),
        ),
    );
  }
}