import 'package:expenzo/features/expense/data/expense_repository_impl.dart';
import 'package:expenzo/features/expense/presentation/bloc/expense_bloc.dart';
import 'package:expenzo/features/expense/presentation/pages/expense_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
        create: (context) => ExpenseRepositoryImpl(),
        child: BlocProvider(
          create: (context) => ExpenseBloc(context.read<ExpenseRepositoryImpl>()),
          child: MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: const ExpenseList(),
          ),
        ));
  }
}
