import 'package:flutter/material.dart';

class DatePicker extends StatelessWidget {
  final DateTime selectedDate;
  final void Function(DateTime) onDatePicked;

  const DatePicker(
      {super.key, required this.selectedDate, required this.onDatePicked});

  @override
  Widget build(BuildContext context) {
    Future<void> selectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime(2015, 8),
          lastDate: DateTime(2101));
      if (picked != null && picked != selectedDate) {
        onDatePicked(picked);
      }
    }

    return Container(
        margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Expense Date",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
                width: 100,
                child: Text(selectedDate.toLocal().toString().split(" ")[0],
                    style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.start)),
            ElevatedButton(
                onPressed: () => {selectDate(context)},
                child: const Icon(Icons.date_range_rounded))
          ],
        ));
  }
}
