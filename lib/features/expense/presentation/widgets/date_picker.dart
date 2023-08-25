

import 'package:flutter/material.dart';

class DatePicker extends StatelessWidget{

  final DateTime selectedDate = DateTime.now();
  final void Function(DateTime) onDatePicked;

  DatePicker({super.key,  required this.onDatePicked });

  @override
  Widget build(BuildContext context) {

    Future<void> selectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime(2015, 8),
          lastDate: DateTime(2101));
      if (picked != null && picked != selectedDate) {
        onDatePicked(selectedDate);
      }
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
            width: 200,
            child: Text(selectedDate.toLocal().toString(),
                textAlign: TextAlign.start)),
        const SizedBox(width: 20),
        ElevatedButton(
            onPressed: () => {selectDate(context)},
            child: const Icon(Icons.date_range_rounded))
      ],
    );
  }

}