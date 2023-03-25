import '../../../models/Login_model.dart';

abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginLoading extends LoginStates {}

class LoginSuccess extends LoginStates {
  final ShopLoginModel user;
  LoginSuccess(this.user);
}

class Loginerror extends LoginStates {}

class ChangeObsocureText extends LoginStates {}
