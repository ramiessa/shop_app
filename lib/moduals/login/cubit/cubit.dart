import 'package:earthcuacke/moduals/login/cubit/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/Login_model.dart';
import '../../../remote/dio.dart';

class LoginScreenCubit extends Cubit<LoginStates> {
  LoginScreenCubit() : super(LoginInitialState());
  static LoginScreenCubit get(context) => BlocProvider.of(context);
  ShopLoginModel? user;
  //function for  login
  void login({
    required String email,
    required String password,
  }) {
    emit(LoginLoading());
    DioHelper.postData(
        url: "login",
        data: {"email": email, "password": password}).then((value) {
      user = ShopLoginModel.fromJson(value.data);

      emit(LoginSuccess(user!));
    }).catchError((Error) {
      print(Error.toString());
      emit(Loginerror());
    });
  }

  bool obscureText = true;
  IconData suffix = Icons.visibility;
  void change() {
    obscureText = !obscureText;
    suffix = obscureText ? Icons.visibility : Icons.visibility_off_outlined;
    emit(ChangeObsocureText());
  }
}
