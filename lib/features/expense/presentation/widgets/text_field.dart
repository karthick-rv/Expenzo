import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String name;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;

  const CustomTextField(
      {super.key,
      required this.name,
      this.keyboardType = TextInputType.text,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 50),
        TextField(
          onChanged: onChanged,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: name,
            contentPadding: const EdgeInsets.all(10),
            border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 0.0),
            ),
          ),
        )
      ],
    );
  }
}
