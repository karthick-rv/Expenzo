import 'package:flutter/material.dart';

class DropDown<T> extends StatelessWidget {
  final List<T> list;
  final T dropdownValue;
  final Function(T?) onValueChanged;

  const DropDown(
      {super.key,
      required this.list,
      required this.dropdownValue,
      required this.onValueChanged});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 60,
      child: InputDecorator(
          decoration: const InputDecoration(border: OutlineInputBorder()),
          child: DropdownButtonHideUnderline(
              child: DropdownButton<T>(
            value: dropdownValue,
            icon: const Icon(Icons.arrow_drop_down),
            elevation: 16,
            style: const TextStyle(color: Colors.black),
            onChanged: (T? value) {
              onValueChanged(value);
            },
            borderRadius: BorderRadius.circular(5),
            items: list.map<DropdownMenuItem<T>>((T value) {
              return DropdownMenuItem<T>(
                value: value,
                child: Text(value as String),
              );
            }).toList(),
          ))),
    );
  }
}
