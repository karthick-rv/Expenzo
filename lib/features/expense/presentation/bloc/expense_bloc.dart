
import 'package:expenzo/core/resources/data_state.dart';
import 'package:expenzo/features/expense/data/expense_repository.dart';
import 'package:expenzo/features/expense/presentation/bloc/expense_event.dart';
import 'package:expenzo/features/expense/presentation/bloc/expense_state.dart';
import 'package:expenzo/features/user/data/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState>{

  final ExpenseRepository expenseRepository;
  final UserRepository userRepository;

  ExpenseBloc(this.expenseRepository, this.userRepository) : super(const ExpenseLoading()){
    on <GetExpenses> (onGetExpenses);
    on <AddExpense> (onAddExpense);
    on <LogOutEvent> (onLogOutEvent);
  }

  void onGetExpenses(GetExpenses event, Emitter<ExpenseState> emitter) async {
    await _emitExpenses();
  }

  void onAddExpense(AddExpense event , Emitter<ExpenseState> emitter) async {

    final addExpenseState = await expenseRepository.addExpense(event.expense!);

    if(addExpenseState is DataSuccess){
      emit(AddExpenseSuccess());
    }else if(addExpenseState is DataFailed){
      emit(AddExpenseError(addExpenseState.error!));
    }
  }

  _emitExpenses() async{

    emit(const ExpenseLoading());

    final dataState = await expenseRepository.getExpenses();

    if(dataState is DataSuccess && dataState.data!=null){
      //Should use List.from for lists otherwise equatable wont work - https://stackoverflow.com/a/73305649
      emit(ExpenseSuccess(List.from(dataState.data!)));
    }

    if(dataState is DataFailed){
      emit(ExpenseError(dataState.data!, dataState.error!));
    }
  }

  void onLogOutEvent(LogOutEvent event, Emitter<ExpenseState> emitter) async{
    emit(LogOutLoading());
    var result = await userRepository.logOut();
    await Future.delayed(const Duration(seconds: 2));
    if(result is DataSuccess){
      emit(LogOutSuccess());
    }else{
      emit(LogOutError());
    }
  }

}