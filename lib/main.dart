import 'package:dio/dio.dart';
import 'package:expenzo/features/expense/data/expense_repository_impl.dart';
import 'package:expenzo/features/expense/data/remote/expense_api_service.dart';
import 'package:expenzo/features/expense/presentation/bloc/expense_bloc.dart';
import 'package:expenzo/features/expense/presentation/pages/expense_list.dart';
import 'package:expenzo/features/user/data/local/user_preferences.dart';
import 'package:expenzo/features/user/data/remote/user_service.dart';
import 'package:expenzo/features/user/data/user_repository_impl.dart';
import 'package:expenzo/features/user/presentation/bloc/auth_bloc.dart';
import 'package:expenzo/features/user/presentation/pages/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/expense/data/local/app_database.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final database =
      await $FloorAppDatabase.databaseBuilder('flutter_database.db').build();
  final dio = Dio();
  final client = ExpenseApiService(dio);
  final userService = UserService(dio);
  var accessToken = await UserPreferences().getAccessToken();

  runApp(MyApp(
    database: database,
    apiClient: client,
    userService: userService,
    accessToken: accessToken,
  ));
}

class MyApp extends StatefulWidget {
  late AppDatabase database;
  late ExpenseApiService apiClient;
  late UserService userService;
  late String? accessToken;

  MyApp(
      {super.key,
      required this.database,
      required this.apiClient,
      required this.userService,
      required this.accessToken});

  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => UserRepositoryImpl(userService: widget.userService),
      child: RepositoryProvider(
        create: (context) => ExpenseRepositoryImpl(
            expenseDao: widget.database.expenseDAO,
            expenseApiService: widget.apiClient),
        child: MultiBlocProvider(
            providers: [
              BlocProvider(
                  create: (context) => ExpenseBloc(
                      context.read<ExpenseRepositoryImpl>(),
                      context.read<UserRepositoryImpl>())),
              BlocProvider(
                  create: (context) =>
                      AuthBloc(context.read<UserRepositoryImpl>()))
            ],
            child: Builder(
              builder: (context) {
                return MaterialApp(
                  title: 'Flutter Demo',
                  theme: ThemeData().copyWith(
                      useMaterial3: true,
                      colorScheme: ColorScheme.fromSeed(
                          seedColor: const Color.fromRGBO(30, 32, 130, 1.0))),
                  home: widget.accessToken == null
                      ? const AuthScreen()
                      : const ExpenseList(),
                );
              },
            )),
      ),
    );
  }
}
