

import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget{

  final String name;
  final void Function(String)? onChanged;

  const CustomTextField({super.key, required this.name , this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 50),
        TextField(
          onChanged: onChanged,
          decoration:
          InputDecoration.collapsed(hintText: name),
        )
      ],
    );
  }




}