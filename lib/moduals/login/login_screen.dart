import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:earthcuacke/moduals/home_screen/home_lyout.dart';
import 'package:earthcuacke/moduals/login/cubit/cubit.dart';
import 'package:earthcuacke/moduals/login/cubit/state.dart';
import 'package:earthcuacke/sherd/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../sherd/network/local/sherd_prefrence.dart';
import '../register/registrer.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String? _validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Username is required';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginScreenCubit(),
      child: BlocConsumer<LoginScreenCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginStates) {
            if (LoginScreenCubit.get(context).user!.status!) {
              CacheHelper.saveData(
                      key: 'token',
                      value: LoginScreenCubit.get(context).user!.data!.token)
                  .then((value) {
                if (value) {
                  showToast(
                      text: LoginScreenCubit.get(context).user?.message,
                      state: ToastStates.SUCCESS);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ShopLayout(),
                    ),
                  );
                }
              });
            } else {
              showToast(
                  text: LoginScreenCubit.get(context).user?.message,
                  state: ToastStates.ERROR);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Form(
              key: _formKey,
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        hintText: 'Username',
                        prefixIcon: Icon(
                          Icons.email_outlined,
                        ),
                      ),
                      validator: _validateUsername,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        prefixIcon: const Icon(
                          Icons.lock_outline,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            LoginScreenCubit.get(context).change();
                          },
                          icon: Icon(
                            LoginScreenCubit.get(context).suffix,
                          ),
                        ),
                      ),
                      obscureText: LoginScreenCubit.get(context).obscureText,
                      validator: _validatePassword,
                    ),
                    const SizedBox(height: 16),
                    ConditionalBuilder(
                      condition: state is! LoginLoading,
                      builder: (context) {
                        return ElevatedButton(
                          child: Container(
                              width: double.infinity,
                              height: 40,
                              child: const Center(
                                  child: Text(
                                style: TextStyle(fontSize: 20),
                                'Login',
                              ))),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              LoginScreenCubit.get(context).login(
                                  email: _usernameController.text,
                                  password: _passwordController.text);
                            }
                          },
                        );
                      },
                      fallback: (Context) {
                        return const CircularProgressIndicator();
                      },
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don\'t have an account?',
                        ),
                        Spacer(),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegistrationScreen()),
                            );
                          },
                          child: Text('Register'),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
