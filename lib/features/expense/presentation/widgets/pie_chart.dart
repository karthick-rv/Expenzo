import 'dart:ffi';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../domain/expense.dart';

class PieChartWidget extends StatefulWidget {
  late final Map<String, String> expenses;

  PieChartWidget(
      {super.key,
      required Map<ExpenseCategory, List<ExpenseEntity>> expenseMap}) {
    expenses = _buildChartData(expenseMap);
  }

  Map<String, String> _buildChartData(
      Map<ExpenseCategory, List<ExpenseEntity>> expenseMap) {
    return expenseMap.map((key, value) {
      var expenseSum = 0;
      for (var e in value) {
        expenseSum += e.amount;
      }
      return MapEntry(key.name, expenseSum.toString());
    });
  }

  @override
  State createState() {
    return PieChartState();
  }
}

class PieChartState extends State<PieChartWidget> {
  late List<PieChartSectionData> data;

  Map<String, Color> _chartColor(ExpenseCategory category){
    switch(category){
      case ExpenseCategory.food:
        return {
          "color" : Theme.of(context).colorScheme.primary,
          "textColor": Theme.of(context).colorScheme.onPrimary
        };
      case ExpenseCategory.rent:
        return {
          "color" : Theme.of(context).colorScheme.secondary,
          "textColor": Theme.of(context).colorScheme.onSecondary
        };
      case ExpenseCategory.dress:
        return {
          "color" : Theme.of(context).colorScheme.outline,
          "textColor": Theme.of(context).colorScheme.onPrimaryContainer
        };
      case ExpenseCategory.travel:
        return {
          "color" : Theme.of(context).colorScheme.inverseSurface,
          "textColor": Theme.of(context).colorScheme.onInverseSurface
        };
      case ExpenseCategory.entertainment:
        return {
          "color" : Theme.of(context).colorScheme.surface,
          "textColor": Theme.of(context).colorScheme.onSurface
        };
      case ExpenseCategory.miscellaneous:
        return {
          "color" : Theme.of(context).colorScheme.error,
          "textColor": Theme.of(context).colorScheme.onError
        };
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      width: 250,
      height: 250,
      child: Center(
          child: PieChart(
        PieChartData(
          centerSpaceRadius: double.infinity,
          sections: widget.expenses.entries.map((entry) {
            return PieChartSectionData(
              value: double.tryParse(entry.value),
              color: _chartColor(ExpenseCategory.values.firstWhere((element) => element.name==entry.key))["color"],
              title: entry.key,
              titleStyle: TextStyle(
                  color:  _chartColor(ExpenseCategory.values.firstWhere((element) => element.name==entry.key))["textColor"],
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
            );
          }).toList(),
        ),
      )),
    );
  }
}
