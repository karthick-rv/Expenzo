

import 'package:expenzo/core/resources/data_state.dart';
import 'package:expenzo/features/expense/data/expense_repository.dart';
import 'package:expenzo/features/expense/presentation/bloc/expense_event.dart';
import 'package:expenzo/features/expense/presentation/bloc/expense_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState>{

  final ExpenseRepository expenseRepository;

  ExpenseBloc(this.expenseRepository) : super(const ExpenseLoading()){
    on <GetExpenses> (onGetExpenses);
    on <AddExpense> (onAddExpense);
  }

  void onGetExpenses(GetExpenses event, Emitter<ExpenseState> emitter) async {
    await _getExpenses();
  }

  void onAddExpense(AddExpense event , Emitter<ExpenseState> emitter) async {
    expenseRepository.addExpense(event.expense!);
    await _getExpenses();
  }

  _getExpenses() async{
    final dataState = await expenseRepository.getExpenses();

    if(dataState is DataSuccess && dataState.data!.isNotEmpty){
      emit(ExpenseSuccess(dataState.data!));
    }

    if(dataState is DataFailed){
      emit(ExpenseError(dataState.error!));
    }
  }

}