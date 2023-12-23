import 'package:flutter/material.dart';
import 'package:hostel_finder_admin/constants.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final IconData data;
  final String hintText;
  final String labelText;
  final TextInputType textInputType;
  final int? maxlines;
  final int? minlines;
  bool isObsecure = true;

  CustomTextField({
    Key? key,
    required this.controller,
    required this.data,
    required this.hintText,
    required this.isObsecure,
    required this.textInputType,
    required this.labelText,
    required this.maxlines,
    required this.minlines,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal:16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: isObsecure,
        keyboardType: textInputType,
        maxLines: maxlines,
        minLines: minlines,
        style: const TextStyle(
          color: Colors.white
        ),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(
            color: Colors.white
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          prefixIcon: Icon(
            data,
            color: Color(0xFF4FBE9F) ,
          ),
          focusColor: Color(0xFF4FBE9F) ,
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Colors.white
          ),
        ),
      ),
    );
  }
}
