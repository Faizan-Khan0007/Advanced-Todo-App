
import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  final String texthint;
  final TextEditingController controller;
  final bool isobscureText;
   const AuthField({super.key,required this.texthint,required this.controller,this.isobscureText=false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10,right: 10),
       
      child: TextFormField(
        obscureText: isobscureText,
        controller: controller,
        validator: (value) {
             if(value!.isEmpty){//here ! is the non null assertion operator which will ensure that it is not null
                 return "$texthint is not filled";
             }
             return null;
          },
        decoration: InputDecoration(
          hintText: texthint,
          hintStyle: TextStyle(color: Colors.black, fontSize: 18),
          filled: true,
          fillColor: Color(0xFFEFEFEF),
          contentPadding: EdgeInsets.symmetric(
          vertical: 15, horizontal: 20,),
          border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}