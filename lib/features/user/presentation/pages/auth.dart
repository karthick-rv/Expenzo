import 'package:expenzo/features/expense/presentation/pages/expense_list.dart';
import 'package:expenzo/features/user/data/user_model.dart';
import 'package:expenzo/features/user/presentation/bloc/auth_bloc.dart';
import 'package:expenzo/features/user/presentation/bloc/auth_event.dart';
import 'package:expenzo/features/user/presentation/bloc/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return AuthScreenState();
  }
}

class AuthScreenState extends State<AuthScreen> {
  final _form = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLogin = true;

  String? email;
  String? password;

  void _onButtonClick() {
    _form.currentState?.validate();
    if(isLogin){
      context
          .read<AuthBloc>()
          .add(SignInEvent(user: UserRequest(email: email!, password: password!)));
      return;
    }

    context
        .read<AuthBloc>()
        .add(SignUpEvent(user: UserRequest(email: email!, password: password!)));
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  showSnackBar(String message) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      SnackBar snackBar = SnackBar(
        content: Text(message),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Theme.of(context).colorScheme.surface,
          Theme.of(context).colorScheme.primary,
        ], begin: Alignment.center, end: Alignment.bottomRight),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
            key: _form,
            onChanged: () {
              Form.of(primaryFocus!.context!).save();
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Expenzo",
                  style: TextStyle(
                      fontSize: 30,
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 50),
                TextFormField(
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Email cannot be empty";
                    }

                    if (!value.contains("@")) {
                      return "Enter a valid mail";
                    }

                    return null;
                  },
                  decoration: const InputDecoration(
                      labelText: "Email", border: OutlineInputBorder()),
                  onSaved: (value) {
                    email = value;
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: passwordController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Password cannot be empty";
                    }

                    return null;
                  },
                  obscureText: true,
                  decoration: const InputDecoration(
                      labelText: "Password", border: OutlineInputBorder()),
                  onSaved: (value) {
                    password = value;
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    BlocConsumer<AuthBloc, AuthState>(builder: (context, state) {
                      return OutlinedButton(
                          onPressed: _onButtonClick,
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  const RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(5)))),
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.fromLTRB(30, 10, 30, 10))),
                          child: (() {
                            if (state.runtimeType == AuthLoading) {
                              return SizedBox(
                                height: 30,
                                child: CircularProgressIndicator(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              );
                            }
                            return Text(
                              isLogin? "Login": "Sign Up",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Theme.of(context).colorScheme.onSurface,
                                  fontWeight: FontWeight.bold),
                            );
                          })());
                    }, listener: (context, state) {
                      switch (state.runtimeType) {
                        case AuthSuccess:
                          if(state.userEntity?.isSignIn??false){
                            showSnackBar(state.userEntity!.token);
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => const ExpenseList(),
                              ),
                            );
                          }else{
                            showSnackBar("Signup Successful. Please login to continue");
                            setState(() {
                              email = "";
                              password = "";
                              // emailController.text = "";
                              passwordController.text = "";
                              isLogin = true;
                            });
                          }
                          break;
                        case AuthError:
                          showSnackBar(state.error!);
                          break;
                      }
                    }),
                    const SizedBox(width: 20),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isLogin = !isLogin;
                        });
                      },
                      child: Text(isLogin? "Sign Up": "Login", style: TextStyle(color: Theme.of(context).colorScheme.primary)),
                    ),
                  ],
                ),
              ],
            )),
      ),
    ));
  }
}
