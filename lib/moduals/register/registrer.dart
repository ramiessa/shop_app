import 'package:earthcuacke/moduals/register/cubit/cubit.dart';
import 'package:earthcuacke/moduals/register/cubit/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrationScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  String? _name;

  String? _email;

  String? _password;

  String? _phoneNumber;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => RegisterScreenCubit(),
        child: BlocConsumer<RegisterScreenCubit, RegisrerStates>(
            listener: ((context, state) => {}),
            builder: ((context, state) {
              return Scaffold(
                appBar: AppBar(
                  title: Text('Register'),
                ),
                body: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            decoration: InputDecoration(labelText: 'Name'),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _name = value;
                            },
                          ),
                          SizedBox(height: 16),
                          TextFormField(
                            decoration: InputDecoration(labelText: 'Email'),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your email';
                              }
                              if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                                return 'Please enter a valid email address';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _email = value;
                            },
                          ),
                          SizedBox(height: 16),
                          TextFormField(
                            decoration: InputDecoration(labelText: 'Password'),
                            obscureText: true,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your password';
                              }
                              if (value.length < 6) {
                                return 'Password must be at least 6 characters';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _password = value;
                            },
                          ),
                          SizedBox(height: 16),
                          TextFormField(
                            decoration:
                                InputDecoration(labelText: 'Phone number'),
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your phone number';
                              }
                              if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                                return 'Please enter a valid 10-digit phone number';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _phoneNumber = value;
                            },
                          ),
                          SizedBox(height: 16),
                          ElevatedButton(
                            child: Text('Register'),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                // do something with the user's registration data, e.g. send it to a server
                                RegisterScreenCubit.get(context).Register(
                                    name: _name,
                                    email: _email,
                                    password: _password,
                                    phonenumber: _phoneNumber);
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            })));
  }
}
